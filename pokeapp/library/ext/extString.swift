//
//  extString.swift
//  
//
//  Created by Salim Wijaya on 14/11/20.
//

import Foundation

extension String {
    var iso8601withFractionalSeconds: Date? { return Formatter.iso8601withFractionalSeconds.date(from: self) }
}
