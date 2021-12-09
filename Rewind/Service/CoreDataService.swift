//
//  CoreDataService.swift
//  Rewind
//
//  Created by Fernando de Lucas da Silva Gomes on 08/12/21.
//

import CoreData

class CoreDataService<T: NSManagedObject> {
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Rewind")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    lazy var context: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()

    func new() -> T? {
        guard let entity = NSEntityDescription.entity(forEntityName: T.entityName, in: context)
        else { return nil }
        return T(entity: entity, insertInto: context)
    }
    
    func save() -> Bool {
        do {
            try context.save()
            return true
        } catch {
            return false
        }
    }
    
    func delete(object: T) -> T? {
        context.delete(object)
        do {
            try context.save()
            return object
        } catch {
            return nil
        }
    }
    
    func retriveAll() -> [T]? {
        let fetch = NSFetchRequest<T>(entityName: T.entityName)
        do {
            let objects = try context.fetch(fetch)
            return objects
        } catch {
            return nil
        }
    }
    
    func retrive(predicate: NSPredicate) -> T? {
        let fetch = NSFetchRequest<T>(entityName: T.entityName)
        fetch.sortDescriptors = [NSSortDescriptor(key: Schema.Album.Field.title.rawValue, ascending: true)]
        fetch.predicate  = predicate
        do {
            let objects = try context.fetch(fetch)
            return objects.first
        } catch let error as NSError {
            print(error)
            return nil
        }
    }
}

extension NSManagedObject {
    static var entityName: String {
        return String(describing: self)
    }
}
