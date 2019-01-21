//
//  AvatarCell.swift
//  SmackApp
//
//  Created by Daniel Garofalo on 1/21/19.
//  Copyright © 2019 Daniel Garofalo. All rights reserved.
//

import UIKit

class AvatarCell: UICollectionViewCell {
    
    //MARK:- CollectionView Functions
    @IBOutlet weak var avatarImg: UIImageView!
    
    
    
    //MARK:- Load Up Functions
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupView()
    }
    
    
    //MARK:- Custom Functions
    func setupView(){
        self.layer.backgroundColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
    
    
    
}
