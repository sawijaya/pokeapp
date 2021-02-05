//
//  PokemonRealmService.swift
//  pokeapp
//
//  Created by Salim Wijaya on 03/02/21.
//

import Foundation
import CoreData

protocol IPokemonRealmService {
    func fetchPokemon(_ limit: Int, offset: Int, handler: ([Pokemon]) -> ())
    
    func insertPokemons(_ pokemons:[[String:Any]])
}

protocol IPokemonCoreDataServiceOut: class {
    func loadPokemon(_ pokemon:[Pokemon])
}

class PokemonRealmService: IPokemonRealmService {
    var out: IPokemonCoreDataServiceOut!
    func insertPokemons(_ pokemons: [[String:Any]]) {
        let insertRequest = NSBatchInsertRequest(entity: Pokemon.entity(), objects: pokemons)
        let persistentContainer: NSPersistentContainer = CoreDataStack.shared.persistentContainer
        let taskContext = persistentContainer.newBackgroundContext()
        taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        taskContext.undoManager = nil
        
        try! taskContext.execute(insertRequest)
        try! taskContext.save()
    }
    
    func fetchPokemon(_ limit: Int, offset: Int, handler: ([Pokemon]) -> ()) {
        let persistentContainer: NSPersistentContainer = CoreDataStack.shared.persistentContainer
        let pokemonRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Pokemon")
        pokemonRequest.fetchLimit = limit
        pokemonRequest.fetchOffset = offset
        let taskContext = persistentContainer.newBackgroundContext()
        taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        taskContext.undoManager = nil
        let result = try? taskContext.fetch(pokemonRequest)
        self.out.loadPokemon(result as? [Pokemon] ?? [])
//        handler(result as! [Pokemon])
    }
    
    // MARK: - Vars & Lets
    
    // MARK: - Initialization
    init() { }
}
