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
    
    
    //MARK:- Outlets
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var userImg: UIImageView!
    
    
    
    
    //MARK:- Custom functions
    
    //TableView Functions
    
    
    
    
    
    
    
    //MARK:- Load up functions
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    //MARK:- Buttons
    //to unwind all the way to Channel VC
    @IBAction func unwindWhenPressed(_ sender: UIButton) {
        //with connection with "prepareForUnwind" on the ChannelVC
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
    
    
    @IBAction func createAccountWhenPressed(_ sender: UIButton) {
         //User registration takes 3 steps: registration, logging and creation. All individual calls are coded on AuthService
        
        guard let email = emailTxt.text, emailTxt.text != "" else {return}
        guard let password = passwordTxt.text, passwordTxt.text != "" else {return}
        
        //Part1. Register the user
        AuthService.instance.registerUser(email: email, password: password) { (success) in
            if success {
                //Part2. Log in the user
                print("User Reg complete")
                AuthService.instance.loginUser(email: email, password: password, completion: { (success) in
                    if success {
                        
                        print("User log complete", AuthService.instance.authToken)
                    } else {
                        print("Issues with log in")
                    }
                })
            } else {
                print("Issues with registration")
            }
        }
    }
    
    
    
    @IBAction func chooseAvatarWhenPressed(_ sender: UIButton) {
    }
    
    @IBAction func generateBckColorWhenPressed(_ sender: UIButton) {
    }
    
    


}
