//
//  KisiError.swift
//  KisiBeacon
//
//  Created by Suyash Taneja on 12/11/17.
//  Copyright © 2017 Suyash Taneja. All rights reserved.
//

import Foundation

enum KisiError: Error {
    case unknown
    case unauthorize
}

extension KisiError {
    var alertMessage: String {
        switch self {
        case .unknown:
            return ""
        case .unauthorize:
            return ""
        }
    }
}
