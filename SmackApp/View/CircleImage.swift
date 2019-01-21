//
//  CircleImage.swift
//  SmackApp
//
//  Created by Daniel Garofalo on 1/21/19.
//  Copyright © 2019 Daniel Garofalo. All rights reserved.
//

import UIKit
@IBDesignable

class CircleImage: UIImageView {

    
    
    
    //MARK:- Load Up Functions
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
    
    
    //MARK:- Custom Functions
    func setupView(){
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
    }
    

    
    
    
}
