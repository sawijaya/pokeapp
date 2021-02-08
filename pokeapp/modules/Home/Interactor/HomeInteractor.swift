//
//  HomeInteractor.swift
//  pokeapp
//
//  Created by Salim Wijaya on 02/02/21.
//  Copyright (c) 2021. All rights reserved.

import UIKit

public class HomeInteractor: IHomeInteractorIn {
    
	var out: IHomeInteractorOut?
    var service: IPokemonService!
    
	public init() {
	}
    
    public func fetchPokemon(_ limit: Int, offset: Int) {
        self.service.fetchPokemon(limit, offset: offset)
    }
    
    public func fetchPokemonById(_ id: Int) {
        self.service.fetchPokemonById(id)
    }
    
    public func requestType() {
        self.service.requestType()
    }
    
    public func requestAbility() {
        self.service.requestAbility()
    }
}

extension HomeInteractor: IPokemonServiceOut {
    public func loadPokemons(_ pokemons: [NSDictionary]) {
        self.out?.loadPokemons(pokemons)
    }
}
