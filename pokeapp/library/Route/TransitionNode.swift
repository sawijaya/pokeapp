//
//  TransitionNode.swift
//  
//
//  Created by sawijaya on 29/04/20.
//  Copyright © 2020 sawijaya. All rights reserved.
//
import UIKit

/// The main class that describes the current transition.
public final class TransitionNode<T>: GenericTransitionNode<T> {
    
    // MARK: -
    // MARK: Properties
    // MARK: Public
    
    /// Shows animated this transition or not.
    public var isAnimated: Bool {
        return animated
    }
    
    // MARK: Private
    /// Set and get current transition animate state.
    internal var animated: Bool = true
    
    // MARK: -
    // MARK: Public methods
    
    ///
    /// Instantiate transition case and waits, when should be active.
    /// - Note: This method must be called once for the current transition.
    /// You can call it many times, but he still fire only the last called function.
    ///
    /// - Parameter case: Case for transition node.
    /// - Returns: Configured transition node.
    /// - Throws: Throw error, if need controller was nil and if controller could not be cast to type
    ///
    public func to(preferred style: TransitionStyle) throws -> TransitionNode<T> {
        // Remove old link action then we can setup new transition action.
        self.postLinkAction = nil
        
        try fixDestination(for: style)
        // Setup new transition action from transition case.
        self.postLinkAction { [weak self] in
            guard let destination = self?.destination else {
                throw RSAURIRouteError.viewControllerWasNil("Destination")
            }
            guard let root = self?.root, let animated = self?.isAnimated else {
                throw RSAURIRouteError.viewControllerWasNil("Root")
            }
            switch style {
                case .navigation(style: let navStyle):
                    guard let navController = root.navigationController else {
                        throw RSAURIRouteError.viewControllerWasNil("Transition error, navigation")
                    }
                    switch navStyle {
                    case .pop:
                        navController.popToViewController(destination, animated: animated)
                    case .present:
                        navController.present(destination, animated: animated, completion: nil)
                    case .push:
                        print("animated \(animated)")
                        print("destination \(destination)")
                        navController.pushViewController(destination, animated: animated)
                    }
                case .modal(let modalStyle):
                    destination.modalTransitionStyle = modalStyle.transition
                    destination.modalPresentationStyle = modalStyle.presentation
                    root.present(destination, animated: animated, completion: nil)

                case .default:
                    root.present(destination, animated: animated, completion: nil)
            }
        }
        
        return self
    }
    
    private func fixDestination(for style: TransitionStyle) throws {
        switch style {
        case .navigation(style: let navStyle):
            guard let destination = self.destination else {
                throw RSAURIRouteError.viewControllerWasNil("Destination")
            }

            guard let navController = root.navigationController else {
                throw RSAURIRouteError.viewControllerWasNil("Transition error, navigation")
            }

            switch navStyle {
            case .pop:
                let first = navController.viewControllers.first { $0.restorationIdentifier == destination.restorationIdentifier }
                guard let result = first else {
                    throw RSAURIRouteError.customError("Can't get pop controller in navigation controller stack.")
                }
                self.destination = result
            default:
                break
            }
        default:
            break
        }
    }
    
    ///
    /// Turn on or off animate for current transition.
    /// - Note: By default this transition is animated.
    ///
    /// - Parameter animate: Animate or not current transition ifneeded.
    ///
    public func transition(animate: Bool) -> TransitionNode<T> {
        self.animated = animate
        return self
    }
    
    ///
    /// This methods is responsible for find selector in destination view controller
    /// for configure.
    ///
    /// - Parameter selector: String selector for configure module.
    /// - Returns: Transition node instance with setups.
    ///
    public func selector(_ selector: String) -> TransitionNode<T> {
        self.customModuleInput = destination?.getModuleInput(for: selector)
        return self
    }
    
    ///
    /// This methods is responsible for find selector in destination view controller
    /// for configure.
    ///
    /// - Parameter selector: Selector for configure module.
    /// - Returns: Transition node instance with setups.
    ///
    public func selector(_ selector: Selector) -> TransitionNode<T> {
        self.customModuleInput = destination?.getModuleInput(for: NSStringFromSelector(selector))
        return self
    }

    ///
    /// This methods is responsible for find selector in destination view controller
    /// for configure.
    ///
    /// - Parameter selector: Key path for selector.
    /// - Returns: Transition node instance with setups.
    ///
    public func selector<Root, Type>(_ keyPath: KeyPath<Root, Type>) -> TransitionNode<T> {
        self.customModuleInput = (destination as? Root)?[keyPath: keyPath]
        return self
    }

}
