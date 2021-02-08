//
//  PokemonPresenter.swift
//  pokeapp
//
//  Created by Salim Wijaya on 05/02/21.
//  Copyright (c) 2021. All rights reserved.

import UIKit

public class PokemonPresenter: IPokemonModule {
    public var pokemon: NSDictionary?
	var interactor: IPokemonInteractorIn?
	var router: IPokemonRouterIn?
	weak var view: IPokemonView?
	public var parameters: [String: Any]?
	
	public init() {
	}
}

extension PokemonPresenter: IPokemonInteractorOut {
	
}
