//
//  MessageService.swift
//  SmackApp
//
//  Created by Daniel Garofalo on 1/25/19.
//  Copyright © 2019 Daniel Garofalo. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MessageService {
    
    //MARK: Singleton
    static let instance = MessageService()
    
    //MARK: Properties
    var channels = [Channel]()
    var messages = [Message]()
    var selectedChannel : Channel?
    
    //MARK:- Channel requests in / out
    //Network request to get channels
    func findAllChannels(completion: @escaping CompletionHandler){
        
        Alamofire.request(URL_GET_CHANNELS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: HEADER_WITH_BEARER).responseJSON { (response) in
            
            if response.result.error == nil {
                //Parsing response as JSON
                guard let data = response.data else { return }
                
                //Respnse from API comes as an array. Therefore, it is important to cast the json as an array as well
                if let json = JSON(data: data).array {
                    //We need to sweep on all elements from the array to find the right value with a "FOR" loop and add elements to the array of channels
                    for item in json{
                        let name = item["name"].stringValue
                        let channelDescription = item["description"].stringValue
                        let id = item["_id"].stringValue
                        
                        //Adding the values to an object of Channels and append to the channles array
                        let channel = Channel(channelTitle: name, channelDescription: channelDescription, id : id)
                        self.channels.append(channel)
                    }
                }
                //Notify the ChannelVC that channels were found
                NotificationCenter.default.post(name: NOTIF_CHANNELS_LOADED, object: nil)
                print(self.channels)
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    //Request to clear channels.This is meant to run if we are loggin out
    func clearChannels(){
        channels.removeAll()
    }

    
    //MARK:- Message requests in / out
    //Find all messages on a channel
    func findAllMessagesForChannel(channelID: String, completion: @escaping CompletionHandler){
    
        Alamofire.request("\(URL_GET_MESSAGES)\(channelID)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: HEADER_WITH_BEARER).responseJSON { (response) in
            
            if response.result.error == nil {
                //clear all messages so new messages from a different channel can be loaded into the same array
                self.clearMessages()
                
                guard let data = response.data else {return}
                
                if let json = JSON(data: data).array {
                    for item in json{
                        let messageBody = item["messageBody"].stringValue
                        let channelID = item["channelId"].stringValue
                        let id = item["_id"].stringValue
                        let userName = item["userName"].stringValue
                        let userAvatar = item["userAvatar"].stringValue
                        let userAvatarColor = item["userAvatarColor"].stringValue
                        let timeStamp = item["timeStamp"].stringValue
                        
                        let message = Message(message: messageBody, userName: userName, channelID: channelID, userAvatar: userAvatar, userAvatarColor: userAvatarColor, id: id, timeStamp: timeStamp)
                        self.messages.append(message)
                    }
                }
                print(self.messages)
                completion(true)
            } else {
                
                debugPrint(response.result.error as Any)
                completion(false)
            }
        }
    }
    
    //Request to clear all messages
    func clearMessages(){
        messages.removeAll()
    }
    
    
    
    
    
    
    
    
}
