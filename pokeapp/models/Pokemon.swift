//
//  Pokemon.swift
//  pokeapp
//
//  Created by Salim Wijaya on 03/02/21.
//

import Foundation
import CoreData
import UIKit

public class Pokemon: NSManagedObject {
    static let colors:[String:UIColor] = ["black":UIColor.black, "blue":UIColor.blue, "brown": UIColor.brown, "gray": UIColor.gray,
                                          "green":UIColor.green, "pink":UIColor.systemPink, "purple":UIColor.purple, "red":UIColor.red,
                                          "white":UIColor.white, "yellow": UIColor.yellow]
    @NSManaged var id: String
    @NSManaged var name: String
    @NSManaged var desc: String
    @NSManaged var image: String
    @NSManaged var color: String
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
    
}
