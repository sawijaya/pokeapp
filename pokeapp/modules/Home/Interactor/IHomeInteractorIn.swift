//
//  IHomeInteractorIn.swift
//  pokeapp
//
//  Created by Salim Wijaya on 02/02/21.
//  Copyright (c) 2021. All rights reserved.

import UIKit

public protocol IHomeInteractorIn {
    func fetchPokemon(_ limit: Int, offset: Int)
    
    func fetchPokemonById(_ id: Int)
    
    func requestType()
    
    func requestAbility()
}
