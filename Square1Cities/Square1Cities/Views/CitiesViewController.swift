//
//  CitiesViewController.swift
//  Square1Cities
//
//  Created by Timothy Obeisun on 7/21/22.
//

import RealmSwift
import CoreLocation
import MapKit
import UIKit

class CitiesViewController: UIViewController {
    @IBOutlet weak var mapParentView: UIView!
    @IBOutlet weak var cityTableView: UITableView!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var noResultView: UIView!
    @IBOutlet weak var mapView: MKMapView!
    
    var cityArray: [CityRealm] = []
    let viewModel = CityViewModel(networkService: NetworkService.shared)
    var pageNumber: Int?
    var flagAtEnd: Bool = false
    var spinner = UIActivityIndicatorView(style: .large)
    var isSearched: Bool = false
    var globalSwitch: UISwitch = UISwitch()
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        setupView()
        setupGetAllCities()
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
        setupCityTableView()
        setupSpinner()
        setupMapParentView()
        setuptextField()
        setuplocationManager()
    }
    
    func setupGetAllCities() {
        viewModel.filterCity(text: AppString.emptyString.localisedValue,
                             page: 1,
                             isSearching: nil,
                             isBottom: nil)
    }
    
    /// switchTapped helps to detech switch tap on switchUI
    /// - Parameter sender: sender is of type UISwitch
    @IBAction func switchTapped(_ sender: UISwitch) {
        globalSwitch = sender
        if cityArray.count > 0 {
            if sender.isOn {
                showMapView()
            } else {
                debugPrint(cityArray)
                showListView()
            }
        } else {
            showNoResultLabel()
        }
    }
    
    func setuplocationManager() {
        locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
    }
    
    func createAnnontations(locations: [CityRealm]) {
        for location in locations {
            let annotation = MKPointAnnotation()
            annotation.title = location.name
            annotation.subtitle = location.countryName
            annotation.coordinate = CLLocationCoordinate2D(latitude: location.lat,
                                                           longitude: location.lng)
            
            mapView.addAnnotation(annotation)
        }
    }
    
    func setuptextField() {
        cityTextField.addTarget(self,
                                action: #selector(textFieldDidChange(_:)),
                                for: .editingChanged)
    }
    
    func setupCityTableView() {
        cityTableView.backgroundColor = .clear
        cityTableView.register(UINib(nibName: CityTableViewCell.reuseIdentifier,
                                     bundle: nil),
                               forCellReuseIdentifier: CityTableViewCell.reuseIdentifier)
        showListView()
    }
    
    func setupSpinner() {
        spinner.color = .systemGray
        spinner.hidesWhenStopped = true
        cityTableView.tableFooterView = spinner
    }
    
    func setupMapParentView() {
        mapParentView.backgroundColor = .clear
    }
    
    func showListView() {
        cityTableView.isHidden = false
        mapParentView.isHidden = true
        noResultView.isHidden = true
    }
    
    func showNoResultLabel() {
        cityTableView.isHidden = true
        mapParentView.isHidden = true
        noResultView.isHidden = false
    }
    
    func showMapView() {
        cityTableView.isHidden = true
        mapParentView.isHidden = false
        noResultView.isHidden = true
    }
    
    func setupAlert(errorMessage: String) {
        let alert = UIAlertController(title: AppString.error.localisedValue,
                                      message: errorMessage,
                                      preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: AppString.ok.localisedValue,
                                      style: UIAlertAction.Style.default,
                                      handler: nil))
        self.present(alert,
                     animated: true,
                     completion: nil)
    }
}

extension CitiesViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        return nil
    }
}

// MARK: - UITableViewDataSource

extension CitiesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return cityArray.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.reuseIdentifier,
                                                       for: indexPath) as? CityTableViewCell else {
            fatalError(AppString.dequeFailed.localisedValue)
        }
        cell.configure(with: cityArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    /// willDisplay
    /// - Parameters:
    ///   - tableView: City TableView
    ///   - cell: UITableViewCell
    ///   - indexPath: IndexPath
    func tableView(_ tableView: UITableView,
                   willDisplay cell: UITableViewCell,
                   forRowAt indexPath: IndexPath) {
        if (cityArray.count - 1 == indexPath.row) && cityArray.count > 7 {
            
            if !flagAtEnd {
                let text = cityTextField.text ?? AppString.emptyString.localisedValue
                let page = pageNumber ?? 1
                spinner.startAnimating()
                viewModel.filterCity(text: text.isEmpty ? AppString.emptyString.localisedValue : text,
                                     page: page + 1,
                                     isSearching: false,
                                     isBottom: true)
                isSearched = false
            }
        }
    }
    
    /// scrollToTop Function helps to scroll to the top of a cityTableView
    private func scrollToTop() {
        let targetRowIndexPath = IndexPath(row: 0, section: 0)
        if cityTableView.indexPathExists(indexPath: targetRowIndexPath) {
            cityTableView.scrollToRow(at: targetRowIndexPath,
                                      at: .bottom,
                                      animated: true)
        }
    }
}

extension CitiesViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.returnKeyType == .done {
            textField.resignFirstResponder()
        }
        return false
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        let text = textField.text ?? AppString.emptyString.localisedValue
        viewModel.filterCity(text: text,
                             page: 1,
                             isSearching: true,
                             isBottom: false)
        isSearched = true
    }
}

extension CitiesViewController: CitiesDelegate {
    /// getError Function Tracks Error from the api
    /// - Parameter error: Error is of type String.
    func getError(error: String) {
        self.flagAtEnd = true
        setupAlert(errorMessage: error)
    }
    
    /// This Function gets AllCities data
    /// - Parameters:
    ///   - item: item is the array of Realm Data and it is of type CityRealm
    ///   - pageNumber: tracks the current Page and it is of type Integer
    func getAllCities(item: [CityRealm], pageNumber: Int) {
        cityArray = item
        if item.count > 0 {
            self.mapView.removeAnnotations(self.mapView.annotations)
            if globalSwitch.isOn {
                showMapView()
            } else {
                showListView()
            }
            if isSearched {
                scrollToTop()
            }
            self.pageNumber = pageNumber
            self.flagAtEnd = false
            createAnnontations(locations: cityArray)
            spinner.stopAnimating()
            cityTableView.reloadData()
        } else {
            showNoResultLabel()
        }
    }
}
