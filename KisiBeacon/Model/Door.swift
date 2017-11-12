//
//  Door.swift
//  KisiBeacon
//
//  Created by Suyash Taneja on 12/11/17.
//  Copyright © 2017 Suyash Taneja. All rights reserved.
//

import Foundation

enum DoorState: String, Codable {
    case unlocked = "Unlocked!"
    case locked
}

struct Door: Codable {
    var state: DoorState?
    
    enum CodingKeys: String, CodingKey {
        case state = "message"
    }
}
