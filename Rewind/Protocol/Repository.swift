//
//  Repository.swift
//  Rewind
//
//  Created by Fernando de Lucas da Silva Gomes on 08/12/21.
//

import Foundation

protocol Repository {
    associatedtype CoreDataObject
    associatedtype ResponseObject
    func save(_ object: ResponseObject) -> Bool
}
