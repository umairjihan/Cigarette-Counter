//
//  Cigarette+CoreDataProperties.swift
//  Cigarette Counter
//
//  Created by Abu Umair Jihan on 1/2/18.
//  Copyright © 2018 Abu Umair Jihan. All rights reserved.
//
//

import Foundation
import CoreData


extension Cigarette {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Cigarette> {
        return NSFetchRequest<Cigarette>(entityName: "Cigarette")
    }

    @NSManaged public var name: String?
    @NSManaged public var price: Float

}
