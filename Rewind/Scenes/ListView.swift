//
//  ListView.swift
//  Rewind
//
//  Created by Fernando de Lucas da Silva Gomes on 03/12/21.
//

import Foundation
import UIKit

class ListView: UIView {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 100
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildHierarchy()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildHierarchy() {
        self.addSubview(tableView)
    }

    private func setupConstraints() {
        tableView.anchorToSuperView(to: self)
    }
    
    public func performUpdates(_ updates: (() -> Void)?) {
        self.tableView.performBatchUpdates(updates, completion: nil)
    }
    
    func bind<t: UITableViewSource>(_ source: t) {
        self.tableView.delegate = source
        self.tableView.dataSource = source
    }
    
    public func reloadData() {
        self.tableView.reloadData()
    }
}

protocol UITableViewSource: UITableViewDelegate, UITableViewDataSource {}
