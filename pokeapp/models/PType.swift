//
//  PType.swift
//  pokeapp
//
//  Created by Salim Wijaya on 05/02/21.
//

import Foundation
import CoreData

public class PType: NSManagedObject {
    @NSManaged var id: String
    @NSManaged var name: String
}
