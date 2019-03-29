//
//  Artist.swift
//  TestWork
//
//  Created by BernsteinArts on 8/16/18.
//  Copyright © 2018 Almas Kairatuly. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Artist {
    private var id  : Int
    var avatarURL   : URL
    var firstName   : String
    var lastName    : String?
    var genre       : String
    var bio         : String
    var quote       : String?
    
    init?(_ json: JSON) {
        // MARK: required fields
        guard let id        = json["id"].int else { return nil }
        guard let urlString = json["avatar"].string else { return nil }
        guard let avatarURL = URL(string: urlString) else {return nil }
        guard let firstName = json["firstName"].string else { return nil }
        guard let genre     = json["genre"].string else { return nil }
        guard let bio       = json["bio"].string else { return nil }
        
        self.id         = id
        self.avatarURL  = avatarURL
        self.firstName  = firstName
        self.genre      = genre
        self.bio        = bio
        
        // MARK: optional fields
        self.lastName   = json["lastName"].string
        self.quote      = json["quote"].string
    }
}
