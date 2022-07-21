//
//  CitiesViewController.swift
//  Square1Cities
//
//  Created by Timothy Obeisun on 7/21/22.
//

import UIKit

class CitiesViewController: UIViewController {
    let viewModel = CityViewModel(networkService: NetworkService.shared)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        setupGetAllCities()
    }
    
    func setupGetAllCities() {
        viewModel.fetchCities(page: 0)
        viewModel.delegate = self
    }
}

extension CitiesViewController: CitiesDelegate {
    func getAllCities(item: [City]?) {
        debugPrint(item, "----->>>>")
    }
}
