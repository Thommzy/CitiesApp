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
    
    var cityArray: [CityRealm] = []
    let viewModel = CityViewModel(networkService: NetworkService.shared)
    var pageNumber: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        // debugPrint(Realm.Configuration.defaultConfiguration.fileURL)
        setupView()
        setupCityTableView()
        setupMapParentView()
        setupGetAllCities()
    }
    
    @IBAction func switchTapped(_ sender: UISwitch) {
        if sender.isOn {
            showMapView()
        } else {
            hideMapView()
        }
    }
    
    func setupGetAllCities() {
        viewModel.fetchCities(page: 1)
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
        cityTableView.backgroundColor = .clear
        cityTableView.register(UINib(nibName: CityTableViewCell.reuseIdentifier,
                                     bundle: nil),
                               forCellReuseIdentifier: CityTableViewCell.reuseIdentifier)
        hideMapView()
    }
    
    func setupMapParentView() {
        mapParentView.backgroundColor = .green
    }
    
    func hideMapView() {
        cityTableView.isHidden = false
        mapParentView.isHidden = true
    }
    
    func showMapView() {
        cityTableView.isHidden = true
        mapParentView.isHidden = false
    }
    
    func setupAlert(erroMessage: String) {
        let alert = UIAlertController(title: "Error",
                                      message: erroMessage,
                                      preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK",
                                      style: UIAlertAction.Style.default,
                                      handler: nil))
        self.present(alert,
                     animated: true,
                     completion: nil)
    }
}

// MARK: - UITableViewDataSource

extension CitiesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return cityArray.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.reuseIdentifier,
                                                       for: indexPath) as? CityTableViewCell else {
            fatalError("Failed to deque a cell")
        }
        cell.configure(with: cityArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}

extension CitiesViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let text = textField.text ?? ""
        if textField.returnKeyType == .search {
            debugPrint("Search....")
            textField.resignFirstResponder()
            viewModel.filterCity(text: text,
                                 page: 1,
                                 isSearch: true)
        }
        return false
    }
}

extension CitiesViewController: CitiesDelegate {
    func getError(error: String) {
        setupAlert(erroMessage: error)
    }
    
    func getAllCities(item: [CityRealm], pageNumber: Int) {
        cityArray = item
        self.pageNumber = pageNumber
        cityTableView.reloadData()
        debugPrint(item, "--->>>>>")
        debugPrint(item.count, "--->>>>>")
    }
}
