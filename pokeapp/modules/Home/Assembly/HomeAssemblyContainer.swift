//
//  HomeAssemblyContainer.swift
//  pokeapp
//
//  Created by Salim Wijaya on 02/02/21.
//  Copyright (c) 2021. All rights reserved.

import Foundation
import Swinject
import UIKit

final class HomeAssemblyContainer: Assembly  {
    
    func assemble(container: Container) {
        
        container.register(IHomeInteractorIn.self) { (r, presenter: HomePresenter) in
            let interactor: HomeInteractor = HomeInteractor()
            interactor.out = presenter
            let service: PokemonService = r.resolve(IPokemonService.self) as! PokemonService
            service.out = interactor
            interactor.service = service
//            interactor.service.
            return interactor
        }
        
        container.register(IHomeRouterIn.self) { (r, viewController: HomeViewController, presenter: HomePresenter) in
            let router: HomeRouter = HomeRouter()
            router.presenter = presenter
            router.transitionHandler = viewController
            router.interactor = r.resolve(IHomeInteractorIn.self, argument: presenter)
            router.view = viewController
            
            return router
        }
        
        container.register(IHomeModule.self) { (r, viewController: HomeViewController) in
            let presenter: HomePresenter = HomePresenter()
            presenter.view = viewController
            presenter.interactor = r.resolve(IHomeInteractorIn.self, argument: presenter)
            presenter.router = r.resolve(IHomeRouterIn.self, arguments: viewController, presenter)
            return presenter
        }
        
        container.register(HomeViewController.self) { r in
            let viewController: HomeViewController = HomeViewController(nibName: "HomeViewController", bundle: Bundle.main)
            viewController.presenter = r.resolve(IHomeModule.self, argument: viewController)
            return viewController
        }
    }
    
}
