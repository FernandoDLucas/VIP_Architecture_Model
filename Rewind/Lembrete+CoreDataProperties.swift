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

}

extension Lembrete : Identifiable {

}

