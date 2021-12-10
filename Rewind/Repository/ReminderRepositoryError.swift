//
//  ReminderRepositoryError.swift
//  Rewind
//
//  Created by Fernando de Lucas da Silva Gomes on 09/12/21.
//

struct ReminderRepositoryError: Error {
    var error: ReminderError
    var cause: ManagedObjectError.Lembrete?
    
    enum ReminderError: Error {
        case FailSave
        case FailCreatingObject
        case FailToFetch
        case FailToDelete
    }
}
