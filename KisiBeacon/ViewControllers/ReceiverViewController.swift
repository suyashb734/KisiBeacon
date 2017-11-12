//
//  FirstViewController.swift
//  KisiBeacon
//
//  Created by Suyash Taneja on 04/11/17.
//  Copyright © 2017 Suyash Taneja. All rights reserved.
//

import UIKit
import CoreData

class ReceiverViewController: UIViewController {

    @IBOutlet weak var lockView: CustomLockView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        view.backgroundColor = UIColor.redBackgroundColor
        setupBeaconManager()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupBeaconManager() {
        BeaconManager.shared.beaconInRange = { (clBeacon) in
            KisiDoorManager.shared.unlockDoor(clBeacon: clBeacon, completion: { (success, error) in
                if success && error == nil {
                    self.lockView.unlockDoor()
                }
            })
        }
    }
}

