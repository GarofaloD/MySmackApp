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
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func configureCell(message: Message){
        
        messageBodyLbl.text = message.message
        userNameLbl.text = message.userName
        //timeStampLbl.text = message.timeStamp
        userImg.image = UIImage(named: message.userAvatar)
        userImg.backgroundColor = UserDataService.instance.returnUIColor(components: message.userAvatarColor)
        
    }
    
    
    
    
    
    
}
