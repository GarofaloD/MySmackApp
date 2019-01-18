//
//  RoundedButton.swift
//  SmackApp
//
//  Created by Daniel Garofalo on 1/18/19.
//  Copyright © 2019 Daniel Garofalo. All rights reserved.
//

import UIKit
@IBDesignable

class RoundedButton: UIButton {

    //MARK:- Properties
    @IBInspectable var cornerRadius: CGFloat = 3.0 {
        didSet{
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    //MARK:- Load up Functions
    override func awakeFromNib() {
        super .awakeFromNib()
        
        self.setupView()
    }
    
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        self.setupView()
    }
    
    
    //MARK:- Custom Functions
    func setupView(){
        self.layer.cornerRadius = cornerRadius
    }
    
    
    
    


}
