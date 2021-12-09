//
//  ReminderRepository.swift
//  Rewind
//
//  Created by Fernando de Lucas da Silva Gomes on 08/12/21.
//

import CoreData

class ReminderRepository: Repository {
    
    typealias CoreDataObject = Lembrete
    typealias ResponseObject = Reminder
    
    private let service = CoreDataService<Lembrete>()

    func save(_ object: Reminder) -> Bool{
       let lembrete = service.new()
        lembrete?.title = object.title
        lembrete?.time = object.time
        return service.save()
    }
    
    func fetch() -> [Lembrete]? {
        return service.retriveAll()
    }
    
    func delete(title: String) -> Lembrete? {
        let predicate = NSPredicate(format: "title = %@", title)
        if let object = service.retrive(predicate: predicate) {
            return service.delete(object: object)
        } else {
            return nil
        }
    }
}
