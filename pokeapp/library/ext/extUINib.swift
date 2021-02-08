//
//  extUINib.swift
//  
//
//  Created by sawijaya on 11/10/20.
//

import Foundation
import UIKit

extension UINib {
    func instantiate() -> Any? {
        return self.instantiate(withOwner: nil, options: nil).first
    }
}
