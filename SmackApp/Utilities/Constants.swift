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




//Segues
let GO_TO_LOGIN = "goToLogin"
let GO_TO_CREATE_ACCOUNT = "goToCreateAccount"
let UNWIND = "unwindToChannel"

//User Defaults
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"


//Additional inputs for requests
let HEADER = [
    "Content-Type": "application/json; charset=utf-8"
]

