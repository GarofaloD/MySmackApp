//
//  AuthService.swift
//  SmackApp
//
//  Created by Daniel Garofalo on 1/17/19.
//  Copyright © 2019 Daniel Garofalo. All rights reserved.
//

import Foundation
import Alamofire

class AuthService {
    
    //MARK:-  Singleton
    static let instance = AuthService()
    
    //MARK:-  Properties
    //To save state of the session
    let defaults = UserDefaults.standard
    
    //State of the session. Values to be used and passed on each REST call
    var isLoggedIn : Bool {
        get {
            return defaults.bool(forKey: LOGGED_IN_KEY)
        }
        set {
            defaults.set(newValue, forKey: LOGGED_IN_KEY)
        }
    }
    
    //Token for log in
    var authToken : String {
        get{
            return defaults.value(forKey: TOKEN_KEY) as! String
        }
        set {
            defaults.set(newValue, forKey: TOKEN_KEY)
        }
    }
    
    //Email used on the session
    var userEmail : String {
        get{
            return defaults.value(forKey: USER_EMAIL) as! String
        }
        set {
            defaults.set(newValue, forKey: USER_EMAIL)
        }
    }
    
    
    
    //MARK:-  Authorization Calls. In order:
    //1.Register User
    func registerUser(email: String, password: String, completion: @escaping CompletionHandler){
        
        let lowercasedEmail = email.lowercased()
        
        let header = [
            "Content-Type": "application/json; charset=utf-8"
        ]
        
        let body: [String: Any] = [
            "email": lowercasedEmail,
            "password": password
        ]
        
        //POST request
        Alamofire.request(URL_REGISTER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseString { (response) in
            
            if response.result.error == nil {
                
                print("request sent")
                completion(true)
            } else {
                
                completion(false)
                print("Error on the request")
                debugPrint(response.result.error as Any)
            }
        }
        
    }
    
    
    
    //2.Login User
    
    //3.Add user
    
    
    
    
    
    
    
}

