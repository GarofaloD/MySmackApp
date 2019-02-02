//
//  MessageCell.swift
//  SmackApp
//
//  Created by Daniel Garofalo on 1/31/19.
//  Copyright © 2019 Daniel Garofalo. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    //MARK:- Outlets  --- This structure is based on the API
    @IBOutlet weak var userImg: CircleImage!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var timeStampLbl: UILabel!
    @IBOutlet weak var messageBodyLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    //Set up elements on the message cell
    func configureCell(message: Message){
        
        messageBodyLbl.text = message.message
        userNameLbl.text = message.userName
        //timeStampLbl.text = message.timeStamp
        userImg.image = UIImage(named: message.userAvatar)
        userImg.backgroundColor = UserDataService.instance.returnUIColor(components: message.userAvatarColor)
        
        //Tomestam needs to be reformatted from the one that come on the api response (iso8601)
        guard var isoDate = message.timeStamp else {return}
        
        //Eliminate extra characters
        let end = isoDate.index(isoDate.endIndex, offsetBy: -5)
        isoDate = String(isoDate[..<end])
        
        //Bringing the date formatter aggan and applying it to our reformatted date and adding the last ccharacter (as specified on the API)
        let isoFormatter = ISO8601DateFormatter()
        let chatDate = isoFormatter.date(from: isoDate.appending("Z"))
        
        //Then, we need to customize the date format to our liking
        let newFormatter = DateFormatter()
        newFormatter.dateFormat = "MMM d, h: mm a"
        
        //And if w have a final date, create a final date from the string conversion of teh formatter and update the timestamp label on the cell
        if let finalDate = chatDate {
            let finalDate = newFormatter.string(from: finalDate)
            timeStampLbl.text = finalDate
            
        }
    }
}
