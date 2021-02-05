//
//  PokemonService.swift
//  pokeapp
//
//  Created by Salim Wijaya on 04/02/21.
//

import Foundation

protocol IPokemonService {
    func fetchPokemon(_ limit: Int, offset: Int)
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
}

extension PokemonService: IPokemonNetworkServiceOut {
    func loadObjects(_ objects: [[String : Any]]) {
        self.repository.insertBatchPokemons(objects)
        print(objects)
    }
}

extension PokemonService: IPokemonRepositoryOut {
    func loadPokemons(_ pokemons: [NSDictionary], limit: Int, offset: Int) {
        if pokemons.count == 0 {
            self.network.requestPokemon(limit, offset: offset)
        } else {
            print("load pokemon from repo")
            self.out.loadPokemons(pokemons)
        }
    }
}
