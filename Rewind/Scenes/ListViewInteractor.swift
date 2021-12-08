//
//  ListViewInteractor.swift
//  Rewind
//
//  Created by Fernando de Lucas da Silva Gomes on 03/12/21.
//

import Foundation

class ListViewInteractor {
    private var itens : [Reminder] = []
    private var presenter: ListViewPresenter
    
    init(presenter: ListViewPresenter){
        self.presenter = presenter
    }
    func addItem(_ item: String?) {
        guard let item = item else {
            return
        }
        self.itens.append(Reminder(title: item, time: Date().dateNow))
        presenter.interactor(didRetrieve: self.itens)
    }
}

extension Date {
    public var dateNow:  String {
        let formater = DateFormatter()
        formater.dateFormat = "dd.MM.yyyy HH:MM"
        return formater.string(from: self)
    }
}
