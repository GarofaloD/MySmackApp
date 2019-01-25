//
//  ChannelCell.swift
//  SmackApp
//
//  Created by Daniel Garofalo on 1/25/19.
//  Copyright © 2019 Daniel Garofalo. All rights reserved.
//

import UIKit

class ChannelCell: UITableViewCell {

    //MARK:- Properties
    @IBOutlet weak var channelName: UILabel!
    
    
    
    //MARK:- Properties
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    //MARK:- Cell properties
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {
           self.layer.backgroundColor = UIColor(white: 1, alpha: 0.2).cgColor
            
        } else {
            self.layer.backgroundColor = UIColor.clear.cgColor
        }
    }
    
    //Display title of the channel on the outlet
    func configureCell(channel: Channel){
        //nil coalescing = If there is no title name, set the text as blank
        let title = channel.channelTitle ?? ""
        channelName.text = "#\(title)"
    }
    
    

}
