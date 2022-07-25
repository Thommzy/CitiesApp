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
    func getAllCities(item: [CityRealm], pageNumber: Int)
    func getError(error: String)
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
    
    /// filterCity
    /// - Parameters:
    ///   - text: text is the string value passed to the endpoint
    ///   - page: is the currentPage data
    ///   - isSearching: checks if searching or not with a type of Boolean optional
    ///   - isBottom: checks if user is at the bottom or not with a type of Boolean optional
    func filterCity(text: String,
                    page: Int,
                    isSearching: Bool?,
                    isBottom: Bool?) {
        
        let dbData = Array(realm.objects(CityRealm.self))
        
        if isSearching == nil || isBottom == nil  {
            if dbData.count > 0 {
                retreiveData()
            } else {
                fetchCities(text: text,
                            page: page,
                            isSearching: isSearching,
                            isBottom: isBottom)
            }
        } else {
            fetchCities(text: text,
                        page: page,
                        isSearching: isSearching,
                        isBottom: isBottom)
        }
    }
    
    
    /// fetchCities Function triggers the API and also this  method is Reusable.
    /// - Parameters:
    ///   - text: text is the string value passed to the endpoint
    ///   - page: is the currentPage data
    ///   - isSearching: checks if searching or not with a type of Boolean optional
    ///   - isBottom: checks if user is at the bottom or not with a type of Boolean optional
    func fetchCities(text: String,
                     page: Int,
                     isSearching: Bool?,
                     isBottom: Bool?) {
        networkService?.searchCities(searchParmeter: text,
                                     page: page,
                                     completion: { [weak self] (result) in
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
                    cityRealm.countryName = items[i].country?.name ?? AppString.emptyString.localisedValue
                    cityRealm.lng = items[i].lng ?? 0.0
                    cityRealm.lat = items[i].lat ?? 0.0
                    cityRealm.code = items[i].country?.code ?? AppString.emptyString.localisedValue
                    cityRealm.currentPage = pagination.currentPage
                    cityRealm.lastPage = pagination.lastPage
                    citiesRealm.items.append(cityRealm)
                    i += 1
                }
                
                if isSearching == true {
                    self?.deleteDB()
                    try! self?.realm.write {
                        self?.realm.add(citiesRealm)
                    }
                } else {
                    try! self?.realm.write {
                        self?.realm.add(citiesRealm)
                    }
                }
                self?.retreiveData()
            case .failure(let error):
                self?.retreiveData()
                self?.delegate?.getError(error: error.localizedDescription)
            }
        })
    }
    
    /// deleteDB helps to clear data from the Realm Database
    func deleteDB() {
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    /// retreiveData helps to retrive data from the Realm Database
    func retreiveData(){
        let dbData = Array(realm.objects(CityRealm.self))
        let currentPage = dbData.count > 0 ? dbData[dbData.count - 1].currentPage : 1
        self.delegate?.getAllCities(item: dbData, pageNumber: currentPage)
    }
}
