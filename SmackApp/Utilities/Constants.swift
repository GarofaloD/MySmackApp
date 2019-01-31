//
//  Constants.swift
//  SmackApp
//
//  Created by Daniel Garofalo on 1/16/19.
//  Copyright © 2019 Daniel Garofalo. All rights reserved.
//

import Foundation

//Completion Handler
typealias CompletionHandler = (_ Success: Bool) -> () //Closure to determine if call passed or not

//URLS
let BASE_URL = "https://smackappdaniel.herokuapp.com/v1/"
let URL_REGISTER = "\(BASE_URL)/account/register"
let URL_LOGIN = "\(BASE_URL)/account/login"
let URL_ADD_USER = "\(BASE_URL)/user/add"
let URL_USER_BY_EMAIL = "\(BASE_URL)/user/byEmail/"
let URL_GET_CHANNELS = "\(BASE_URL)/channel"
let URL_GET_MESSAGES = "\(BASE_URL)/message/byChannel/"




//Segues
let GO_TO_LOGIN = "goToLogin"
let GO_TO_CREATE_ACCOUNT = "goToCreateAccount"
let UNWIND = "unwindToChannel"
let GO_TO_AVATAR_PICKER = "goToAvatarPicker"

//User Defaults
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"


//Additional inputs for requests
let HEADER = [
    "Content-Type": "application/json; charset=utf-8"
]

let HEADER_WITH_BEARER = [
    "Authorization": "Bearer \(AuthService.instance.authToken)",
    "Content-Type": "application/json; charset=utf-8"
]


//Colors
let smackPurplePlaceholder = #colorLiteral(red: 0.3568627451, green: 0.6235294118, blue: 0.7960784314, alpha: 0.5)

//Notification Constants
let NOTIF_USER_DATA_DID_CHANGE = Notification.Name("notifUserDataChanged")
let NOTIF_CHANNELS_LOADED = Notification.Name("channelsLoaded")
let NOTIF_CHANNELS_SELECTED = Notification.Name("channelSelected")
