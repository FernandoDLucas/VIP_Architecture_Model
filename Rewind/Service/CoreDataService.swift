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
    
    func save() throws{
        try context.save()
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
    
    func reset() {
        context.reset()
    }
    
    func retriveAll() throws -> [T] {
        let fetch = NSFetchRequest<T>(entityName: T.entityName)
        return try context.fetch(fetch)
    }
    
    func retrive(predicate: NSPredicate) throws -> T? {
        let fetch = NSFetchRequest<T>(entityName: T.entityName)
        fetch.sortDescriptors = [NSSortDescriptor(key: Schema.Album.Field.title.rawValue, ascending: true)]
        fetch.predicate  = predicate
        return try context.fetch(fetch).first
    }
}

extension NSManagedObject {
    static var entityName: String {
        return String(describing: self)
    }
}
