//
//  Game.swift
//  IOSMBD2App
//
//  Created by Adam el Hassan on 03/04/2019.
//  Copyright © 2019 Adam el Hassan. All rights reserved.
//

import Foundation

struct GamesData : Codable {
    var games : [GameData]
}

struct GameData : Codable {
    var _id : String
    var status : String
    var users  : [UserData]
}
