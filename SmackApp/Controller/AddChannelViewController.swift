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
    @IBOutlet weak var channelNameTxt: UITextField!
    @IBOutlet weak var channelDescTxt: UITextField!
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
        
        //Verification of existance of data in the fields
        guard let channelName = channelNameTxt.text, channelNameTxt.text != "" else {return}
        guard let channelDescription = channelDescTxt.text else {return}
        
        SocketService.instance.addChannel(channelName: channelName, channelDescription: channelDescription) { (success) in
            
            if success {
                self.dismiss(animated: true, completion: nil)
            }
        }
        
        
    }
    
    
    
    // MARK: - Custom functions
    //Initial visual config of the XIB
    func setupView(){
        
        //Dismissing the XIB
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(AddChannelViewController.closeTap(_:)))
        bgView.addGestureRecognizer(closeTouch)
        
        //Setting up color for the placeholder
        channelNameTxt.attributedPlaceholder = NSAttributedString(string: "Channel Name", attributes: [NSAttributedString.Key.foregroundColor: smackPurplePlaceholder])
        channelDescTxt.attributedPlaceholder = NSAttributedString(string: "Channel Description", attributes: [NSAttributedString.Key.foregroundColor: smackPurplePlaceholder])
    }
    
    //Subfunction for the gesture recognizer
    @objc func closeTap(_ recognizer: UITapGestureRecognizer){
        dismiss(animated: true, completion: nil)
    }
    

 

}
