//
//  ChannelViewController.swift
//  SmackApp
//
//  Created by Daniel Garofalo on 1/16/19.
//  Copyright © 2019 Daniel Garofalo. All rights reserved.
//

import UIKit

class ChannelViewController: UIViewController {

    //MARK:- Outlets
    
    @IBOutlet weak var userImage: CircleImage!
    @IBOutlet weak var loginButton: UIButton!
    @IBAction func prepareForUnwind(segue:UIStoryboardSegue){} //This IBAction is for the unwind from the "Create Account VC"
    
    
    
    
    //MARK:- Properties
    
    
    
    
    
    
    
    //TableView Functions
    
    
    
    
    //MARK:- Load up functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Retractable VC configuration
        self.revealViewController()?.rearViewRevealWidth = self.view.frame.size.width - 60
        
        //Notification Observer
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelViewController.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        
    }
    
    //Refreshing info on the VC based on the currebt state of the app, bypassing the notification. Useful to keep info on the VC even if we close it
    override func viewDidAppear(_ animated: Bool) {
        setupUserInfo()
    }
    

    //MARK:- Buttons
    @IBAction func loginWhenPressed(_ sender: UIButton) {
        if AuthService.instance.isLoggedIn == true {
            //Show profile page / xib
            let profile = ProfileViewController()
            profile.modalPresentationStyle = .custom
            present(profile, animated: true, completion: nil)
        } else {
            performSegue(withIdentifier: GO_TO_LOGIN, sender: nil)
        }
        
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
