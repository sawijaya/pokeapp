//
//  ModuleRoute.swift
//
//
//  Created by sawijaya on 29/04/20.
//  Copyright © 2020 sawijaya. All rights reserved.
//

import UIKit
import ObjectiveC.runtime
import Swinject

// MARK: Public typealiase
/// This block returns the controller type to which could lead.
public typealias TransitionSetupBlock<T> = ((T) -> Any?)

/// This block is responsible for return transition data.
public typealias TransitionBlock = ((_ source: UIViewController, _ destination: UIViewController) -> Void)

/// This block is responsible for implementing the transition.
public typealias TransitionPostLinkAction = (() throws -> Void)

// MARK: -
// MARK: Transition implementation
/// Establishes liability for the current transition.
public enum TransitionStyle {

    /// This type is responsible for transition case how modal presentation will be add transition on view.
    public typealias ModalStyle = (transition: UIModalTransitionStyle, presentation: UIModalPresentationStyle)

    /// Responds transition case how navigation controller will be add transition on navigation stack.
    public enum NavigationStyle {

        /// This case performs that current transition must be push.
        case push

        /// This case performs that current transition must be pop.
        case pop

        /// This case performs that current transition must be present.
        case present
    }

    /// This case performs that current transition must be add to navigation completion stack.
    case navigation(style: NavigationStyle)

    /// This case performs that current transition must be add to navigation completion stack.
    case modal(style: ModalStyle)

    /// This case performs that current transition must be presented from initiated view controller.
    case `default`
}

// MARK: -
enum Module {
    case Home
    case Pokemon
    
    internal var viewController: UIViewController {
        switch self {
            case .Home:
                return AppContainer.shared.homeViewController
            case .Pokemon:
                return AppContainer.shared.pokemonViewController
            default:
                return UIViewController()
            
        }
    }
}
