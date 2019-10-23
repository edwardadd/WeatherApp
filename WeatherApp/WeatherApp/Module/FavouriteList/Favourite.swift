//
//  Favourite.swift
//  WeatherApp
//
//  Created by Edward Addley on 23/10/2019.
//  Copyright © 2019 AddHop Ltd. All rights reserved.
//

import Foundation
import CoreData

@objc(Favourite)
class Favourite: NSManagedObject {
    @NSManaged var cityId: Int32
    @NSManaged var name: String

    static func create(moc: NSManagedObjectContext) -> Favourite {
        // swiftlint:disable force_cast
        return NSEntityDescription.insertNewObject(forEntityName: "Favourite", into: moc) as! Favourite
    }
}
