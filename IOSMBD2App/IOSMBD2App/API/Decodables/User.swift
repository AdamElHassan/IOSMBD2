//
//  User.swift
//  IOSMBD2App
//
//  Created by Adam el Hassan on 04/04/2019.
//  Copyright © 2019 Adam el Hassan. All rights reserved.
//

import Foundation

struct UsersData : Codable {
    var users : [UserData?]
}

struct UserData : Codable {
    var isAdmin : Bool
    var _id     : String
}

struct LoginUserData : Codable {
    var username : String
    var password : String
}
