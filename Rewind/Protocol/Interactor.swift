//
//  Interactor.swift
//  Rewind
//
//  Created by Fernando de Lucas da Silva Gomes on 09/12/21.
//

import Foundation

protocol Interactor {
    associatedtype WorkerRequestableObject
    associatedtype Response
    func transform(_ objects: [WorkerRequestableObject]) -> [Response]
}
