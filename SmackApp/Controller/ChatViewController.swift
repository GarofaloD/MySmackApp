//
//  ChatViewController.swift
//  SmackApp
//
//  Created by Daniel Garofalo on 1/16/19.
//  Copyright © 2019 Daniel Garofalo. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {

    //MARK:- Outlets
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var channelNameLbl: UILabel!
    
    

    //MARK:- Properties
    

    //MARK:- Load Up Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    }
    

    //MARK:- Buttons
    
    
    
    
    
    //MARK:- Custom Functions
    //Base functions for Notif center
    @objc func userDataDidChange(_ notification: Notification){
        //Everytime the notification changes, info on the screen will too
        if AuthService.instance.isLoggedIn {
            //get Channels
            onLogIInGetMessges()
        } else {
            channelNameLbl.text = "Please, log in"
        }
    }
    
    
    func onLogIInGetMessges(){
        MessageService.instance.findAllChannels { (success) in
            if success {
                //Do stuff with Channels
            }
        }
    }
    
    @objc func channelSelected(_ notif: Notification) {
        updateWithChannel()
        
    }
    
    func updateWithChannel(){
        let channelName = MessageService.instance.selectedChannel?.channelTitle ?? ""
        channelNameLbl.text = "#\(channelName)"
    }

}
