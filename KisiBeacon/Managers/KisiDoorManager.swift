//
//  KisiDoorManager.swift
//  KisiBeacon
//
//  Created by Suyash Taneja on 04/11/17.
//  Copyright © 2017 Suyash Taneja. All rights reserved.
//

import Foundation
import CoreLocation

extension URLRequest {
    mutating func authorize() {
     // tak header from keychan and add it to urlrequest
        var headers = allHTTPHeaderFields ?? [:]
        headers["Authorization"] = "KISI-LINK 75388d1d1ff0dff6b7b04a7d5162cc6c"
        allHTTPHeaderFields = headers
    }
}

class KisiDoorManager {
    static let shared = KisiDoorManager()
    
    func unlockDoor(clBeacon: CLBeacon, completion: @escaping (Bool, Error?) -> ()) {
        guard let url = URL(string: "https://api.getkisi.com/locks/5873/access") else {return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.authorize()
        
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest) { (data, urlResponse, error) in
            guard error == nil else {
                let error = error!
                DispatchQueue.main.sync {
                    completion(false, error)
                }
                print("Got error")
                return
            }
            guard let data = data else {
                DispatchQueue.main.sync {
                    completion(false, KisiError.unknown)
                }
                print("sent request")
                return
            }
            let decoder = JSONDecoder()
            let door = try? decoder.decode(Door.self, from: data)
            if door?.state == .unlocked {
                print("door unlocked!!")
                DispatchQueue.main.sync {
                    DataManager.shared.updateBeaconUnlockCount(clBeacon: clBeacon)
                    completion(true, nil)
                }
            }
        }
        task.resume()
    }
}
