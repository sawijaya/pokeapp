//
//  RSAURIRouteError.swift
//  
//
//  Created by sawijaya on 30/04/20.
//  Copyright © 2020 sawijaya. All rights reserved.
//

import Foundation

/// Describe all error in LightRoute
public enum RSAURIRouteError: LocalizedError {
    
    /// If operation could not be cast moduleInput or controller to type.
    case castError(controller: String, type: String)
    
    /// If need controller was nil.
    case viewControllerWasNil(String)
    
    /// Something error.
    case customError(String)

    var localizedDescription: String {
        switch self {
        case .castError(let controller, let type):
            return "[RSAURIRouteError]: Can't cast type \"\(controller)\" to \(type) object"
        case .viewControllerWasNil(let controller):
            return "[RSAURIRouteError]: \(controller) controller was nil"
        case .customError(let error):
            return "[RSAURIRouteError]: " + error
        }
    }
}

