//
//  UITextField + leftView.swift
//  YandexMap
//
//  Created by emil kurbanov on 27.02.2023.
//

import UIKit
extension UITextField {
    func setLeftIndent(_ point: CGFloat) {
        let indentView = UIView(frame: CGRect(x: 0, y: 0, width: point, height: self.frame.size.height))
        self.leftView = indentView
        self.leftViewMode = .always
    }
}

