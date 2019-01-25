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
    

    //MARK:- Properties
    

    //MARK:- Load Up Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuButton.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        
        self.view.addGestureRecognizer((self.revealViewController()?.panGestureRecognizer())!)
        self.view.addGestureRecognizer((self.revealViewController()?.tapGestureRecognizer())!)
        
        //If login status is true, broadcast change on te status of the user and repopulate the data
        if AuthService.instance.isLoggedIn{
            AuthService.instance.findUserByEmail { (success) in
                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
            }
        }
        
        
        MessageService.instance.findAllChannels { (success) in
            if success {
                
            }
        }
        
    }
    

    //MARK:- Buttons
    
    
    
    
    
    //MARK:- Custom Functions
    
    
    
    
    

}
