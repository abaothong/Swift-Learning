//
//  UserListTableViewCell.swift
//  MyNameCard
//
//  Created by Thong Hao Yi on 26/03/2016.
//  Copyright © 2016 Thong Hao Yi. All rights reserved.
//

import UIKit

class UserListTableViewCell: UITableViewCell {
    @IBOutlet var fullNameLabel: UILabel!
    
    override func awakeFromNib() {
        self.backgroundColor = UIColor.clearColor()
        self.fullNameLabel.textColor = UIColor.whiteColor()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        if (selected) {
            fullNameLabel.textColor = Color.defaultBlue
        } else {
            fullNameLabel.textColor = UIColor.whiteColor()
        }
    }
    
}
