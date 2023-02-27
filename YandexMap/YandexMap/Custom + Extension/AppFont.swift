//
//  AppFont.swift
//  YandexMap
//
//  Created by emil kurbanov on 27.02.2023.
//

import UIKit

struct AppFont {

    enum OpenSansWeight: String {
        case regular = "-Regular"
        case medium = "-Medium"
        case semiBold = "-SemiBold"
        case bold = "-Bold"
    }

    static func openSansFont(ofSize size: CGFloat = UIFont.systemFontSize, weight: OpenSansWeight = .regular) -> UIFont {
        return UIFont(name: "OpenSans\(weight.rawValue)", size: size) ?? .systemFont(ofSize: size)
    }
}
