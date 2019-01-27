//
//  AddChannelViewController.swift
//  SmackApp
//
//  Created by Daniel Garofalo on 1/26/19.
//  Copyright © 2019 Daniel Garofalo. All rights reserved.
//

import UIKit

class AddChannelViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var channelName: UITextField!
    @IBOutlet weak var channelDescription: UITextField!
    @IBOutlet weak var bgView: UIView!
    
    
    
    
    
    // MARK: - LoadUp Functions
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }



    // MARK: - Buttons
    @IBAction func closeModalPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    

    @IBAction func createChannelWhenPressed(_ sender: RoundedButton) {
        
    }
    
    
    
    // MARK: - Custom functions
    //Initial visual config of the XIB
    func setupView(){
        
        //Dismissing the XIB
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(AddChannelViewController.closeTap(_:)))
        bgView.addGestureRecognizer(closeTouch)
        
        //Setting up color for the placeholder
        channelName.attributedPlaceholder = NSAttributedString(string: "Channel Name", attributes: [NSAttributedString.Key.foregroundColor: smackPurplePlaceholder])
        channelDescription.attributedPlaceholder = NSAttributedString(string: "Channel Description", attributes: [NSAttributedString.Key.foregroundColor: smackPurplePlaceholder])
    }
    
    //Subfunction for the gesture recognizer
    @objc func closeTap(_ recognizer: UITapGestureRecognizer){
        dismiss(animated: true, completion: nil)
    }
    

 

}
