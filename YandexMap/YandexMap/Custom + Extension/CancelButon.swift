//
//  CancelButon.swift
//  YandexMap
//
//  Created by emil kurbanov on 27.02.2023.
//

import UIKit

final class CanselButton: UIButton {
    
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
        title(for: .normal)
        setTitleColor(.black, for: .normal)
        backgroundColor = .white
        layer.borderColor = UIColor.orange.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 10
        setTitle("Отменить", for: .normal)
        addTarget(self, action: #selector(cancelButtonAccountLocationTapped), for: .touchUpInside)
        translatesAutoresizingMaskIntoConstraints = false
    }
    @objc func cancelButtonAccountLocationTapped() {
        
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
