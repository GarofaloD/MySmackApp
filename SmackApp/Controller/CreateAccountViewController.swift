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
    
    
    //MARK:- Outlets
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var userImg: UIImageView!
    
    
    //MARK:- Load up functions
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //Reloading avatar from saved value on Userdata service
        if UserDataService.instance.avatarName != ""{
            userImg.image = UIImage(named: UserDataService.instance.avatarName)
            avatarName = UserDataService.instance.avatarName
        }
    }
    
    //MARK:- Custom functions
    
    //TableView Functions
    
    
    
    

    //MARK:- Buttons
    //to unwind all the way to Channel VC
    @IBAction func unwindWhenPressed(_ sender: UIButton) {
        //with connection with "prepareForUnwind" on the ChannelVC
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
    
    //Account creation
    @IBAction func createAccountWhenPressed(_ sender: UIButton) {
         //User registration takes 3 steps: registration, logging and creation. All individual calls are coded on AuthService
        
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
                                //Dismiss and send us to the ChannelVC
                                print("User successfully created. User: \(UserDataService.instance.name), Email: \(UserDataService.instance.email) ")
                                self.performSegue(withIdentifier: UNWIND, sender: nil)
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
    
    @IBAction func generateBckColorWhenPressed(_ sender: UIButton) {
    }
    
    


}
