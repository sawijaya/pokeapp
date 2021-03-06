//
//  IHomeInteractorOut.swift
//  pokeapp
//
//  Created by Salim Wijaya on 02/02/21.
//  Copyright (c) 2021. All rights reserved.

import UIKit

public protocol IHomeInteractorOut: class {
    func loadPokemons(_ pokemons:[NSDictionary])
    func loadPokemon(_ pokemon:NSDictionary)
}
