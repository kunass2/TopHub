//
//  UITableView.swift
//  TopHub
//
//  Created by Bartłomiej Semańczyk on 09/08/2017.
//  Copyright © 2017 Bartłomiej Semańczyk. All rights reserved.
//

import UIKit

extension UITableView {
    
    func isLast(for indexPath: IndexPath) -> Bool {
        let indexOfLastRow = numberOfRows(inSection: 0) - 1
        return indexPath.row == indexOfLastRow
    }
}
