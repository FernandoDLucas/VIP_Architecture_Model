//
//  ListViewController.swift
//  Rewind
//
//  Created by Fernando de Lucas da Silva Gomes on 03/12/21.
//

import UIKit

class ListViewController: UIViewController {
    
    var viewModel: [ReminderViewModel] = []

    var interactor: ListViewInteractor?

    let mainView: ListView = {
        let view = ListView()
        return view
    }()
    
    lazy var barButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
                                    barButtonSystemItem: .add,
                                    target: self,
                                    action: #selector(addItem)
        )
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        buildHierarchy()
        setupConstraints()
        mainView.bind(self)
        configure()
        self.navigationItem.setRightBarButton(barButton, animated: false)
        self.title = "Adicione um Lembrete"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        interactor?.fetchItens()
    }
    
    private func buildHierarchy() {
        self.view.addSubview(mainView)
    }

    private func setupConstraints() {
        mainView.anchorToSafeArea(of: self.view.safeAreaLayoutGuide)
    }
    
    func configure() {
        let presenter = ListViewPresenter()
        let interactor = ListViewInteractor(presenter: presenter)
        presenter.delegate = self
        self.interactor = interactor
    }
    
    @objc
    func addItem() {
        let alert = PresentFieldAlert(
                                    title: "Lembrete",
                                    message: "Adicione um lembrete",
                                    preferredStyle: .alert
        )
        alert.prepareAnd { text in
            self.interactor?.addItem(text)
        }
        present(alert, animated: true, completion: nil)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = viewModel[indexPath.row]
        interactor?.deleteItem(with: item.title)
    }
}

extension ListViewController: ListViewPresentationLogic {
    func present(viewModel: [ReminderViewModel]) {
        self.viewModel = viewModel
        mainView.reloadData()
    }
    
    func didSaveNewItem(viewModel: ReminderViewModel) {
        self.viewModel.append(viewModel)
        mainView.reloadData()
    }
    
    func updateValues() {
        mainView.reloadData()
    }
    
    func presentError(error: String){
        let alert = PresentFieldAlert(
                                title: "Error",
                                message: "error",
                                preferredStyle: .alert
        )
        present(alert, animated: true, completion: nil)
    }
}
