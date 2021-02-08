//
//  TypePokemon.swift
//  pokeapp
//
//  Created by Salim Wijaya on 05/02/21.
//

import Foundation
import CoreData

public class TypePokemon: NSManagedObject {
    @NSManaged var typeId: String
    @NSManaged var pokemonId: String
}
