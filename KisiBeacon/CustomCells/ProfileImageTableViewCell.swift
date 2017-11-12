//
//  ProfileImageTableViewCell.swift
//  KisiBeacon
//
//  Created by Suyash Taneja on 04/11/17.
//  Copyright © 2017 Suyash Taneja. All rights reserved.
//

import UIKit

class ProfileImageTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageSuperview: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var profileImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        profileImageSuperview.layer.masksToBounds = true
        editButton.backgroundColor = UIColor.black
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImageSuperview.layer.cornerRadius = profileImageSuperview.bounds.width * 0.5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(user: User) {
        nameLabel.text = user.fullName
        profileImageView.image = user.image
    }
}
