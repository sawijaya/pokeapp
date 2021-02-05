//
//  PokemonNetworkService.swift
//  pokeapp
//
//  Created by Salim Wijaya on 03/02/21.
//

import Foundation

protocol IPokemonNetworkService {
    func requestPokemon(_ limit: Int, offset: Int)
}

protocol IPokemonNetworkServiceOut: class {
//    func loadPokemons(_ pokemons:[Any])
    func loadObjects(_ objects:[[String:Any]])
}

class PokemonNetworkService: IPokemonNetworkService {
    var out: IPokemonNetworkServiceOut!
    // MARK: - Vars & Lets
    private let apiManager: APIManager = APIManager.shared()
    
    // MARK: - Initialization
    init() { }
    
    func requestPokemon(_ limit: Int, offset: Int) {
        self.apiManager.call(type: .pokemon(["limit":limit,"offset":offset])) { (response, error) in
            if let response = response as? [String:Any] {
                if let results = response["results"] as? [Any] {
                    var pokemons:[[String:Any]] = []
                    for result in results {
                        var hasId: Bool = false
                        var obj:[String:Any] = result as? [String:Any] ?? [:]
                        let urlStr: String = obj["url"] as? String ?? ""
                        if let url: URL = URL(string: urlStr) {
                            hasId = true
                            obj["id"] = url.lastPathComponent
                        }
                        obj.removeValue(forKey: "url")
                        if hasId {
                            pokemons.append(obj)
                        }
                    }
                    self.out.loadObjects(pokemons)
                }
            }
        }
    }
}
