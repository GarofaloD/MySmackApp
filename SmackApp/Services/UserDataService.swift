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
    
    //Decryprion of value on the avatar color in the DB so can be reintegraded on any part of the app
    func returnUIColor(components: String) -> UIColor{
        
        //Scanner looks for particular charactars on a string
        let scanner = Scanner(string: components)
        //Delimitations and conditions for the scanner: skip these characters and scan up to (comma, in this case)
        let skipped = CharacterSet(charactersIn: "[], ")
        let comma = CharacterSet(charactersIn: ",")
        
        scanner.charactersToBeSkipped = skipped
        
        //We need to save the values of each scan into different values
        var r, g, b, a : NSString?
        scanner.scanUpToCharacters(from: comma, into: &r)
        scanner.scanUpToCharacters(from: comma, into: &g)
        scanner.scanUpToCharacters(from: comma, into: &b)
        scanner.scanUpToCharacters(from: comma, into: &a)
        
        //We also need a failsafe color in case the conversion and extraction works
        let defaultColor = UIColor.lightGray
        //Orifinal variables come in optionals and need to be unrwapped
        guard let rUnwrapped = r else {return defaultColor}
        guard let gUnwrapped = g else {return defaultColor}
        guard let bUnwrapped = b else {return defaultColor}
        guard let aUnwrapped = a else {return defaultColor}
        
        //...then passed as CGFloat
        let rFloat = CGFloat(rUnwrapped.doubleValue)
        let gFloat = CGFloat(gUnwrapped.doubleValue)
        let bFloat = CGFloat(bUnwrapped.doubleValue)
        let aFloat = CGFloat(aUnwrapped.doubleValue)
        
        //Integration of the CGFloar from different colors into a new color
        let newUIColor = UIColor(red: rFloat, green: gFloat, blue: bFloat, alpha: aFloat)
        
        return newUIColor
    }
    
    
    

    
}
