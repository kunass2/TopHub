//
//  UIImageView.swift
//  TopHub
//
//  Created by Bartłomiej Semańczyk on 09/08/2017.
//  Copyright © 2017 Bartłomiej Semańczyk. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func setImage(withString string: String?) {
        
        image = nil
        
        if let string = string, let url = URL(string: string) {
            sd_setImage(with: url, completed: nil)
        }
    }
}
