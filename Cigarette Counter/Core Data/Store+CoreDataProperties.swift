//
//  Store+CoreDataProperties.swift
//  Cigarette Counter
//
//  Created by Abu Umair Jihan on 1/2/18.
//  Copyright © 2018 Abu Umair Jihan. All rights reserved.
//
//

import Foundation
import CoreData


extension Store {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Store> {
        return NSFetchRequest<Store>(entityName: "Store")
    }

    @NSManaged public var name: String?

}
