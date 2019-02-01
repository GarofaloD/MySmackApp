//
//  ChatViewController.swift
//  SmackApp
//
//  Created by Daniel Garofalo on 1/16/19.
//  Copyright © 2019 Daniel Garofalo. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //MARK:- Outlets
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var channelNameLbl: UILabel!
    @IBOutlet weak var messageTextBox: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var typingUsersNotificationLbl: UILabel!
    
    
    
    //MARK:- Properties
    var isTyping = false
    

    //MARK:- Load Up Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Class that will allow the whole view to shift up when tapping on the Message text field
        view.bindToKeyboard()
        
        //gesture recognizer to dissmiss the keyboard
        gestureRecognizer()
        
        //Send button to be hidden by default
        sendButton.isHidden = true
        
        //Reveal VC config call
        menuButton.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer((self.revealViewController()?.panGestureRecognizer())!)
        self.view.addGestureRecognizer((self.revealViewController()?.tapGestureRecognizer())!)
        
        //Notification Observer. We are going to be listening for this notification (change on user log in status)
        NotificationCenter.default.addObserver(self, selector: #selector(ChatViewController.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        
        //Notification Observer. We are going to be listening for this notification (the selection of a channel on ChannelVC)
        NotificationCenter.default.addObserver(self, selector: #selector(ChatViewController.channelSelected(_:)), name: NOTIF_CHANNELS_SELECTED, object: nil)
        
        //If login status is true, broadcast change on te status of the user and repopulate the data
        if AuthService.instance.isLoggedIn{
            AuthService.instance.findUserByEmail { (success) in
                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
            }
        }
        
        
        //Socket call to update table view automatically with each message sent
        SocketService.instance.getChatMessage { (success) in
            if success {
                self.tableView.reloadData()
                //If there is more than one message on the array
                if MessageService.instance.messages.count > 0 {
                    //Create an element that will be set to the last object on the array...
                    let endIndex = IndexPath(row: MessageService.instance.messages.count - 1, section: 0)
                    //... and scroll to it on the bottom of the table
                    self.tableView.scrollToRow(at: endIndex, at: .bottom, animated: false)
                }
            }
        }
        
        //Socket call to check who is typing
        SocketService.instance.getTypingUsers { (typingUsers) in
            
            //Check that everyone is on the same channel
            guard let channelId = MessageService.instance.selectedChannel?.id else {return}
            var names = "" //This is the var that wil hold the name of the user typing
            var numbersOfTypers = 0
            
            //Checking for the user ad the channel on the array
            for (typingUser, channel) in typingUsers {
                //making sure that he typer is not ourselves on the channel that we are currently located...
                if typingUser != UserDataService.instance.name && channel == channelId {
                    //And if this is the first typer on the channel...
                    if names == "" {
                        names = typingUser
                    } else {
                        //otherwise, we have to add the past typerr and the current typer
                        names = "\(names), \(typingUser)"
                        numbersOfTypers += 1
                    }
                }
            }
            
            //Verb to be displayed on the labelIf there have been typer and we are logged in
            if numbersOfTypers > 0 && AuthService.instance.isLoggedIn == true {
                
                var verb = "is"
                
                if numbersOfTypers > 1{
                    verb = "are"
                }
                self.typingUsersNotificationLbl.text = "\(names) \(verb) typing..."
            } else {
                self.typingUsersNotificationLbl.text  = ""
            }
        }
        

        
        //Tableview load up
        tableView.delegate = self
        tableView.dataSource = self
        
        //Cell height auto dimension
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableView.automaticDimension

    }
    
    
    
    //MARK:- TableView functions
    //Number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.messages.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //Content of rows
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as? MessageCell{
            let message = MessageService.instance.messages[indexPath.row]
            cell.configureCell(message: message)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    

    
    //MARK:- Buttons
    @IBAction func sendMessageWhenPressed(_ sender: UIButton) {
        //Only send messages if logged in
        if AuthService.instance.isLoggedIn{
            
            //Check for the channel and the message on the fiekd
            guard let channelId = MessageService.instance.selectedChannel?.id else {return}
            guard let message = messageTextBox.text else {return}
            
            //Pass values required by API
            SocketService.instance.addMessage(messageBody: message, userId: UserDataService.instance.id, channelId: channelId) { (success) in
                //Once succeeded: clear the box, hide the keyboard and send message to the api that marks end of typing
                if success {
                    self.messageTextBox.text = ""
                    self.messageTextBox.resignFirstResponder()
                    SocketService.instance.socket.emit("stopType", UserDataService.instance.name, channelId) //As required by the API
                }
            }
        }
    }
    
    
    //Hide send button if there is no text or there is no typing on the message field
    @IBAction func messageBoxEditing(_ sender: UITextField) {
        
        //Necessary to get the id of the channel
        guard let channelId = MessageService.instance.selectedChannel?.id else {return}
        
        if messageTextBox.text == "" {
            isTyping = false
            sendButton.isHidden = true
            SocketService.instance.socket.emit("stopType", UserDataService.instance.name, channelId) //As required by the API
        } else {
            if isTyping == false {
                sendButton.isHidden = false
                SocketService.instance.socket.emit("startType", UserDataService.instance.name, channelId)
            }
            isTyping = true
        }
    }
    

    //MARK:- Custom Functions
    //Base functions for Notif center
    @objc func userDataDidChange(_ notification: Notification){
        //Everytime the notification changes, info on the screen will too
        if AuthService.instance.isLoggedIn {
            //get Channels
            onLogIInGetMessages()
        } else {
            channelNameLbl.text = "Please, log in"
            tableView.reloadData()
        }
    }
    
    
    func onLogIInGetMessages(){
        MessageService.instance.findAllChannels { (success) in
            if success {
                //If there are channels for this username, set up the first channel on the ara as the first on the table, check the name and set it up on the table
                if MessageService.instance.channels.count > 0 {
                    MessageService.instance.selectedChannel = MessageService.instance.channels[0]
                    self.updateWithChannel()
                } else {
                    self.channelNameLbl.text = "No channel yet"
                }
            }
        }
    }
    
    
    //Base function for notification center
    @objc func channelSelected(_ notif: Notification) {
        updateWithChannel()
    }
    
    //Subfunction for notification. Grab the name of the channel (if empty, set up blank value), set up the name on the channel name and get the messages from that channel
    func updateWithChannel(){
        let channelName = MessageService.instance.selectedChannel?.channelTitle ?? ""
        channelNameLbl.text = "#\(channelName)"
        getMessages()
    }

    //Getting the messages
    func getMessages(){
        //Check on the channel ID. if found...
        guard let channelId = MessageService.instance.selectedChannel?.id else {return}
        //...run the get call 
        MessageService.instance.findAllMessagesForChannel(channelID: channelId) { (success) in
            
            if success {
                //If we find messages, reload table view
                self.tableView.reloadData()
            }
            
          }
    }
        
        
    
    //MARK:- Gesture recognizer / Keyboard
    func gestureRecognizer(){
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ChatViewController.handleTap))
        view.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(){
        view.endEditing(true)
    }
    
        
    
    
    
    
    
    
    
    
    
    
    
    
    
}
