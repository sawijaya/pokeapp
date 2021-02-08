//
//  HomePresenter.swift
//  pokeapp
//
//  Created by Salim Wijaya on 02/02/21.
//  Copyright (c) 2021. All rights reserved.

import UIKit

public class HomePresenter: IHomeModule {
	var interactor: IHomeInteractorIn?
	var router: IHomeRouterIn?
	weak var view: IHomeView?
	public var parameters: [String: Any]?
	
	public init() {
        
	}
    
    public func fetchPokemon(_ limit: Int, offset: Int) {
        self.interactor?.fetchPokemon(limit, offset: offset)
    }
    
    public func fetchPokemonById(_ id: Int) {
        self.interactor?.fetchPokemonById(id)
    }
    
    public func presentPokemon(_ id: Int) {
        self.router?.presentPokemon([:])
    }
    
    public func requestType() {
        self.interactor?.requestType()
    }
    
    public func requestAbility() {
        self.interactor?.requestAbility()
    }
}

extension HomePresenter: IHomeInteractorOut {
    public func loadPokemons(_ pokemons: [NSDictionary]) {
        self.view?.loadPokemons(pokemons)
    }
    
    public func loadPokemon(_ pokemon: NSDictionary) {
        self.router?.presentPokemon(pokemon)
//        self.view?.loadPokemon(pokemon)
    }
}
