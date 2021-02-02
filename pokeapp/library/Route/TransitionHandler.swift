//
//  TransitionHandler.swift
//  
//
//  Created by sawijaya on 29/04/20.
//  Copyright © 2020 sawijaya. All rights reserved.
//

import UIKit
import Foundation

/// This protocol describe how do transition beetwen ViewControllers.
protocol TransitionHandler: class {
    func forCurrentModule<T>(module: Module, to type: T.Type) throws -> TransitionNode<T>
}

// MARK: Extension UIViewController
extension TransitionHandler where Self: UIViewController {
    /// Implementation for current module transition
    func forCurrentModule<T>(module: Module, to type: T.Type) throws -> TransitionNode<T> {
        let destination = module.viewController
        
        let node = TransitionNode(root: self, destination: destination, for: type)

        node.postLinkAction { [unowned self, unowned node] in
            self.present(destination, animated: node.isAnimated, completion: nil)
        }
        return node
    }
}
