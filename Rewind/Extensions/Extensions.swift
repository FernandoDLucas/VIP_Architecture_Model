//
//  Extensions.swift
//  Rewind
//
//  Created by Fernando de Lucas da Silva Gomes on 09/12/21.
//

import Foundation

extension Date {
    public var toString:  String {
        let formater = DateFormatter()
        formater.dateFormat = "dd.MM.yyyy HH:MM"
        return formater.string(from: self)
    }
}
