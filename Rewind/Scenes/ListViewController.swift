//
//  ListViewController.swift
//  Rewind
//
//  Created by Fernando de Lucas da Silva Gomes on 03/12/21.
//

import Foundation
import UIKit

class ListViewController: UIViewController {
    
    var viewModel: [Reminder] = []

    var interactor: ListViewInteractor?

    let mainView: ListView = {
        let view = ListView()
        return view
    }()
    
    lazy var barButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add,
                                     target: self,
                                     action: #selector(addItem))
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        buildHierarchy()
        setupConstraints()
        mainView.bind(self)
        setupVIP()
        self.navigationItem.setRightBarButton(barButton, animated: false)
    }
    
    private func buildHierarchy() {
        self.view.addSubview(mainView)
    }

    private func setupConstraints() {
        mainView.anchorToSafeArea(to: self.view.safeAreaLayoutGuide)
    }
    
    func setupVIP() {
        let presenter = ListViewPresenter()
        let interactor = ListViewInteractor(presenter: presenter)
        presenter.view = self
        self.interactor = interactor
    }
    
    @objc
    func addItem() {
        let alert = PresentFieldAlert(title: "Lembrete", message: "Adicione um lembrete", preferredStyle: .alert)
        alert.prepareAnd { text in
            self.interactor?.addItem(text)
        }
        present(alert, animated: true, completion: nil)
    }
    
    public func updateItens(_ itens: [Reminder]) {
        self.viewModel = itens
        self.mainView.reloadData()
    }
}

extension ListViewController: UITableViewSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView
            .dequeueReusableCell(withIdentifier: "Cell")!
        var config = UIListContentConfiguration.cell()
        config.text = viewModel[indexPath.row].title
        config.secondaryText = viewModel[indexPath.row].time
        cell.contentConfiguration = config
        cell.selectionStyle = .none
        return cell
    }
}
