//
//  CityViewModel.swift
//  Square1Cities
//
//  Created by Timothy Obeisun on 7/21/22.
//

import Foundation
import Combine
import RealmSwift

protocol CitiesDelegate {
    func getAllCities(item: [CityRealm])
    func getError(error: String)
}

extension CitiesDelegate {
    func getError(error: String){}
}

final class CityViewModel {
    var delegate : CitiesDelegate?
    private var networkService: NetworkService?
    let realm = try! Realm()
    var isDuplicate: Bool = false
    var data:Results<CityRealm>!
    var result:[CityRealm] = []
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func fetchCities(page: Int) {
        networkService?.fetchCities(page: page) { [weak self] (result) in
            switch result {
            case .success(let allCities):
                let items = allCities.items
                let pagination = allCities.pagination
                let citiesRealm = CitiesRealm()
                
                var i = 0
                while i < items.count {
                    let cityRealm = CityRealm()
                    cityRealm.id = items[i].id
                    cityRealm.name = items[i].name
                    cityRealm.countryID = items[i].countryID
                    cityRealm.countryName = items[i].country?.name ?? ""
                    cityRealm.lng = items[i].lng ?? 0.0
                    cityRealm.lat = items[i].lat ?? 0.0
                    cityRealm.code = items[i].country?.code ?? ""
                    cityRealm.currentPage = pagination.currentPage
                    cityRealm.lastPage = pagination.lastPage
                    citiesRealm.items.append(cityRealm)
                    i += 1
                }
                
                try! self?.realm.write {
                    self?.realm.add(citiesRealm)
                }
                self?.retreiveData()
            case .failure(let error):
                self?.delegate?.getError(error: error.localizedDescription)
            }
        }
    }
    
    func deleteDB() {
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    func retreiveData(){
        self.delegate?.getAllCities(item: Array(realm.objects(CityRealm.self)))
    }
}
