//
//  Constrainable.swift
//  Rewind
//
//  Created by Fernando de Lucas da Silva Gomes on 08/12/21.
//

import UIKit

protocol Constrainable: UIView {}

extension Constrainable {
    
    func prepareForLayout() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }

    @discardableResult
    func anchor<T, S>(
                    _ from: KeyPath<UIView, T>,
                    to referenceView: S,
                    equal to: KeyPath<S, T>,
                    multiplier: CGFloat
                    ) -> Self where T: NSLayoutDimension{
            self[keyPath: from].constraint(equalTo: referenceView[keyPath: to], multiplier: multiplier).isActive = true
            return self
    }
    
    @discardableResult
    func anchor<T, Axis, S>(
                        _ from: KeyPath<UIView, T>,
                        to referenceView: S,
                        equal to: KeyPath<S, T>)
                        -> Self where T: NSLayoutAnchor<Axis>{
            self[keyPath: from].constraint(equalTo: referenceView[keyPath: to]).isActive = true
            return self
    }
    
    @discardableResult
    func anchorToSafeArea<S>(
                            to referenceView: S
                            ) -> Self where S: UILayoutGuide{
        prepareForLayout()
        self.anchor(\.topAnchor, to: referenceView, equal: \.topAnchor)
        self.anchor(\.leadingAnchor, to: referenceView, equal: \.leadingAnchor)
        self.anchor(\.trailingAnchor, to: referenceView, equal: \.trailingAnchor)
        self.anchor(\.bottomAnchor, to: referenceView, equal: \.bottomAnchor)
        return self
    }
    
    @discardableResult
    func anchorToSuperView<S>(
                            to referenceView: S
                            ) -> Self where S: UIView{
        prepareForLayout()
        self.anchor(\.topAnchor, to: referenceView, equal: \.topAnchor)
        self.anchor(\.leadingAnchor, to: referenceView, equal: \.leadingAnchor)
        self.anchor(\.trailingAnchor, to: referenceView, equal: \.trailingAnchor)
        self.anchor(\.bottomAnchor, to: referenceView, equal: \.bottomAnchor)
        return self
    }
}

extension UIView: Constrainable {}
