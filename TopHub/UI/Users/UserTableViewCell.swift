//
//  UserTableViewCell.swift
//  TopHub
//
//  Created by Bartłomiej Semańczyk on 09/08/2017.
//  Copyright © 2017 Bartłomiej Semańczyk. All rights reserved.
//

import UIKit
import SDWebImage

class UserTableViewCell: UITableViewCell {
    
    @IBOutlet private var avatarImageView: UIImageView!
    @IBOutlet private var loginLabel: UILabel!
    @IBOutlet private var numberOfRepositoriesLabel: UILabel!
    
    func update(with user: User) {
        avatarImageView.setImage(withString: user.avatarUrl)
        loginLabel.text = user.login
        numberOfRepositoriesLabel.text = "\(user.numberofRepositories)"
    }
}
