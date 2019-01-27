//
//  ChannelViewController.swift
//  SmackApp
//
//  Created by Daniel Garofalo on 1/16/19.
//  Copyright © 2019 Daniel Garofalo. All rights reserved.
//

import UIKit

class ChannelViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    

    //MARK:- Outlets
    
    @IBOutlet weak var userImage: CircleImage!
    @IBOutlet weak var loginButton: UIButton!
    @IBAction func prepareForUnwind(segue:UIStoryboardSegue){} //This IBAction is for the unwind from the "Create Account VC"
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    //MARK:- Properties
    
    
    
    
    
    
    
    //TableView Functions
    //Number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.channels.count
    }
    
    //Content of rows
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "channelCell", for: indexPath) as? ChannelCell{
            let channel = MessageService.instance.channels[indexPath.row]
            cell.configureCell(channel: channel)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    
    
    
    //MARK:- Load up functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tableview load delegation
        tableView.dataSource = self
        tableView.delegate = self
        
        //Retractable VC configuration
        self.revealViewController()?.rearViewRevealWidth = self.view.frame.size.width - 60
        
        //Notification Observer. We are going to be listening for this notification
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelViewController.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
    
        //Checking for new channels
        SocketService.instance.getChannel { (success) in
            if success {
                self.tableView.reloadData()
            }
        }
        
    }
    
    
    
    
    
    //Refreshing info on the VC based on the currebt state of the app, bypassing the notification. Useful to keep info on the VC even if we close it
    override func viewDidAppear(_ animated: Bool) {
        setupUserInfo()
    }
    

    
    
    
    //MARK:- Buttons
    @IBAction func loginWhenPressed(_ sender: UIButton) {
        if AuthService.instance.isLoggedIn == true {
            //Show profile page / xib
            let profile = ProfileViewController() //
            profile.modalPresentationStyle = .custom
            present(profile, animated: true, completion: nil)
        } else {
            performSegue(withIdentifier: GO_TO_LOGIN, sender: nil)
        }
        
    }
    
    @IBAction func addChannelWhenPressed(_ sender: UIButton) {
        //Method to present XIBs
        let addChannel = AddChannelViewController()
        addChannel.modalPresentationStyle = .custom
        present(addChannel, animated: true, completion: nil)
    }
    
    
    
    
    //MARK:- Custom functions
    //Notification observer base function. 
    @objc func userDataDidChange(_ notification: Notification){
        //Everytime the notification changes, info on the screen will too
        setupUserInfo()
    }
    
    
    //Base configuration for information display on the user
    func setupUserInfo(){
        if AuthService.instance.isLoggedIn {
            //If logged in bring in Name, avatar and custom background color (converted with .returnUIColor)
            loginButton.setTitle(UserDataService.instance.name, for: .normal)
            userImage.image = UIImage(named: UserDataService.instance.avatarName)
            userImage.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
        } else {
            loginButton.setTitle("Login", for: .normal)
            userImage.image = UIImage(named: "menuProfileIcon")
            userImage.backgroundColor = UIColor.clear
        }
    }
    

    
    
    
    
}
