//
//  AppColor.swift
//  YandexMap
//
//  Created by emil kurbanov on 27.02.2023.
//

import UIKit

enum AppColor {

    private static let missingColor: UIColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
    // MARK: - Old Desine color set
    static let green = UIColor(named: "primary") ?? missingColor
    static let orange = UIColor(named: "secondary") ?? missingColor
    static let black = UIColor(named: "black") ?? missingColor
    static let grey = UIColor(named: "grey") ?? missingColor

    static let lightGray = UIColor(named: "lightGray") ?? missingColor
    static let greenMain = UIColor(named: "greenMain") ?? missingColor

    static let greenBackground = UIColor(named: "greenBackground") ?? missingColor
    static let orangeBackground = UIColor(named: "orangeBackground") ?? missingColor
    static let favorableBackground = UIColor(named: "favorableBackground") ?? missingColor

    // MARK: - New Desine color set
    static let white = UIColor(named: "white") ?? missingColor
    static let OrangeMain = UIColor(named: "orangeMain") ?? missingColor
    static let GreenSecondary = UIColor(named: "greenSecondary") ?? missingColor
    static let TextIcons = UIColor(named: "TextIcons") ?? missingColor
    static let redLike = UIColor(named: "redLike") ?? missingColor
    static let disabledButton = UIColor(named: "disabledButton") ?? missingColor
    static let background2 = UIColor(named: "background2") ?? missingColor
    static let background3 = UIColor(named: "background3") ?? missingColor
    static let background4 = UIColor(named: "background4") ?? missingColor
    static let background5 = UIColor(named: "background5") ?? missingColor
    static let disabledTextIcon = UIColor(named: "disabledTextIcon") ?? missingColor
    static let bodyText = UIColor(named: "bodyText") ?? missingColor
    static let ScrollMini = UIColor(named: "ScrollMini") ?? missingColor
    static let tabBarBackground = UIColor(named: "tabBarBackground") ?? missingColor
    static let tabBarBorder = UIColor(named: "tabBarBorder") ?? missingColor
    
}

