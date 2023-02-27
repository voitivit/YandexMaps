//
//  AddAddressView.swift
//  YandexMap
//
//  Created by emil kurbanov on 27.02.2023.
//

import UIKit
import Combine
class AddAddressView: UIView {
     

    // MARK: UIControl
    let textField = CustomTextFild()
    
   var locButtonTouch: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named:"locateUser"), for: .normal)
        button.tintColor = AppColor.TextIcons
        button.backgroundColor = .white
        return button
    }()
    
    let viewStick: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.layer.cornerRadius =  2
        return view
    }()
    
    let rightView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        view.backgroundColor = .clear
        return view
    }()
    
    let leftView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        view.backgroundColor = .clear
        return view
    }()
    let leftsView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var AddressStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [ domofon, entrance, floor, apartment])
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fillProportionally
        stack.spacing = 10
        return stack
    }()
    
    let domofon = CustomTextFild()
    let entrance = CustomTextFild()
    let floor = CustomTextFild()
    let apartment = CustomTextFild()
    
    private lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [cancelButton, addLocationButton])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 15
        return stack
    }()
 
    let addLocationButton = SaveButton()
    let cancelButton = CanselButton()
    
    //MARK: initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        addViewElements()
        setConstraints()
        setupTextFileds()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: setupView
    func setupView() {
        backgroundColor = .white
    }
    
    
    func setupTextFileds(){
        
         textField.placeholder = "Введите адрес"
         domofon.placeholder = "Домофон"
         entrance.placeholder = "Под."
         floor.placeholder = "Этаж"
         apartment.placeholder = "Квартира"
    }
    
    
    
    //MARK: Add Elements
    func addViewElements(){
        addSubview(textField)
        rightView.addSubview(viewStick)
        rightView.addSubview(locButtonTouch)
        textField.rightView = rightView
        textField.leftViewMode = .always
        textField.rightViewMode = .always
        textField.contentHorizontalAlignment = .center
        addSubview(stack)
        addSubview(AddressStack)
    }
    
    //MARK: Make Constraints
    func setConstraints() {
        
        textField.snp.makeConstraints {
            $0.top.equalToSuperview().offset(200)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(50)
            $0.width.equalTo(200)
        }
    
        viewStick.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview()
            $0.right.equalTo(locButtonTouch.snp.left).offset(-8)
            $0.width.equalTo(1)
            $0.height.equalTo(40)
        }
        locButtonTouch.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().offset(-10)
        }
        AddressStack.snp.makeConstraints {
            $0.top.equalTo(textField.snp.bottom).offset(20)
            $0.left.right.equalToSuperview().inset(16)
            
            domofon.snp.makeConstraints{
                $0.height.equalTo(40)
            }
            entrance.snp.makeConstraints{
                $0.height.equalTo(40)
            }
            floor.snp.makeConstraints{
                $0.height.equalTo(40)
            }
            apartment.snp.makeConstraints{
                $0.height.equalTo(40)
            }
        }
        stack.snp.makeConstraints{
            $0.top.equalTo(AddressStack.snp.bottom).offset(41)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalToSuperview().multipliedBy(0.05)
        }
    }
   
   
}
