//
//  ApplicationAssembly.swift
//
//
//  Created by sawijaya on 02/02/21.
//  Copyright © 2021 sawijaya. All rights reserved.
//

import Swinject
import UIKit

final class ApplicationAssembly {
    
    //Use default dependency
    class var assembler: Assembler {
        return Assembler([
            ServiceAssemblyContainer(),
            HomeAssemblyContainer()
        ])
    }
    
    var assembler: Assembler
    
    //If you want use custom Assembler
    init(with assemblies: [Assembly]) {
        assembler = Assembler(assemblies)
    }
    
}

class AppContainer {
    static var shared: AppContainer = AppContainer()
    private var defaultContainer: Container!
    
    private init() {
        self.setup()
    }
    
    private func setup(){
        defaultContainer = ApplicationAssembly.assembler.resolver as? Container
    }
    
    var homeViewController: UIViewController {
        get {
            let vc: UIViewController = self.defaultContainer.resolve(HomeViewController.self) ?? UIViewController()
            let nv: UINavigationController = UINavigationController(rootViewController: vc)
            return nv
        }
    }
}
