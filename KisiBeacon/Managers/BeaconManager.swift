//
//  BeaconManager.swift
//  KisiBeacon
//
//  Created by Suyash Taneja on 04/11/17.
//  Copyright © 2017 Suyash Taneja. All rights reserved.
//

import Foundation
import CoreData
import CoreLocation

class BeaconManager: NSObject {
    static let shared = BeaconManager()
    let locationManager = CLLocationManager()
    
    let beaconRegion: CLBeaconRegion = CLBeaconRegion(proximityUUID: UUID(uuidString: Constants.beaconUUID)!, identifier: "KISI-DOOR")
    
    // When Beacon is less than 50cms away this block is called
    var beaconInRange: ((CLBeacon) -> ())?
    var locationAuthorizationChanged: ((CLAuthorizationStatus) -> ())?
        
    private var shouldUpdateBeaconDistance: Bool = false
    private var refreshTimer: Timer?
    
    var currentAuthorizationStatus: CLAuthorizationStatus = .notDetermined
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        beaconRegion.notifyEntryStateOnDisplay = true
        
        refreshTimer = Timer.scheduledTimer(withTimeInterval: 4 , repeats: true, block: { (timer) in
            self.shouldUpdateBeaconDistance = true
        })
        startMonitoring()
    }
    
    private func startMonitoring() {
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.startUpdatingLocation()
        if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
            locationManager.startMonitoring(for: beaconRegion)
        }
    }
}

extension BeaconManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, monitoringDidFailFor region: CLRegion?, withError error: Error) {
        
    }
    
    func locationManagerDidPauseLocationUpdates(_ manager: CLLocationManager) {
        
    }
    
    func locationManagerDidResumeLocationUpdates(_ manager: CLLocationManager) {
        startMonitoring()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        currentAuthorizationStatus = status
        
        //TODO: Set Notification for authorization status change
        
        switch status {
        case .authorizedAlways:
            startMonitoring()
        case .authorizedWhenInUse:
            startMonitoring()
        case .denied: break
        case .notDetermined: break
        case .restricted: break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        if let currentBeaconRegion = region as? CLBeaconRegion, currentBeaconRegion.proximityUUID == beaconRegion.proximityUUID {
            // Start ranging only if the feature is available.
            if CLLocationManager.isRangingAvailable() {
                manager.startRangingBeacons(in: region as! CLBeaconRegion)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        manager.stopRangingBeacons(in: beaconRegion)
    }
    
    func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion) {
        if state == .inside, let currentBeaconRegion = region as? CLBeaconRegion, currentBeaconRegion.proximityUUID == beaconRegion.proximityUUID {
            // Start ranging only if the feature is available.
            if CLLocationManager.isRangingAvailable() {
                manager.startRangingBeacons(in: region as! CLBeaconRegion)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        if beacons.count > 0,
            let beacon = beacons.first, region == beaconRegion,
            (beacon.proximity == .near || beacon.proximity == .immediate),
            beacon.accuracy < 0.5 {
            print("distance from Beacon - \(beacon.accuracy)m")
            if shouldUpdateBeaconDistance {
                beaconInRange?(beacon)
            }
        }
        shouldUpdateBeaconDistance = false
    }
}
