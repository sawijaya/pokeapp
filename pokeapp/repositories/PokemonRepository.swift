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
    func fetchPokemon(_ limit: Int, offset: Int)
}

protocol IPokemonRepositoryOut: class {
    func loadPokemons(_ pokemons:[NSDictionary], limit: Int, offset: Int)
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
    
}
