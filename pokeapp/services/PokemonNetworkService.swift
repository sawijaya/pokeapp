//
//  PokemonNetworkService.swift
//  pokeapp
//
//  Created by Salim Wijaya on 03/02/21.
//

import Foundation

protocol IPokemonNetworkService {
    func requestPokemon(_ limit: Int, offset: Int)
    
    func requestPokemonById(_ id: Int)
    
    func requestType()
    
    func requestAbility()
}

protocol IPokemonNetworkServiceOut: class {
//    func loadPokemons(_ pokemons:[Any])
    func loadObjects(_ objects:[[String:Any]])
    
    func loadTypes(_ objects:[[String:Any]])
    
    func loadAbility(_ objects:[[String:Any]])
    
    func loadObject(_ pokemon:[String:Any])
    
    func loadEvolve(_ evolves:[Any])
}

class PokemonNetworkService: IPokemonNetworkService {
    var out: IPokemonNetworkServiceOut!
    // MARK: - Vars & Lets
    private let apiManager: APIManager = APIManager.shared()
    
    // MARK: - Initialization
    init() { }
    
    func requestType() {
        self.apiManager.call(type: .type) { (response, error) in
            if let response = response as? [String:Any] {
                if let results = response["results"] as? [Any] {
                    var types:[[String:Any]] = []
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
                            types.append(obj)
                        }
                    }
                    self.out.loadTypes(types)
                }
            }
        }
    }
    
    func requestAbility() {
        self.apiManager.call(type: .ability) { (response, error) in
            if let response = response as? [String:Any] {
                if let results = response["results"] as? [Any] {
                    var abilities:[[String:Any]] = []
                    let group = DispatchGroup()
                    for result in results {
                        var hasId: Bool = false
                        var obj:[String:Any] = result as? [String:Any] ?? [:]
                        let urlStr: String = obj["url"] as? String ?? ""
                        var id: String = ""
                        if let url: URL = URL(string: urlStr) {
                            hasId = true
                            id = url.lastPathComponent
                            obj["id"] = url.lastPathComponent
                        }
                        obj.removeValue(forKey: "url")
                        group.enter()
                        self.apiManager.call(type: .abilityById(Int(id)!)) { (_response, _error) in
                            if let _response = _response as? [String:Any] {
                                let flavors:[Any] = _response["flavor_text_entries"] as? [Any] ?? []
                                let filter:[Any] = flavors.filter { (flavor) -> Bool in
                                    let dict = flavor as? [String:Any] ?? [:]
                                    let language:[String:Any] = dict["language"] as? [String:Any] ?? [:]
                                    let en: String = language["name"] as? String ?? ""
                                    
                                    let versionGroup:[String:Any] = dict["version_group"] as? [String:Any] ?? [:]
                                    let name: String = versionGroup["name"] as? String ?? ""
                                    if en == "en" && name == "x-y" {
                                        return true
                                    }
                                    return false
                                }
                                
                                if let first:Any = filter.first {
                                    let dict = first as? [String:Any] ?? [:]
                                    let flavorText: String = dict["flavor_text"] as? String ?? ""
                                    obj["desc"] = flavorText
//                                    print(flavorText, obj)
                                }
                                
                                if hasId {
                                    abilities.append(obj)
                                }
                                group.leave()
                            }
                        }
                    }
                    group.notify(queue: .main) {
                        self.out.loadAbility(abilities)
                    }
                    
                }
            }
        }
    }
    
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
                        obj["isComplete"] = false
                        if hasId {
                            pokemons.append(obj)
                        }
                    }
                    self.out.loadObjects(pokemons)
                }
            }
        }
    }
    
    func requestPokemonById(_ id: Int) {
        self.apiManager.call(type: .pokemonById(id)) { (response, error) in
            guard var pokemon:[String:Any] = response as? [String:Any] else {
                return
            }
            pokemon.removeValue(forKey: "base_experience")
            pokemon.removeValue(forKey: "forms")
            pokemon.removeValue(forKey: "game_indices")
            pokemon.removeValue(forKey: "held_items")
            pokemon.removeValue(forKey: "moves")
            pokemon.removeValue(forKey: "order")
            pokemon.removeValue(forKey: "sprites")
            pokemon.removeValue(forKey: "location_area_encounters")
            pokemon.removeValue(forKey: "species")
            pokemon.removeValue(forKey: "is_default")
            
            let abilities:[Any] = pokemon["abilities"] as? [Any] ?? []
            var newAbilities:[Any] = []
            for ability in abilities {
                let dictionary:[String:Any] = ability as? [String:Any] ?? [:]
                var abilityDict:[String:Any] = dictionary["ability"] as? [String:Any] ?? [:]
                if let urlStr: String = abilityDict["url"] as? String,
                   let url: URL = URL(string: urlStr) {
                    let id: String = url.lastPathComponent
                    abilityDict["id"] = id
                }
                abilityDict.removeValue(forKey: "url")
                newAbilities.append(abilityDict)
            }
            pokemon["abilities"] = newAbilities
            
            let types:[Any] = pokemon["types"] as? [Any] ?? []
            var newTypes:[Any] = []
            for type in types {
                let dictionary:[String:Any] = type as? [String:Any] ?? [:]
                var typeDict:[String:Any] = dictionary["type"] as? [String:Any] ?? [:]
                if let urlStr: String = typeDict["url"] as? String,
                   let url: URL = URL(string: urlStr) {
                    let id: String = url.lastPathComponent
                    typeDict["id"] = id
                }
                typeDict.removeValue(forKey: "url")
                newTypes.append(typeDict)
            }
            pokemon["types"] = newTypes
            
            let stats:[Any] = pokemon["stats"] as? [Any] ?? []
            for stat in stats {
                let dictionary:[String:Any] = stat as? [String:Any] ?? [:]
                let statDict:[String:Any] = dictionary["stat"] as? [String:Any] ?? [:]
                let name: String = statDict["name"] as? String ?? ""
                let base_stat: Int = dictionary["base_stat"] as? Int ?? 0
                pokemon[name] = base_stat
            }
            pokemon.removeValue(forKey: "stats")
            
            self.apiManager.call(type: EndpointItem.pokemonSpeciesById(id)) { (response, error) in
                guard let species:[String:Any] = response as? [String:Any] else {
                    return
                }
                pokemon["captureRate"] = species["capture_rate"]
                let habitat:[String:Any] = species["habitat"] as? [String:Any] ?? [:]
                pokemon["habitat"] = habitat["name"]
                let generation:[String:Any] = species["generation"] as? [String:Any] ?? [:]
                pokemon["generation"] = generation["name"]
                pokemon["isComplete"] = true
                
                self.out.loadObject(pokemon)
                let evolutionChainDict: [String:Any] = species["evolution_chain"] as? [String:Any] ?? [:]
                let evolutionChain: String = evolutionChainDict["url"] as? String ?? ""
                if let evolutionChainUrl: URL = URL(string: evolutionChain) {
                    let id: String = evolutionChainUrl.lastPathComponent
                    self.apiManager.call(type: EndpointItem.evolutionChainById(Int(id)!)) { (response, error) in
                        guard let evolves:[String:Any] = response as? [String:Any] else {
                            return
                        }
                        
                        var isEvolves: Bool = true
                        var chain:[String:Any] = evolves["chain"] as? [String:Any] ?? [:]
                        let species:[String:Any] = chain["species"] as? [String:Any] ?? [:]
                        var baseEvolvedId: String = ""
                        if let urlStr:String = species["url"] as? String, let url: URL = URL(string: urlStr) {
                            baseEvolvedId = url.lastPathComponent
                        }
                        var evolutions:[Any] = []
                        while(isEvolves) {
                            var evolutionDict:[String:Any] = [:]
                            evolutionDict["evolvesBaseId"] = baseEvolvedId
                            let evolvesTo:[Any] = chain["evolves_to"] as? [Any] ?? []
                            
                            var evolvesFromId: String = ""
                            let speciesFrom:[String:Any] = chain["species"] as? [String:Any] ?? [:]
                            if let urlStr:String = speciesFrom["url"] as? String, let url: URL = URL(string: urlStr) {
                                evolvesFromId = url.lastPathComponent
                                evolutionDict["evolvesFromId"] = evolvesFromId
                            }

                            if evolvesTo.count > 0 {
                                let evolvesToDictionary: [String:Any] = evolvesTo.first as? [String:Any] ?? [:]
                                let evolDetails:[Any] = evolvesToDictionary["evolution_details"] as? [Any] ?? []
                                let evolDetailsDictionary: [String:Any] = evolDetails.first as? [String:Any] ?? [:]
                                let minLevel: Int = evolDetailsDictionary["min_level"] as? Int ?? 0
                                evolutionDict["minLevel"] = minLevel
                                
                                chain = evolvesToDictionary
                                let speciesTo:[String:Any] = evolvesToDictionary["species"] as? [String:Any] ?? [:]
                                var evolvesToId: String = ""
                                if let urlStr:String = speciesTo["url"] as? String, let url: URL = URL(string: urlStr) {
                                    evolvesToId = url.lastPathComponent
                                    evolutionDict["evolvesToId"] = evolvesToId
                                }
                                evolutions.append(evolutionDict)
                            } else {
                                isEvolves = false
                            }
                        }
//                        print("evol \(evolutions)")
                        self.out.loadEvolve(evolutions)
                    }
                }
            }
        }
    }
}
