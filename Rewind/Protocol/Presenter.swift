//
//  Presenter.swift
//  Rewind
//
//  Created by Fernando de Lucas da Silva Gomes on 09/12/21.
//

import Foundation

protocol Presenter: AnyObject {
    associatedtype ViewModel
    associatedtype Response
    func interactor(didRetrieve itens: [Response])
    func transform(_ objects: [Response]) -> [ViewModel]
}
