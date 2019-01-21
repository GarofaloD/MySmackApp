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
            return cell
        }
        return UICollectionViewCell()
    }
    
    
    
    
    //MARK:- Buttons
    @IBAction func returnToAcctCreationWenPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func segmentChangeWhenPressed(_ sender: UISegmentedControl) {
    }
    
    
    

}
