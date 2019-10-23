//
//  Storage.swift
//  WeatherApp
//
//  Created by Edward Addley on 23/10/2019.
//  Copyright © 2019 AddHop Ltd. All rights reserved.
//

import Foundation
import CoreData
import Combine

protocol Storage: class {
    var poc: NSPersistentContainer { get }

    func fetchFavouriteList() -> [Favourite]
    func save()
}

extension Storage {
    func fetchFavouriteList() -> [Favourite] {

        let request = NSFetchRequest<Favourite>(entityName: "Favourite")
        var results: [Favourite] = []
        do {
            results = try poc.viewContext.fetch(request)
        } catch {
            print(error)
        }

        return results
    }

    func createFavourite() -> Favourite {
        return Favourite.create(moc: poc.viewContext)
    }

    func delete(favourite: Favourite) {
        let moc = poc.viewContext
        moc.delete(favourite)
        save()
    }
}

class CoreDataRepository: Storage {
    lazy var poc: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores { _, error in
            if let err = error {
                print(err)
            }
        }
        return container
    }()

    init() {
    }

    private static var instance = CoreDataRepository()
    static var shared: Storage {
        return instance
    }

    func save() {
        let moc = poc.viewContext

        if moc.hasChanges {
            do {
                try moc.save()
            } catch {
                print(error)
            }
        }
    }
}
