//
//  User.swift
//  KisiBeacon
//
//  Created by Suyash Taneja on 10/11/17.
//  Copyright © 2017 Suyash Taneja. All rights reserved.
//

import UIKit

struct User {
    var firstName: String?
    var lastName: String?
    
    var fullName: String {
        return (firstName ?? "") + ((firstName == nil) ? "" : " ") + (lastName ?? "")
    }
    var image: UIImage?
    
}
