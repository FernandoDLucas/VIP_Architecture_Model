//
//  ListViewInteractor.swift
//  Rewind
//
//  Created by Fernando de Lucas da Silva Gomes on 03/12/21.
//

import Foundation

class ListViewInteractor: Interactor {
    
    private var presenter: ListViewPresenter
    private let worker: ReminderRepository

    init(presenter: ListViewPresenter){
        self.presenter = presenter
        self.worker = ReminderRepository()
    }

    func addItem(_ item: String?) {
        guard let item = item else {
            return
        }
        let reminder = (Reminder(title: item, time: Date()))
        if worker.save(reminder) {
            if let objects = worker.fetch() {
                presenter.interactor(didRetrieve: transform(objects))
            }
        }
    }
    
    func fetchItens() {
        if let objects = worker.fetch() {
            presenter.interactor(didRetrieve: transform(objects))
        }
    }
    
    func deleteItem(with time: String) {
        _ = worker.delete(title: time)
        self.fetchItens()
    }
    
    func transform(_ objects: [Lembrete]) -> [Reminder] {
        return objects.map { lembrete in
            Reminder(title: lembrete.title, time: lembrete.time)
        }
    }
    
}
