//
//  Router.swift
//  Rewind
//
//  Created by Fernando de Lucas da Silva Gomes on 03/12/21.
//

import Foundation
import UIKit
import CoreData

protocol Router: AnyObject {
    func start(window: UIWindow?)
}

class MainRouter: Router {
    private let listViewController: ListViewController
    
    init() {
        self.listViewController = ListViewController()
    }
    
    func start(window: UIWindow?) {
        let navigationController = UINavigationController(rootViewController: listViewController)
        navigationController.view.backgroundColor = .white
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
