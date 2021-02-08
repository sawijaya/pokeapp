//
//  HomeRouter.swift
//  pokeapp
//
//  Created by Salim Wijaya on 02/02/21.
//  Copyright (c) 2021. All rights reserved.

import UIKit

public class HomeRouter: IHomeRouterIn {
    var transitionHandler: TransitionHandler!
	var interactor: IHomeInteractorIn?
	var presenter: IHomeModule?
	weak var view: IHomeView?
    
    public func presentPokemon(_ pokemon: [String : Any]) {
        try? self.transitionHandler.forCurrentModule(module: Module.Pokemon, to: IPokemonModule.self)
            .transition(animate: true).apply(to: { (viewController) in
                
            })
            .to(preferred: .navigation(style: .push))
            .then { (moduleInput) in
                
            }
    }
}
