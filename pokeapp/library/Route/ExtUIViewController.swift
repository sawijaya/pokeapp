////
////  ExtUIViewController.swift
////  
////
////  Created by sawijaya on 29/04/20.
////  Copyright © 2020 sawijaya. All rights reserved.
////
//
import UIKit

extension UIViewController: TransitionHandler {
    /// This property return tradition VIPER presenter object from "presenter" property.
    var moduleInput: Any? {
        return findValue(for: "presenter", in: Mirror(reflecting: self))
    }
    
    private func findValue(for propertyName: String, in mirror: Mirror) -> Any? {
        for property in mirror.children {
            if property.label! == propertyName {
                return property.value
            }
        }
        
        if let superclassMirror = mirror.superclassMirror {
            return findValue(for: propertyName, in: superclassMirror)
        }
        
        return nil
    }
    
    /// This property have responsobility about store property for moduleOutput protocols.
    public var moduleOutput: Any? {
        get {
            let box = objc_getAssociatedObject(self, &UIViewController.TransitionHandlerModuleOutput) as? Box
            return box?.value
        }
        set {
            objc_setAssociatedObject(self, &UIViewController.TransitionHandlerModuleOutput, Box(newValue), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    ///
    /// This methods get moduleInput by selector.
    ///
    /// - Parameter selectorName: Selector name for find object in view controller.
    /// - Returns: Return something object, how can be promisee about moduleInput.
    ///
    func getModuleInput(for selectorName: String) -> Any? {
        
        let reflection = Mirror(reflecting: self).children
        var output: Any?
        
        // Find `output` property
        for property in reflection {
            if property.label! == selectorName {
                output = property.value
                break
            }
        }
        
        return output
    }
    
    // Wrapper for save objects with nil.
    class Box {
        let value: Any?
        init(_ value: Any?) {
            self.value = value
        }
    }
    
    // Key for objc associated objects.
    @nonobjc static var TransitionHandlerModuleOutput = "ru.hipsterknight.lightroute.moduleOutput"
}

// MARK: -
// MARK: Dispatch once implemetation.

// Read more: [Dispatch once in Swift 3](http://stackoverflow.com/a/38311178)
fileprivate extension DispatchQueue {
    
    private static var _onceTracker: [String] = []
    
    /// Return default dispatch_once in Swift.
    static func once(token: String, block: () -> Void) {
        objc_sync_enter(self)
        defer { objc_sync_exit(self) }
        
        if _onceTracker.contains(token) {
            return
        }
        
        _onceTracker.append(token)
        block()
    }
    
}

extension UIViewController {

    func setLargeTitleDisplayMode(_ largeTitleDisplayMode: UINavigationItem.LargeTitleDisplayMode) {
        switch largeTitleDisplayMode {
        case .automatic:
              guard let navigationController = navigationController else { break }
            if let index = navigationController.children.firstIndex(of: self) {
                setLargeTitleDisplayMode(index == 0 ? .always : .never)
            } else {
                setLargeTitleDisplayMode(.always)
            }
        case .always, .never:
            navigationItem.largeTitleDisplayMode = largeTitleDisplayMode
            // Even when .never, needs to be true otherwise animation will be broken on iOS11, 12, 13
            navigationController?.navigationBar.prefersLargeTitles = true
        @unknown default:
            print("\(#function): Missing handler for \(largeTitleDisplayMode)”")
        }
    }
}
