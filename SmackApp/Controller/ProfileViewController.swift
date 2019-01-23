//
//  ProfileViewController.swift
//  SmackApp
//
//  Created by Daniel Garofalo on 1/22/19.
//  Copyright © 2019 Daniel Garofalo. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    //MARK:- Outlets
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    
    //MARK:- Load Up function
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    //MARK:- Buttons
    @IBAction func closeModalWhenPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    //Logout the user and notify data changes (that will be picked up by the observer on ChannelVC)
    @IBAction func logoutWhenPressed(_ sender: UIButton) {
        UserDataService.instance.logoutUser()
        NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        dismiss(animated: true, completion: nil)
    }

    
    
    //MARK:- Custom Functions
    //Call data to view on this VC
    func setupView(){
        userName.text = UserDataService.instance.name
        userEmail.text = UserDataService.instance.email
        profileImage.image = UIImage(named: UserDataService.instance.avatarName)
        profileImage.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
        
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(ProfileViewController.tapToDismiss))
        bgView.addGestureRecognizer(closeTouch)
        
    }
    
    //Base function for gesture recognizer
    @objc func tapToDismiss(_ recognizer: UITapGestureRecognizer){
        dismiss(animated: true, completion: nil)
    }
    
    

}
