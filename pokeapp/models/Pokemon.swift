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
    @NSManaged var captureRate: NSNumber
    @NSManaged var generation: String
    @NSManaged var habitat: String
    @NSManaged var hp: NSNumber
    @NSManaged var attack: NSNumber
    @NSManaged var defence: NSNumber
    @NSManaged var spcAttack: NSNumber
    @NSManaged var spcDefence: NSNumber
    @NSManaged var speed: NSNumber
    @NSManaged var weight: NSNumber
    @NSManaged var height: NSNumber
}
