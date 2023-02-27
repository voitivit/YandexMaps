//
//  AddLocationController.swift
//  YandexMap
//
//  Created by emil kurbanov on 27.02.2023.
//

import UIKit
import Combine
class AddLocationController: UIViewController {
    var canceballe = Set<AnyCancellable>()
    var addButtonTapped: Bool = false
    var cancelButtonTapped: Bool = false
    var cancelButtonTouch: (() -> Void)?
    var finishFlow: (()->Void)?
    var finishFlowBack: (()->Void)?
    private lazy var addAddressView = view as? AddAddressView
    let slideIdicator: UIView = {
        let slide = UIView()
        slide.backgroundColor = .gray
        slide.layer.cornerRadius = 10
        return slide
    }()
    
    
    private let addAddressLabel = CustomLabel(title: "Добавить адрес :",
                             alignment: .center,
                             fontSize: AppFont.openSansFont(ofSize: 15, weight: .bold))
  
    
    let infoLabel = CustomTextFild()
    
    private lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [cancelButton, addLocationButton])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 15
        return stack
    }()
        
    
    let addLocationButton = SaveButton()
    let cancelButton = CanselButton()
    // MARK: - Properties
    // Для хранения адресов, сделать массивом если захотим передать в личный кабинет пользовтаеля
    var infoTitle: String?
    // Animation Properties
    var hasSetPointOrigin = false
    var pointOrigin: CGPoint?
    override func viewDidLoad() {
        super.viewDidLoad()
       // cancelButton.tapPublisher.sink(receiveValue: { [weak self] _ in
          //  self?.cancelButtonTouch?()
       // }).store(in: &canceballe)
        view.backgroundColor = .white
        view.addSubview(slideIdicator)
        view.addSubview(infoLabel)
        
        view.addSubview(addAddressLabel)
        view.addSubview(stack)
        setConstraints()
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction))
        view.addGestureRecognizer(panGesture)
        if let locations = UserDefaults.standard.array(forKey: "locations") as? [String] {
            for location in locations {
                if infoTitle! == location {
                    addLocationButton.setTitle("Already added", for: .normal)
                    addLocationButton.isUserInteractionEnabled = false
                }
            }
        }
        infoLabel.text = infoTitle
    }
    init(infoTitle: String) {
        super.init(nibName: nil, bundle: nil)
        self.infoTitle = infoTitle
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLayoutSubviews() {
        if !hasSetPointOrigin {
            hasSetPointOrigin = true
            pointOrigin = self.view.frame.origin
            updateButton()
        }
    }
    //MARK: send the address to the server
  /*  @objc func actionButtonLocationTapped() {
        print("Адрес доставки: \(String(describing: infoLabel.text))")
        addButtonTapped.toggle()
        if addButtonTapped {
            addLocationButton.backgroundColor = .orange
            addLocationButton.setTitleColor(.white, for: .normal)
        } else {
            addLocationButton.backgroundColor = .white
            addLocationButton.setTitleColor(.black, for: .normal)
        }
    }
    
    //MARK: NEW action for cancelButton
    @objc func cancelButtonLocationTapped() {
        
        cancelButtonTapped.toggle()
        
        if cancelButtonTapped {
            cancelButton.backgroundColor = .orange
            cancelButton.setTitleColor(.white, for: .normal)
        } else {
            cancelButton.backgroundColor = .white
            cancelButton.setTitleColor(.black, for: .normal)
        }
    }*/

    //MARK: setConstraints AddLocationVC
    
    func setConstraints() {
        slideIdicator.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(5)
            $0.width.equalToSuperview().multipliedBy(0.15)
        }
        
        addAddressLabel.snp.makeConstraints{
            $0.top.equalTo(slideIdicator.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
        
        infoLabel.snp.makeConstraints {
            $0.top.equalTo(addAddressLabel.snp.bottom).offset(25)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(40)
            $0.left.right.equalToSuperview().inset(16)
        }
        
        stack.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(infoLabel.snp.bottom).offset(20)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalToSuperview().multipliedBy(0.16)
        }
        
    }

    
}
extension AddLocationController {
    @objc func panGestureRecognizerAction(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        // Чтобы юзер не перетаскивал вид вверх
        guard translation.y >= 0 else { return }
        
        
        view.frame.origin = CGPoint(x: 0, y: self.pointOrigin!.y + translation.y)
        
        if sender.state == .ended {
            let dragVelocity = sender.velocity(in: view)
            if dragVelocity.y >= 1300 {
                self.dismiss(animated: true, completion: nil)
            } else {
                // Контроллер просмотра в исходное положение
                UIView.animate(withDuration: 0.3) {
                    self.view.frame.origin = self.pointOrigin ?? CGPoint(x: 0, y: 400)
                }
            }
        }
    }
}


extension AddLocationController {
    
    func updateButton() {
         addLocationButton.addTarget(self, action: #selector(tap), for: .touchUpInside)
         cancelButton.addTarget(self, action: #selector(tapToCancel), for: .touchUpInside)
     }
    @objc func tap() {
        print("Адрес доставки: \(String(describing: infoLabel.text))")
        
        if let finishFlow = finishFlow {
            finishFlow()
        }
        self.dismiss(animated: true)
    }
    
    @objc func tapToCancel() {
        if let finishFlowBack = finishFlowBack {
            finishFlowBack()
        }
        self.dismiss(animated: true)
    }
}

