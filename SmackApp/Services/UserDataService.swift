//
//  UserDataService.swift
//  SmackApp
//
//  Created by Daniel Garofalo on 1/20/19.
//  Copyright © 2019 Daniel Garofalo. All rights reserved.
//

import Foundation

class UserDataService {
    
    //MARK:- Singleton
    
    static let instance = UserDataService()
    
    //MARK:- Properties
    private(set) public var id = ""
    private(set) public var avatarColor = ""
    private(set) public var avatarName = ""
    private(set) public var email = ""
    private(set) public var name = ""
    
    //MARK:- Custom Functions
    //Setting name and properties for these value sthat we will need for authentiucate
    func setUserData(id : String, color: String, avatarName: String, email: String, name: String){
        self.id = id
        self.avatarColor = color
        self.avatarName = avatarName
        self.email = email
        self.name = name
    }

    //To change the avatarName with Notification Center
    func setAvatarname(avatarName: String){
        self.avatarName = avatarName
    }
    

    
}
