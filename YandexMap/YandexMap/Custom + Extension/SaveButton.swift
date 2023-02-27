//
//  SaveButton.swift
//  YandexMap
//
//  Created by emil kurbanov on 27.02.2023.
//

import UIKit

final class SaveButton: UIButton {
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // MARK: - Private Methods
    
    private func setup() {
        layer.cornerRadius = 10
        layer.borderColor = AppColor.orange.cgColor
        layer.borderWidth = 1.0
        backgroundColor = AppColor.white
        
        setTitle("Сохранить", for: .normal)
        setTitleColor(AppColor.black, for: .normal)
        addTarget(self, action: #selector(actionButtonAccountLocationTapped), for: .touchUpInside)
        translatesAutoresizingMaskIntoConstraints = false
    }
    @objc func actionButtonAccountLocationTapped() {
        
        backgroundColor = .orange
        setTitleColor(.white, for: .normal)
        
        Timer.scheduledTimer(timeInterval: 0.4,
                             target: self,
                             selector: #selector(update),
                             userInfo: nil,
                             repeats: false)
    }
    
    @objc func update(){
        backgroundColor = .clear
        setTitleColor(.black, for: .normal)
    }
    
}

