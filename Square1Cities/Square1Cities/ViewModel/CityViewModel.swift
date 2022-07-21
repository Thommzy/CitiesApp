//
//  CityViewModel.swift
//  Square1Cities
//
//  Created by Timothy Obeisun on 7/21/22.
//

import Foundation
import Combine

protocol CitiesDelegate {
    func getAllCities(item: [Item]?)
}

final class CityViewModel {
    var delegate : CitiesDelegate?
    private var networkService: NetworkService?
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func fetchCities(page: Int) {
        networkService?.fetchCities(page: page) { [weak self] (result) in
            switch result {
            case .success(let allCities):
                guard let items = allCities.items else { return }
                self?.delegate?.getAllCities(item: items)
            case .failure(let error):
                print("The error is: \(error.localizedDescription)")
            }
        }
    }
}
