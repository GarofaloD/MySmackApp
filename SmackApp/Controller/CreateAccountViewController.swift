//
//  CreateAccountViewController.swift
//  SmackApp
//
//  Created by Daniel Garofalo on 1/17/19.
//  Copyright © 2019 Daniel Garofalo. All rights reserved.
//

import UIKit

class CreateAccountViewController: UIViewController {

    //MARK:- Properties
    var avatarColor = "[0.5,0.5,0.5,1]" //RGBA representation
    var avatarName = "profileDefault"
    var bgColor : UIColor?
    
    
    //MARK:- Outlets
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    
    
    //MARK:- Load up functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //Reloading avatar from saved value on Userdata service
        if UserDataService.instance.avatarName != "" {
            userImg.image = UIImage(named: UserDataService.instance.avatarName)
            avatarName = UserDataService.instance.avatarName
            
            if avatarName.contains("light") && bgColor == nil {
                userImg.backgroundColor = UIColor.lightGray
            }
        }
    }
    

    
    //TableView Functions
    

    //MARK:- Buttons
    //to unwind all the way to Channel VC
    @IBAction func unwindWhenPressed(_ sender: UIButton) {
        //with connection with "prepareForUnwind" on the ChannelVC
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
    
    //Account creation: User registration takes 3 steps: registration, logging and creation. All individual calls are coded on AuthService
    @IBAction func createAccountWhenPressed(_ sender: UIButton) {
        
        //Start spinner with click
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        //Verification of existance of basic information on the form
        guard let email = emailTxt.text, emailTxt.text != "" else {return}
        guard let password = passwordTxt.text, passwordTxt.text != "" else {return}
        guard let name = usernameTxt.text, usernameTxt.text != "" else { return }
        
        //Part1. Register the user
        AuthService.instance.registerUser(email: email, password: password) { (success) in
            if success {
                //Part2. Log in the user
                print("User Reg complete")
                AuthService.instance.loginUser(email: email, password: password, completion: { (success) in
                    if success {
                        //Part3. Create The user
                        print("User log complete", AuthService.instance.authToken)
                        AuthService.instance.createUser(name: name, email: email, avatarName: self.avatarName, avatarColor: self.avatarColor, completion: { (success) in
                            if success {
                                //Stop and hid spinner, dismiss VC and send us to the ChannelVC and post notification for user data change
                                print("User successfully created. User: \(UserDataService.instance.name), Email: \(UserDataService.instance.email) ")
                                self.activityIndicator.isHidden = true
                                self.activityIndicator.stopAnimating()
                                self.performSegue(withIdentifier: UNWIND, sender: nil)
                                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
                            }
                        })
                    } else {
                        print("Issues with log in")
                    }
                })
            } else {
                print("Issues with registration")
            }
        }
    }
    
    
    //Go to Avatar Selection
    @IBAction func chooseAvatarWhenPressed(_ sender: UIButton) {
        performSegue(withIdentifier: GO_TO_AVATAR_PICKER, sender: nil)
    }
    
    //Grenerate background for the avatar
    @IBAction func generateBckColorWhenPressed(_ sender: UIButton) {
        
        //Three individual colors for the custom color
        let r = CGFloat(arc4random_uniform(255)) / 255
        let g = CGFloat(arc4random_uniform(255)) / 255
        let b = CGFloat(arc4random_uniform(255)) / 255
        
        //Integration of the colors and application to the image with animation
        bgColor = UIColor(red: r, green: g, blue: b, alpha: 1)
        UIView.animate(withDuration: 0.2) {
            self.userImg.backgroundColor = self.bgColor
        }
    }
    
    //MARK:- Custom functions
    //C
    func setupView(){
        
        //Spinner for activity indicator
        activityIndicator.isHidden = true
        
        //Change placeholder text color
        usernameTxt.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [NSAttributedString.Key.foregroundColor: smackPurplePlaceholder])
        emailTxt.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: smackPurplePlaceholder])
        passwordTxt.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: smackPurplePlaceholder])
        
        //tap gesture recognizer to dismiss keyboard
        let tap = UITapGestureRecognizer(target: self, action: #selector(CreateAccountViewController.handleTap))
        view.addGestureRecognizer(tap)
        
    }
    
    //Base for gesture recognizer (dismiss keyboard)
    @objc func handleTap(){
        view.endEditing(true)
    }
    

}
