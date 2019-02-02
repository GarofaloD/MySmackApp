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
    
    //Display title of the channel on the outlet and change the forn font on the channels tha have unread messages
    func configureCell(channel: Channel){
        //nil coalescing = If there is no title name, set the text as blank
        let title = channel.channelTitle ?? ""
        channelName.text = "#\(title)"
        channelName.font = UIFont(name: "HelveticaNeue-Regular", size: 17)
        
        //parse through the unread channels array to find an unread channel..
        for id in MessageService.instance.unreadChannels {
            //.. by comparing the id of the channel we are passing into this function with the channelid on the array and if it is the same...
            if id == channel.id {
                channelName.font = UIFont(name: "HelveticaNeue-Bold", size: 22)
            }
        }
    }
    
    

}
