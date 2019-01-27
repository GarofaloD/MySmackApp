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
    
    //MARK:- Socket Functions
    //Emition of message from the app to the server. API requires a specific message with 2 main components: channel name and description
    func addChannel(channelName: String, channelDescription: String, completion: @escaping CompletionHandler){
        
        //Emition of message and verification
        socket.emit("newChannel", channelName, channelDescription)
        completion(true)
        
    }
    //.ON to receive channels from teh server
    func getChannel(completion: @escaping CompletionHandler){
        //Declaration of the .On,
        //We need to receive an array of data that will come with three pieces of info for each channel: Name, Description and ID. We also need to check the acknowledgement
        socket.on("channelCreated") { (dataArray, ack) in
            
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
    
    
    
}
