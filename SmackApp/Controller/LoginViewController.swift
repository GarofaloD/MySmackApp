//
//  LoginViewController.swift
//  SmackApp
//
//  Created by Daniel Garofalo on 1/17/19.
//  Copyright © 2019 Daniel Garofalo. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    //MARK:- Properties
    
    
    
    
    
    //MARK:- Custom functions
    
    //TableView Functions
    

    
    
    
    
    
    
    //MARK:- Load up functions
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    

    //MARK:- Button
    @IBAction func closeWhenPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createAccountWhenPressed(_ sender: UIButton) {
        performSegue(withIdentifier: GO_TO_CREATE_ACCOUNT, sender: nil)
    }
    
    


}
