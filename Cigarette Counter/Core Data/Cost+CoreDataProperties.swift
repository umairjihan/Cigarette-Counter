//
//  Cost+CoreDataProperties.swift
//  Cigarette Counter
//
//  Created by Abu Umair Jihan on 1/2/18.
//  Copyright © 2018 Abu Umair Jihan. All rights reserved.
//
//

import Foundation
import CoreData


extension Cost {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Cost> {
        return NSFetchRequest<Cost>(entityName: "Cost")
    }

    @NSManaged public var c_count: Int64
    @NSManaged public var c_name: String?
    @NSManaged public var c_price: Float
    @NSManaged public var date: NSDate?
    @NSManaged public var t_count: Int64
    @NSManaged public var t_name: String?
    @NSManaged public var t_price: Float
    @NSManaged public var store: Store?

}
