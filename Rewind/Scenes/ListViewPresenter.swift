//
//  ListViewPresenter.swift
//  Rewind
//
//  Created by Fernando de Lucas da Silva Gomes on 03/12/21.
//

import Foundation

protocol ListViewPresentationLogic: AnyObject {
    func present(viewModel: [ReminderViewModel])
    func updateValues()
}
class ListViewPresenter: Presenter {
    
    typealias ViewModel = ReminderViewModel
    typealias Response = Reminder
    
    weak var delegate: ListViewPresentationLogic?
    
    func interactor(didRetrieve itens: [Response]) {
        delegate?.present(viewModel: transform(itens))
    }
    
    func transform(_ objects: [Reminder]) -> [ReminderViewModel] {
        return objects.map { reminder in
            ReminderViewModel(title: reminder.title!, time: reminder.time!.toString)
        }
    }
}
