//
//  CustomTextFild.swift
//  YandexMap
//
//  Created by emil kurbanov on 27.02.2023.
//


import UIKit

final class CustomTextFild: UITextField {

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupPlaceholder(name: "")
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    
    // MARK: - Private Methods

    private func setup() {
       
        layer.borderColor = UIColor.gray.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 10
        setLeftIndent(10)
        translatesAutoresizingMaskIntoConstraints = false
    }
    func setupPlaceholder(name: String){
        placeholder = name
    }

}



