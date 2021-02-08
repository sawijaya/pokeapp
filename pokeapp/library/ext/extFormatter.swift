//
//  extFormatter.swift
//  
//
//  Created by Salim Wijaya on 14/11/20.
//

import Foundation

extension Formatter {
    static let iso8601withFractionalSeconds = ISO8601DateFormatter([.withInternetDateTime, .withFractionalSeconds])
}
