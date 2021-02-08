//
//  PokemonAssemblyContainer.swift
//  pokeapp
//
//  Created by Salim Wijaya on 05/02/21.
//  Copyright (c) 2021. All rights reserved.

import Foundation
import Swinject
import UIKit

final class PokemonAssemblyContainer: Assembly  {
    
    func assemble(container: Container) {
        
        container.register(IPokemonInteractorIn.self) { (r, presenter: PokemonPresenter) in
            let interactor: PokemonInteractor = PokemonInteractor()
            interactor.out = presenter
            return interactor
        }
        
        container.register(IPokemonRouterIn.self) { (r, viewController: PokemonViewController, presenter: PokemonPresenter) in
            let router: PokemonRouter = PokemonRouter()
            router.presenter = presenter
            
            router.interactor = r.resolve(IPokemonInteractorIn.self, argument: presenter)
            router.view = viewController
            
            return router
        }
        
        container.register(IPokemonModule.self) { (r, viewController: PokemonViewController) in
            let presenter: PokemonPresenter = PokemonPresenter()
            presenter.view = viewController
            presenter.interactor = r.resolve(IPokemonInteractorIn.self, argument: presenter)
            presenter.router = r.resolve(IPokemonRouterIn.self, arguments: viewController, presenter)
            return presenter
        }
        
        container.register(PokemonViewController.self) { r in
            let viewController: PokemonViewController = PokemonViewController(nibName: "PokemonViewController", bundle: Bundle.main)
            viewController.presenter = r.resolve(IPokemonModule.self, argument: viewController)
            return viewController
        }
    }
    
}
