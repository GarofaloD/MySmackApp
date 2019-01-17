//
//  GradientView.swift
//  SmackApp
//
//  Created by Daniel Garofalo on 1/16/19.
//  Copyright © 2019 Daniel Garofalo. All rights reserved.
//

import UIKit
@IBDesignable


class GradientView: UIView {

    //MARK:- Properties
    
    //Spectrum of colors to be used
    @IBInspectable var topColor: UIColor = UIColor.blue {
        didSet { //property observer for the top color to be updated and reloaded when changed on the IB
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable var bottomColor: UIColor = UIColor.green {
        didSet { //property observer for the top color to be updated and reloaded when changed on the IB
            self.setNeedsLayout()
        }
    }
    
    //Init of the gradient
    override func layoutSubviews() {
        let gradientLayer = CAGradientLayer() //Creation of the layer
        
        //Implementation of the colors
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        
        //Positioning of the gradient by coordinates
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        
        //Size of the gradient
        gradientLayer.frame = self.bounds
        
        //Calling of the properties with this function
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    
    
    //MARK:- Load Up functions
    override func awakeFromNib() {
        super .awakeFromNib()
        
        
    }
    
    
    
    
    
    
}
