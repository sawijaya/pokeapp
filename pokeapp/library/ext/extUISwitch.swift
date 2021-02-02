//
//  extUISwitch.swift
//  RSAURI
//
//  Created by Salim Wijaya on 21/11/20.
//

import Foundation
import UIKit

extension UISwitch {
    func set(offTint color: UIColor ) {
        let minSide = min(bounds.size.height, bounds.size.width)
        layer.cornerRadius = minSide / 2
        backgroundColor = color
        tintColor = color
    }
}
