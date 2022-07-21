//
//  ViewController.swift
//  Square1Cities
//
//  Created by Timothy Obeisun on 7/21/22.
//

import Combine
import UIKit

class ViewController: UIViewController  {
    
    private var subscriptions = Set<AnyCancellable>()
    let viewModel = CityViewModel(networkService: NetworkService.shared)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGetAllCities()
    }
    
    func setupGetAllCities() {
        viewModel.fetchCities(page: 0)
          viewModel.delegate = self
      }
}


extension ViewController: CitiesDelegate {
    func getAllCities(item: [Item]?) {
        debugPrint(item, "----->>>>")
    }
}
