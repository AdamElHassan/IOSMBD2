//
//  User.swift
//  IOSMBD2App
//
//  Created by Adam el Hassan on 04/04/2019.
//  Copyright © 2019 Adam el Hassan. All rights reserved.
//

import Foundation

// Only the ID is needed so there is no reason to get all the data
struct UserData : Codable {
    var _id     : String
}
// The login API call only returns the username and password
// So a different codable is used for this
struct LoginUserData : Codable {
    var username : String
    var password : String
}
