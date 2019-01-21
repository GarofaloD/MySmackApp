//
//  AvatarPickerViewController.swift
//  SmackApp
//
//  Created by Daniel Garofalo on 1/21/19.
//  Copyright © 2019 Daniel Garofalo. All rights reserved.
//

import UIKit

class AvatarPickerViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {


    //MARK:- Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    //MARK:- Properties
    var avatarType = AvatarType.dark
    
    //MARK:- Load Up Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Collection view loading
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    
    //MARK:- CollectionView Functions
    //Number of items
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 28 //Exact number of assets to be displayed here
    }
    
    //Number of sections
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //Content of Items
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "avatarCell", for: indexPath) as? AvatarCell{
            //"configureCell" comes from AvatarCell.swift
            cell.configureCell(index: indexPath.item, avatarType: avatarType)
            return cell
        }
        return UICollectionViewCell()
    }
    
    //Dimension of cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var numberOfcolumns : CGFloat = 3
        
        if UIScreen.main.bounds.width > 320 { //320px is the size of the smallest iphone
            numberOfcolumns = 4
        }
        
        let spaceBetweenCells : CGFloat = 10
        let padding : CGFloat = 40
        let cellDimension = ((collectionView.bounds.width - padding) - (numberOfcolumns - 1) * spaceBetweenCells) / numberOfcolumns
        
        return CGSize(width: cellDimension, height: cellDimension)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if avatarType == .dark {
            UserDataService.instance.setAvatarname(avatarName: "dark\(indexPath.item)")
        } else {
            UserDataService.instance.setAvatarname(avatarName: "light\(indexPath.item)")
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    
    
    //MARK:- Buttons
    @IBAction func returnToAcctCreationWenPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    //Segment control for Dark/Light avatar selection
    @IBAction func segmentChangeWhenPressed(_ sender: UISegmentedControl) {
        if segmentControl.selectedSegmentIndex == 0 {
            avatarType = .dark
        } else {
            avatarType = .light
        }
        collectionView.reloadData()
    }
    
   
    
    

}
