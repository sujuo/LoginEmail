//
//  BaseService.swift
//  Version1Test
//
//  Created by Shalom Ononuju on 19/03/2016.
//  Copyright © 2016 Shalom Ononuju. All rights reserved.
//

import Foundation
import Firebase

let BASE_URL = "https://version1test.firebaseio.com"
let FIREBASE_REF = Firebase(url: BASE_URL)

var CURRENT_USER: Firebase
{
    let userID = NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String
    
    let currentUser = Firebase(url: "\(FIREBASE_REF)").childByAppendingPath("users").childByAppendingPath(userID)
    
    return currentUser!
}
//get unique identifier from user and store in variable current user

