//
//  ReminderRepository.swift
//  Rewind
//
//  Created by Fernando de Lucas da Silva Gomes on 08/12/21.
//

import CoreData
import UIKit

final class ReminderRepository: Repository {
    
    typealias CoreDataObject = Lembrete
    typealias ResponseObject = Reminder
    public typealias ResultHandler = Result<[Lembrete], ReminderRepositoryError>
    
    var service = CoreDataService<Lembrete>(saveon: .SQLLite)

    @discardableResult
    func save(_ object: Reminder) -> ResultHandler{
        guard let lembrete = service.new() else {
            return .failure(ReminderRepositoryError(error: .FailCreatingObject, cause: nil))
        }
        lembrete.title = object.title
        lembrete.time = object.time
        do {
            try service.save()
            return .success([lembrete])
        } catch (let error as ManagedObjectError.Lembrete){
            _ = service.delete(object: lembrete) //Once i created the object using the new() function i need to delete in case of error or it will remain on context
            return .failure(ReminderRepositoryError(error: .FailSave, cause: error))
        } catch(_){
            return .failure(ReminderRepositoryError(error: .FailSave, cause: nil))
        }
    }
    
    func fetch() -> ResultHandler {
        guard let objects = try? service.retriveAll() else {
            return .failure(ReminderRepositoryError(error: .FailToFetch, cause: nil))
        }
        return .success(objects)
    }
    
    func delete(title: String) -> ResultHandler {
        let predicate = NSPredicate(format: "title = %@", title)
        guard let object = try? service.retrive(predicate: predicate) else {
            return .failure(ReminderRepositoryError(error: .FailToFetch, cause: nil))
        }
        guard let result = service.delete(object: object) else{
            return .failure(ReminderRepositoryError(error: .FailToDelete, cause: nil))
        }
        return .success([result])
    }
}
