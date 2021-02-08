//
//  PokemonRepository.swift
//  pokeapp
//
//  Created by Salim Wijaya on 03/02/21.
//

import Foundation
import CoreData

protocol IPokemonRepository {
    func insertBatchPokemons(_ pokemons: [[String:Any]])
    
    func insertBatchType(_ types: [[String:Any]])
    
    func insertBatchAbility(_ ability: [[String:Any]])
    
    func fetchPokemon(_ limit: Int, offset: Int)
    
    func fetchPokemonById(_ id: Int)
    
    func updatePokemon(_ pokemon:[String:Any])
    
    func fetchType()
    
    func fetchAbility()
}

protocol IPokemonRepositoryOut: class {
    func loadPokemons(_ pokemons:[NSDictionary], limit: Int, offset: Int)
    
    func loadPokemon(_ pokemon:NSDictionary)
    
    func loadTypes(_ types:[NSDictionary])
    
    func loadAbility(_ abilities:[NSDictionary])
}

class PokemonRepository: IPokemonRepository {
    var out: IPokemonRepositoryOut!
    // MARK: - Initialization
    init() { }
    
    func insertBatchPokemons(_ pokemons: [[String:Any]]) {
        print(#function)
        let insertRequest = NSBatchInsertRequest(entity: Pokemon.entity(), objects: pokemons)
        let persistentContainer: NSPersistentContainer = CoreDataStack.shared.persistentContainer
        let taskContext = persistentContainer.newBackgroundContext()
        taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        taskContext.undoManager = nil
        
        do {
            try taskContext.execute(insertRequest)
        } catch {
            print("execute \(error)")
        }
        
        do {
            try taskContext.save()
            if let dictionary: [NSDictionary] = pokemons as? [NSDictionary] {
                self.out.loadPokemons(dictionary, limit: 0, offset: 0)
            }
        } catch {
            print("save \(error)")
        }
    }
    
    func fetchPokemon(_ limit: Int, offset: Int) {
        let persistentContainer: NSPersistentContainer = CoreDataStack.shared.persistentContainer
        let pokemonRequest = NSFetchRequest<NSDictionary>(entityName: "Pokemon")
        pokemonRequest.fetchLimit = limit
        pokemonRequest.fetchOffset = offset
        pokemonRequest.returnsObjectsAsFaults = false
        pokemonRequest.resultType = .dictionaryResultType
        let taskContext = persistentContainer.newBackgroundContext()
        taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        taskContext.undoManager = nil
        
        do {
            let result = try taskContext.fetch(pokemonRequest)
            self.out.loadPokemons(result, limit: limit, offset: offset)
        } catch {
            print(error)
        }
//        print(result?.count)
//        self.out.loadPokemons([], limit: limit, offset: offset)
    }
    
    func fetchPokemonById(_ id: Int) {
        let persistentContainer: NSPersistentContainer = CoreDataStack.shared.persistentContainer
        let pokemonRequest = NSFetchRequest<NSDictionary>(entityName: "Pokemon")
        pokemonRequest.resultType = .dictionaryResultType
        pokemonRequest.predicate = NSPredicate(format: "id == %@", "\(id)")
        let taskContext = persistentContainer.newBackgroundContext()
        taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        taskContext.undoManager = nil
        do {
            let result = try taskContext.fetch(pokemonRequest)
            if let first = result.first {
                var dictionary: [String:Any] = first as? [String:Any] ?? [:]
                if let typePokemon: [NSDictionary] = self.fetchTypePokemonById(id) {
                    dictionary["types"] = typePokemon
                }
                self.out.loadPokemon(dictionary as NSDictionary)
            }
        } catch {
            print(error)
        }
    }
    
    private func fetchTypePokemonById(_ id: Int) -> [NSDictionary]? {
        let persistentContainer: NSPersistentContainer = CoreDataStack.shared.persistentContainer
        let request = NSFetchRequest<NSDictionary>(entityName: "TypePokemon")
        request.resultType = .dictionaryResultType
        request.predicate = NSPredicate(format: "pokemonId == %@", "\(id)")
        let taskContext = persistentContainer.newBackgroundContext()
        taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        taskContext.undoManager = nil
        do {
            let result = try taskContext.fetch(request)
            return result
        } catch {
            print(error)
        }
        return nil
    }
    
    func fetchType() {
        let persistentContainer: NSPersistentContainer = CoreDataStack.shared.persistentContainer
        let typeRequest = NSFetchRequest<NSDictionary>(entityName: "PType")
        typeRequest.resultType = .dictionaryResultType
        typeRequest.fetchLimit = 20
        let taskContext = persistentContainer.newBackgroundContext()
        taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        taskContext.undoManager = nil
        
        do {
            let result = try taskContext.fetch(typeRequest)
            self.out.loadTypes(result)
        } catch {
            print(error)
        }
        
    }
    
    func fetchAbility() {
        let persistentContainer: NSPersistentContainer = CoreDataStack.shared.persistentContainer
        let request = NSFetchRequest<NSDictionary>(entityName: "Ability")
        request.fetchLimit = 327
        request.resultType = .dictionaryResultType
        let taskContext = persistentContainer.newBackgroundContext()
        taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        taskContext.undoManager = nil
        
        do {
            let result = try taskContext.fetch(request)
            self.out.loadAbility(result)
        } catch {
            print(error)
        }
    }
    
    func insertBatchType(_ types: [[String : Any]]) {
        print(#function)
        let insertRequest = NSBatchInsertRequest(entity: PType.entity(), objects: types)
        let persistentContainer: NSPersistentContainer = CoreDataStack.shared.persistentContainer
        let taskContext = persistentContainer.newBackgroundContext()
        taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        taskContext.undoManager = nil
        
        do {
            try taskContext.execute(insertRequest)
        } catch {
            print("execute \(error)")
        }
        
        do {
            try taskContext.save()
        } catch {
            print("save \(error)")
        }
    }
    
    func insertBatchAbility(_ abilities: [[String : Any]]) {
        print(#function, abilities.count)
        let insertRequest = NSBatchInsertRequest(entity: Ability.entity(), objects: abilities)
        let persistentContainer: NSPersistentContainer = CoreDataStack.shared.persistentContainer
        let taskContext = persistentContainer.newBackgroundContext()
        taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        taskContext.undoManager = nil
        
        do {
            try taskContext.execute(insertRequest)
        } catch {
            print("execute \(error)")
        }
        
        do {
            try taskContext.save()
        } catch {
            print("save \(error)")
        }
    }
    
    func updatePokemon(_ pokemon: [String : Any]) {
        print(pokemon)
        let id: Int = pokemon["id"] as? Int ?? -1
        let persistentContainer: NSPersistentContainer = CoreDataStack.shared.persistentContainer
        let pokemonRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Pokemon")
        pokemonRequest.predicate = NSPredicate(format: "id == %@", "\(id)")
        let taskContext = persistentContainer.newBackgroundContext()
        taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        taskContext.undoManager = nil
        do {
            let result = try taskContext.fetch(pokemonRequest)
            if let object = result.first as? NSManagedObject {
                let type:[[String:Any]] = pokemon["types"] as? [[String:Any]] ?? []
                self.insertUpdateType(type, atPokemon: id)
                
                print(pokemon)
                let attack: Int = pokemon["attack"] as? Int ?? 0
                object.setValue(attack, forKey: "attack")
                
                let defense: Int = pokemon["defense"] as? Int ?? 0
                object.setValue(defense, forKey: "defense")
                
                let spcDefence: Int = pokemon["special-defense"] as? Int ?? 0
                object.setValue(spcDefence, forKey: "spcDefense")
                
                let spcAttack: Int = pokemon["special-attack"] as? Int ?? 0
                object.setValue(spcAttack, forKey: "spcAttack")
                
                let habitat: String = pokemon["habitat"] as? String ?? ""
                object.setValue(habitat, forKey: "habitat")
                
                let generation: String = pokemon["generation"] as? String ?? ""
                object.setValue(generation, forKey: "generation")
                
                let color: String = pokemon["color"] as? String ?? ""
                object.setValue(color, forKey: "color")
                
                let desc: String = pokemon["desc"] as? String ?? ""
                object.setValue(desc, forKey: "desc")
                
                let height: Int = pokemon["height"] as? Int ?? 0
                object.setValue(height, forKey: "height")
                
                let weight: Int = pokemon["weight"] as? Int ?? 0
                object.setValue(weight, forKey: "weight")
                
                let captureRate: Int = pokemon["captureRate"] as? Int ?? 0
                object.setValue(captureRate, forKey: "captureRate")
                
                let speed: Int = pokemon["speed"] as? Int ?? 0
                object.setValue(speed, forKey: "speed")
                
                let hp: Int = pokemon["hp"] as? Int ?? 0
                object.setValue(hp, forKey: "hp")
                
                let isComplete: Bool = pokemon["isComplete"] as? Bool ?? false
                object.setValue(isComplete, forKey: "isComplete")
                
                do {
                    try taskContext.save()
                    self.fetchPokemonById(id)
                }
                catch {
                    print(error)
                }
            }
            print(result)
        } catch {
            print(error)
        }
    }
    
    func insertUpdateType(_ type:[[String:Any]], atPokemon pokemonId: Int){
        print(#function)
        let persistentContainer: NSPersistentContainer = CoreDataStack.shared.persistentContainer
        let typeRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TypePokemon")
        typeRequest.predicate = NSPredicate(format: "pokemonId == %@", "\(pokemonId)")
        let taskContext = persistentContainer.newBackgroundContext()
        taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        taskContext.undoManager = nil
        do {
            let result = try taskContext.fetch(typeRequest)
            if result.count == 0 {
                print("insert New")
                var typesInsert:[[String:Any]] = []
                for item in type {
                    var typeDict:[String:Any] = item as? [String: Any] ?? [:]
                    typeDict["pokemonId"] = "\(pokemonId)"
                    typesInsert.append(typeDict)
                }
                print(typesInsert)
//                var types:[String:Any] =
                let insertRequest = NSBatchInsertRequest(entity: TypePokemon.entity(), objects: typesInsert)
                do {
                    print(typesInsert)
                    try taskContext.execute(insertRequest)
                } catch {
                    print("execute \(error)")
                }
                
                do {
                    try taskContext.save()
                } catch {
                    print("save \(error)")
                }
            }
        } catch {
            
        }
    }
}
