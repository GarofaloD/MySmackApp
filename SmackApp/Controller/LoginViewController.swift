//
//  LoginViewController.swift
//  SmackApp
//
//  Created by Daniel Garofalo on 1/17/19.
//  Copyright © 2019 Daniel Garofalo. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    //MARK:- Outlets
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK:- Properties
    
    
    
    //MARK:- Load up functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
    }
    
    
    

    //MARK:- Buttons
    @IBAction func closeWhenPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createAccountWhenPressed(_ sender: UIButton) {
        performSegue(withIdentifier: GO_TO_CREATE_ACCOUNT, sender: nil)
    }
    
    //User Log in: User log in takes 2 steps: login (to get an email and a token) and finding user by email, so all data from the API can be repopulated on UserDataService. All individual calls are coded on AuthService
    @IBAction func loginWhenPressed(_ sender: RoundedButton) {
        
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        guard let email = emailTxt.text, emailTxt.text != "" else { return }
        guard let password = passwordTxt.text, passwordTxt.text != "" else { return }
        
        //Part1.Log the user in
        AuthService.instance.loginUser(email: email, password: password) { (success) in
            if success {
                print("Login Successful")
                //Part2.Retrieve the data 
                AuthService.instance.findUserByEmail(completion: { (success) in
                    if success {
                        print("User data retrieved")
                        //Post notification that the user data changed, stop the spinner and dismiss the VC
                        NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
                        self.activityIndicator.isHidden = true
                        self.activityIndicator.stopAnimating()
                        self.dismiss(animated: true, completion: nil)
                    }
                })
            }
            
        }
            
            
            
            
            
        
        
    }
    

    
    //MARK:- Custom functions
    
    func setupView(){
        
        activityIndicator.isHidden = true
        
        emailTxt.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: smackPurplePlaceholder])
        passwordTxt.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: smackPurplePlaceholder])
        
        
    }
    
    
}
