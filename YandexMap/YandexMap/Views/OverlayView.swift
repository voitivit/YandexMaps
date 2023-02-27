//
//  OverlayView.swift
//  YandexMap
//
//  Created by emil kurbanov on 27.02.2023.
//


import UIKit
import YandexMapsMobile
class OverlayView: UIViewController {
    
   let slideIdicator: UIView = {
       let slide = UIView()
       slide.backgroundColor = .green
       slide.layer.cornerRadius = 10
       slide.translatesAutoresizingMaskIntoConstraints = false
       return slide
   }()
   
   let someView: UIView = {
       let slide = UIView()
       slide.backgroundColor = .white
       slide.layer.cornerRadius = 2
       slide.translatesAutoresizingMaskIntoConstraints = false
       return slide
   }()
   
   let searchBar: UISearchBar = {
       let search = UISearchBar()
       search.translatesAutoresizingMaskIntoConstraints = false
       return search
   }()
   
   let tableView: UITableView = {
       let table = UITableView()
       table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
       table.translatesAutoresizingMaskIntoConstraints = false
       return table
   }()
    var delegate: SearchDelegate?
    // Анимация
    var hasSetPointOrigin = false
    var pointOrigin: CGPoint?
    // Mapkit свойства
    var suggestResults: [YMKSuggestItem] = []
    let searchManager = YMKSearch.sharedInstance().createSearchManager(with: .combined)
    var suggestSession: YMKSearchSuggestSession!
    
    let BOUNDING_BOX = YMKBoundingBox(
        southWest: YMKPoint(latitude: 55.55, longitude: 37.42),
        northEast: YMKPoint(latitude: 55.95, longitude: 37.82))
    let SUGGEST_OPTIONS = YMKSuggestOptions()

    //MARK: ВьюДиды
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(someView)
        someView.addSubview(slideIdicator)
        view.addSubview(searchBar)
        view.addSubview(tableView)
        
        setConstraints()
        // Animation
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction))
        view.addGestureRecognizer(panGesture)
        // Mapkit
        suggestSession = searchManager.createSuggestSession()
        searchBar.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    override func viewDidLayoutSubviews() {
        // Animation
        if !hasSetPointOrigin {
            hasSetPointOrigin = true
            pointOrigin = self.view.frame.origin
        }
    }
    // MARK: - Animation
    @objc func panGestureRecognizerAction(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
      //вью не уходит вверх search
         guard translation.y >= 0 else { return }
        // Если поставим х больше 0 , будет слетать вью
        view.frame.origin = CGPoint(x: 0, y: self.pointOrigin!.y + translation.y)
        
        if sender.state == .ended {
            let dragVelocity = sender.velocity(in: view)
            if dragVelocity.y >= 1300 {
                self.dismiss(animated: true, completion: nil)
            } else {
                // Быстро убираем контрллер, чем меньше значение от 1, тем медленне будет уходить search
                    UIView.animate(withDuration: 1) {
                    self.view.frame.origin = self.pointOrigin ?? CGPoint(x: 0, y: 100)
                }
            }
        }
    }
    //MARK: setConstraints OverlayView
   
    func setConstraints() {
        
        someView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.right.equalToSuperview()
            $0.height.equalTo(20)
        }
        
        slideIdicator.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.height.equalTo(4)
            $0.width.equalToSuperview().multipliedBy(0.3)
        }
 
        
      searchBar.snp.makeConstraints {
          $0.top.equalTo(someView.snp.bottom)
          $0.left.right.equalToSuperview()
          $0.height.equalTo(56)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom)
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview().inset(32)
            $0.height.equalTo(582)
            //$0.width.equalTo(350)
        }
    }
    
}
// MARK: - Mapkit
extension OverlayView {
    func onSuggestResponse(_ items: [YMKSuggestItem]) {
        suggestResults = items
        tableView.reloadData()
    }
    func onSuggestError(_ error: Error) {
        let suggestError = (error as NSError).userInfo[YRTUnderlyingErrorKey] as! YRTError
        var errorMessage = "Unknown error"
        if suggestError.isKind(of: YRTNetworkError.self) {
            errorMessage = "Network error"
        } else if suggestError.isKind(of: YRTRemoteError.self) {
            errorMessage = "Remote server error"
        }
        
        let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
}
// MARK: - UITableViewDelegate/DataSource
extension OverlayView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.searchAndMoveMap(with: suggestResults[indexPath.row].title.text, info: suggestResults[indexPath.row].displayText!)
        dismiss(animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = suggestResults[indexPath.row].displayText
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return suggestResults.count
    }
}
// MARK: - UISearchBarDelegate
extension OverlayView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let suggestHandler = {(response: [YMKSuggestItem]?, error: Error?) -> Void in
            if let items = response {
                self.onSuggestResponse(items)
            } else {
                self.onSuggestError(error!)
            }
        }
        suggestSession.suggest(
            withText: searchBar.text!,
            window: BOUNDING_BOX,
            suggestOptions: SUGGEST_OPTIONS,
            responseHandler: suggestHandler)
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        if suggestResults.isEmpty {
            dismiss(animated: true, completion: nil)
        }
    }
}
