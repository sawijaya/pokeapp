//
//  PokemonService.swift
//  pokeapp
//
//  Created by Salim Wijaya on 04/02/21.
//

import Foundation

protocol IPokemonService {
    func fetchPokemon(_ limit: Int, offset: Int)
    func fetchPokemonById(_ id: Int)
    func fetchType()
    
    func requestType()
    func requestAbility()
}

public protocol IPokemonServiceOut: class {
    func loadPokemons(_ pokemons:[NSDictionary])
}

class PokemonService: IPokemonService {
    var out: IPokemonServiceOut!
    var network: IPokemonNetworkService!
    var repository: IPokemonRepository!
    var limit: Int!
    var offset: Int!
    func fetchPokemon(_ limit: Int, offset: Int) {
        self.repository.fetchPokemon(limit, offset: offset)
    }
    
    func fetchPokemonById(_ id: Int) {
        self.repository.fetchPokemonById(id)
    }
    
    func fetchType(){
        
    }
    
    func requestType() {
        self.repository.fetchType()
    }
    
    func requestAbility() {
        self.repository.fetchAbility()
    }
}

extension PokemonService: IPokemonNetworkServiceOut {
    func loadEvolve(_ evolves: [Any]) {
        print(#function)
        print(evolves)
    }
    
    func loadObject(_ pokemon: [String : Any]) {
        self.repository.updatePokemon(pokemon)
    }
    
    func loadTypes(_ objects: [[String : Any]]) {
        self.repository.insertBatchType(objects)
    }
    
    func loadAbility(_ objects: [[String : Any]]) {
        self.repository.insertBatchAbility(objects)
    }
    
    func loadObjects(_ objects: [[String : Any]]) {
        self.repository.insertBatchPokemons(objects)
        print(objects)
    }
}

extension PokemonService: IPokemonRepositoryOut {
    func loadTypes(_ types: [NSDictionary]) {
        if types.count == 0 {
            self.network.requestType()
        } else {
            print(types)
        }
    }
    
    func loadAbility(_ abilities: [NSDictionary]) {
        if abilities.count == 0 {
            self.network.requestAbility()
        } else {
            print(abilities)
        }
    }
    
    func loadPokemon(_ pokemon: NSDictionary) {
        let isComplete: Bool = pokemon.value(forKey: "isComplete") as? Bool ?? false
        if !isComplete {
            if let id: String = pokemon.value(forKey: "id") as? String,
               let idInt: Int = Int(id) {
                self.network.requestPokemonById(idInt)
            }
        }
        print(pokemon)
    }
    
    func loadPokemons(_ pokemons: [NSDictionary], limit: Int, offset: Int) {
        if pokemons.count == 0 {
            self.network.requestPokemon(limit, offset: offset)
        } else {
            print("load pokemon from repo")
            self.out.loadPokemons(pokemons)
        }
    }
}
