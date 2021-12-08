//
//  PresentFieldAlert.swift
//  Rewind
//
//  Created by Fernando de Lucas da Silva Gomes on 08/12/21.
//

import UIKit

class PresentFieldAlert: UIAlertController {
    
    func prepareAnd(_ action: @escaping ((String?) -> Void)) {
        self.addTextField { _ in }
        let okAction = UIAlertAction(
            title: "Add",
            style: .default
        ) { _ in
            action(self.textFields?.first?.text)
        }
        
        let cancelAction = UIAlertAction(
            title: "Cancel",
            style: .cancel,
            handler: nil
        )
        
        self.addAction(okAction)
        self.addAction(cancelAction)
    }
}

