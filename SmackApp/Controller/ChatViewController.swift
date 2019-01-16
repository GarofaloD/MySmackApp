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
        
    }
    

    //MARK:- Buttons
    
    
    
    
    
    //MARK:- Custom Functions
    
    
    
    
    

}
