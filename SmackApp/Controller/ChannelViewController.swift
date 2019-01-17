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
    @IBOutlet weak var loginButton: UIButton!
    
    
    
    
    //MARK:- Properties
    
    
    
    
    
    //MARK:- Custom functions
    
    //TableView Functions
    
    
    
    
    //MARK:- Load up functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.revealViewController()?.rearViewRevealWidth = self.view.frame.size.width - 60
    }
    

    //MARK:- Buttons
    @IBAction func loginWhenPressed(_ sender: UIButton) {
        
        performSegue(withIdentifier: GO_TO_LOGIN, sender: nil)
        
    }
    
    

}
