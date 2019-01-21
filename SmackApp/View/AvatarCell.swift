//
//  AvatarCell.swift
//  SmackApp
//
//  Created by Daniel Garofalo on 1/21/19.
//  Copyright © 2019 Daniel Garofalo. All rights reserved.
//

import UIKit

//To make reference to the two typed of assets : light and dar
enum AvatarType{
    case dark
    case light
}

class AvatarCell: UICollectionViewCell {
    
    //MARK:- CollectionView Functions
    @IBOutlet weak var avatarImg: UIImageView!
    
    
    //MARK:- Load Up Functions
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupView()
    }
    
    
    //MARK:- Custom Functions
    //Default general aspect configuration of the cel
    func setupView(){
        self.layer.backgroundColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
    
    //Image content of each cell depending on segmentation (configured on AvarPickerVC)
    func configureCell(index: Int, avatarType: AvatarType){
        if avatarType == AvatarType.dark {
            avatarImg.image = UIImage(named: "dark\(index)")
            self.layer.backgroundColor = UIColor.lightGray.cgColor
        } else {
            avatarImg.image = UIImage(named: "light\(index)")
            self.layer.backgroundColor = UIColor.gray.cgColor
        }
        
    }
    
    
}
