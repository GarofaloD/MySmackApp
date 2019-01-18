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
    
    @IBAction func unwindWhenPressed(_ sender: UIButton) {
        //to unwind all the way to Channel VC
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
    
    @IBAction func createAccountWhenPressed(_ sender: UIButton) {
        
        guard let email = emailTxt.text, emailTxt.text != "" else {return}
        guard let password = passwordTxt.text, passwordTxt.text != "" else {return}
        
        
        AuthService.instance.registerUser(email: email, password: password) { (success) in
            
            if success {
                
                print("Registered user!")
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
