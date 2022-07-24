//
//  CitiesViewController.swift
//  Square1Cities
//
//  Created by Timothy Obeisun on 7/21/22.
//

import RealmSwift
import UIKit

class CitiesViewController: UIViewController {
    @IBOutlet weak var mapParentView: UIView!
    @IBOutlet weak var cityTableView: UITableView!
    
    let viewModel = CityViewModel(networkService: NetworkService.shared)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        debugPrint(Realm.Configuration.defaultConfiguration.fileURL)
        setupView()
        setupCityTableView()
        setupMapParentView()
        setupGetAllCities()
    }
    
    func setupGetAllCities() {
        viewModel.fetchCities(page: 0)
        viewModel.delegate = self
    }
}

private extension CitiesViewController {
    func setupView() {
        view.backgroundColor = .systemBackground
        navigationItem.title = AppString.cityTitle.localisedValue
        let titleAttributes = [
            NSAttributedString.Key.font: UIFont(name: AppString.ChalkboardSEBold.localisedValue,
                                                size: 18)!
        ]
        self.navigationController?.navigationBar.titleTextAttributes = titleAttributes
    }
    
    func setupCityTableView() {
        cityTableView.backgroundColor = .red
        cityTableView.isHidden = false
        mapParentView.isHidden = true
    }
    
    func setupMapParentView() {
        mapParentView.backgroundColor = .green
    }
}

extension CitiesViewController: CitiesDelegate {
    func getAllCities(item: [CityRealm]) {
        debugPrint(item, "--->>>>>")
    }
}
