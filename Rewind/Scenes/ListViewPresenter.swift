//
//  ListViewPresenter.swift
//  Rewind
//
//  Created by Fernando de Lucas da Silva Gomes on 03/12/21.
//

import Foundation
import UIKit

protocol Presenter: AnyObject {
    associatedtype ViewModel
    func interactor(didRetrieve itens: [ViewModel])
}

protocol ListPresenter: Presenter{}

class ListViewPresenter: ListPresenter {
    
    typealias ViewModel = Reminder
    
    weak var view: ListViewController?
    
    func interactor(didRetrieve itens: [Reminder]) {
        view?.updateItens(itens)
    }
    
}

struct Reminder{
    var title: String
    var time: String
}
