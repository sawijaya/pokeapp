//
//  Pokemon.swift
//  pokeapp
//
//  Created by Salim Wijaya on 03/02/21.
//

import Foundation
import CoreData

public class Pokemon: NSManagedObject {
    @NSManaged var id: String
    @NSManaged var name: String
    @NSManaged var image: String
    @NSManaged var captureRate: Int
    @NSManaged var generation: String
    @NSManaged var habitat: String
    @NSManaged var hp: Int
    @NSManaged var attack: Int
    @NSManaged var defense: Int
    @NSManaged var spcAttack: Int
    @NSManaged var spcDefence: Int
    @NSManaged var speed: Int
    @NSManaged var weight: Int
    @NSManaged var height: Int
    @NSManaged var isComplete: Bool
    @NSManaged var types: NSSet?
}
