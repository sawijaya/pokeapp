//
//  Evolution.swift
//  pokeapp
//
//  Created by Salim Wijaya on 06/02/21.
//

import Foundation
import CoreData

public class Evolution: NSManagedObject {
    @NSManaged var evolvesBaseId: String
    @NSManaged var evolvesToId: String
    @NSManaged var evolvesFromId: String
    @NSManaged var minLevel: NSNumber
    
    /*
         base_evolved: Int (id pokemon)     (eg bulbasaur)    | (eg bulbasaur)
         evolves_to: Int (id pokemon)     (eg ivysaur)     | (eg venusaur)
         evolves_from: Int (id pokemon)     (eg bulbasaur)    | (eg ivysaur)
         min_level: Int                    16                | 32
     **/
}
