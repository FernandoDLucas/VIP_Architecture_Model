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
    
//    private let persistentContainer: NSPersistentContainer = {
//        let appDelegate = UIApplication.shared.delegate as? AppDelegate
//        let container = appDelegate?.persistentContainer
//        guard let persistentContainer = container else { fatalError() }
//        return persistentContainer
//    }()
    
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
