//
//  ManagedObjectError.swift
//  Rewind
//
//  Created by Fernando de Lucas da Silva Gomes on 09/12/21.
//

import Foundation

struct ManagedObjectError {
    enum Lembrete: Error {
        case TitleIsNil, TimeIsNil
    }
}
