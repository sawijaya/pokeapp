//
//  PokemonRouter.swift
//  pokeapp
//
//  Created by Salim Wijaya on 05/02/21.
//  Copyright (c) 2021. All rights reserved.

import UIKit

public class PokemonRouter: IPokemonRouterIn {
	var interactor: IPokemonInteractorIn?
	var presenter: IPokemonModule?
	weak var view: IPokemonView?
}
