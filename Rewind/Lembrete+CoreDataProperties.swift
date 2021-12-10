//
//  Lembrete+CoreDataProperties.swift
//  Rewind
//
//  Created by Fernando de Lucas da Silva Gomes on 08/12/21.
//
//

import Foundation
import CoreData


extension Lembrete {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Lembrete> {
        return NSFetchRequest<Lembrete>(entityName: "Lembrete")
    }
    
    @NSManaged public var time: Date?
    @NSManaged public var title: String?
    
    
    public override func validateForInsert() throws {
        try super.validateForInsert()
        try validate()
    }
    
    func validate() throws {
        if self.title == nil {
            throw ManagedObjectError.Lembrete.TitleIsNil
        }
        if self.time == nil {
            throw ManagedObjectError.Lembrete.TimeIsNil
        }
    }
    
}

extension Lembrete : Identifiable {
    
}
