//
//  RepositoryTableViewCell.swift
//  TopHub
//
//  Created by Bartłomiej Semańczyk on 09/08/2017.
//  Copyright © 2017 Bartłomiej Semańczyk. All rights reserved.
//

import UIKit

class RepositoryTableViewCell: UITableViewCell {
    
    @IBOutlet private var nameLabel: UILabel!
    
    func update(with repository: Repository) {
        nameLabel.text = repository.name
    }
}
