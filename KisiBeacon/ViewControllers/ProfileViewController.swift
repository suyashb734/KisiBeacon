//
//  SecondViewController.swift
//  KisiBeacon
//
//  Created by Suyash Taneja on 04/11/17.
//  Copyright © 2017 Suyash Taneja. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    let dataSource = [["Name, Phone Numbers, Email", "Password & Security", "Payment & Shipping"], ["iCloud", "iTunes & App Store", "Set Up Family Sharing..."]]
    let user = User(firstName: "Bryan", lastName: "Adams", image: #imageLiteral(resourceName: "profile_guitar"))
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            tableView.register(UINib(nibName: String(describing: ProfileImageTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: ProfileImageTableViewCell.self))
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "defaultCell")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Profile"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ProfileViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 3
        case 1:
            return 3
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "defaultCell")!
        cell.textLabel?.text = dataSource[indexPath.section][indexPath.row]
        cell.accessoryType = .disclosureIndicator
        if indexPath.section == 1 {
            switch indexPath.row {
            case 0:
                cell.imageView?.image = #imageLiteral(resourceName: "icon_icloud")
            case 1:
                cell.imageView?.image = #imageLiteral(resourceName: "icon_appstore")
            case 2:
                cell.imageView?.image = #imageLiteral(resourceName: "icon_familysharing")
                cell.textLabel?.textColor = UIColor.blueTextColor
                cell.accessoryType = .none
            default: break
            }
        }
        return cell
    }
}

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ProfileImageTableViewCell.self)) as! ProfileImageTableViewCell
            cell.configure(user: user)
            return cell
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section  == 0 {
            return 200
        }
        return 0.0
    }

    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 200
        }
        return 0.0
    }
}

