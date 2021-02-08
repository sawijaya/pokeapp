//
//  AbilityPokemon.swift
//  pokeapp
//
//  Created by Salim Wijaya on 05/02/21.
//

import Foundation
import CoreData

public class AbilityPokemon: NSManagedObject {
    @NSManaged var abilityId: String
    @NSManaged var pokemonId: String
}
