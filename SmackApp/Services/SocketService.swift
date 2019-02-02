//
//  SocketService.swift
//  SmackApp
//
//  Created by Daniel Garofalo on 1/26/19.
//  Copyright © 2019 Daniel Garofalo. All rights reserved.
//

import UIKit
import SocketIO

class SocketService: NSObject {

    //MARK:- Singleton
    static let instance = SocketService()
    
    //MARK:- Socket creation
    //Socket io requires a socket manager and a socket client ALWAYS!
    let manager : SocketManager
    let socket : SocketIOClient
    
    
    override init(){
        //Socket components init
        self.manager = SocketManager(socketURL: URL(string: BASE_URL)!)
        self.socket = manager.defaultSocket
        
        super .init()
    }
    
    
    //MARK:- Socket Functions
    func establishConnection(){ //Called on AppDelegate on "applicationDidBecomeActive"
        socket.connect()
    }
    
    func closeConnection(){ // Called on AppDelegate on "applicationWillTerminate"
        socket.disconnect()
    }
    
    //MARK:- Socket Functions - Channels
    //Emition (sending) of message from the app to the server. API requires a specific message with 2 main components: channel name and description
    func addChannel(channelName: String, channelDescription: String, completion: @escaping CompletionHandler){
        
        //Emition of message and verification
        socket.emit("newChannel", channelName, channelDescription)
        completion(true)
        
    }
    
    //.ON to receive channels from the server
    func getChannel(completion: @escaping CompletionHandler){
        //Declaration of the .On,
        //We need to receive an array of data that will come with three pieces of info for each channel: Name, Description and ID. We also need to check the acknowledgement
        socket.on("channelCreated") { (dataArray, ack) in //"channelCreated" is the name of the event according tothe api
            
            //Parsing elements of the array onto separate values
            guard let channelName = dataArray[0] as? String else {return}
            guard let channelDesc = dataArray[1] as? String else {return}
            guard let channelId = dataArray[2] as? String else {return}
            
            //Creation of a new channel, appending on the array of channels and check for completion
            let newChannel = Channel(channelTitle: channelName, channelDescription: channelDesc, id: channelId)
            MessageService.instance.channels.append(newChannel)
            completion(true)
        }
    }
    
    //MARK:- Socket Functions - Messages
    //Adding / sending the message
    func addMessage(messageBody: String, userId: String, channelId: String, completion: @escaping CompletionHandler ){
        
        //Connection to the instance so we dont have to ty ethe whole thing every time
        let user = UserDataService.instance
        
        socket.emit("newMessage", messageBody, userId, channelId, user.name, user.avatarName, user.avatarColor)
        completion(true)
    }
    
    
    //.ON to receive messages from the server
    //In this case, the completion handler is looking for a message. Which means that a successful connection proof is to get a new message
    func getChatMessage(completion: @escaping (_ newMessage: Message) -> Void){
        //Declaration of the .On,
        //We need to receive an array of data that will come with several pieces of info for each message. We also need to check the acknowledgement of receival
        socket.on("messageCreated") { (dataArray, ack) in //"messageCreated" is the name of the event according tothe api
            
            //Parsing elements of the array onto separate values
            guard let msgBody = dataArray[0] as? String else {return}
            guard let channelId = dataArray[2] as? String else {return} //This one has position number 2 on the array.We are not saving pos 1
            guard let userName = dataArray[3] as? String else {return}
            guard let userAvatar = dataArray[4] as? String else {return}
            guard let userAvatarColor = dataArray[5] as? String else {return}
            guard let id = dataArray[6] as? String else {return}
            guard let timeStamp = dataArray[7] as? String else {return}
            
            //Creating a new Message object
            let newMessage = Message(message: msgBody, userName: userName, channelID: channelId, userAvatar: userAvatar, userAvatarColor: userAvatarColor, id: id, timeStamp: timeStamp)
            
            //And acknowledging the completion with the new message
            completion(newMessage)
        }
    }
    
    
    //MARK:- Typing users
    //The completion handler looks for a dictionary where we are looking for a dictionary (typing user: channel)
    func getTypingUsers(_ completionHandler: @escaping (_ typingUsers: [String: String]) -> Void) {
        //Listening for the user typing
        socket.on("userTypingUpdate") { (dataArray, ack) in
            //Parsing the data from the respondin array
            guard let typingUsers = dataArray[0] as? [String:String] else {return}
            //Acknowledging the completion
            completionHandler(typingUsers)
        }
    }
    
    
    
    
    
    
    
    
    
}
