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
        switch worker.save(reminder) {
        case .success( _ ):
            self.fetchItens()
        case .failure(let error):
            presenter.didFailed(with: error.localizedDescription)
        }
    }
    
    func fetchItens() {
        switch worker.fetch(){
        case .success(let objects):
            presenter.interactor(didRetrieve: transform(objects))
        case .failure(let error):
            presenter.didFailed(with: error.localizedDescription)
        }
    }
    
    func deleteItem(with time: String) {
        switch worker.delete(title: time) {
        case .success( _ ):
            self.fetchItens()
        case .failure(let error):
            presenter.didFailed(with: error.localizedDescription)
        }
    }
    
    func transform(_ objects: [Lembrete]) -> [Reminder] {
        return objects.map { lembrete in
            Reminder(title: lembrete.title, time: lembrete.time)
        }
    }
    
}
