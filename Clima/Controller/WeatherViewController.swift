//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

private let reusableIdentifier = "collectionViewDataCell"

class WeatherViewController: UIViewController, UITextFieldDelegate, WeatherManagerDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource, CLLocationManagerDelegate {
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var blankView: UIView!
    @IBOutlet weak var backgroundImage: UIImageView!
    var collectionView: UICollectionView!
    var weather = WeatherManager()
    var weatherModel: WeatherModel?
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        configureCollectionView()
        weather.delegate = self
        searchField.delegate = self
    }
    @IBAction func updateWeatherForCurrentLocation(_ sender: Any) {
        locationManager.requestLocation()
    }
    
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        _ = handleSearch()
    }
    
    // MARK:- TextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let textFieldReturnValue = handleSearch() else {
            return false
        }
        return textFieldReturnValue
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchField.text?.trimmingCharacters(in: .whitespaces) {
            weather.fetchWeather(cityName: city.replacingOccurrences(of: " ", with: "+"))
        }
        searchField.text = ""
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            let placeHolderText = NSAttributedString(string: "Search", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray])
            textField.attributedPlaceholder = placeHolderText
            return true
        } else {
            let placeHolderText = NSAttributedString(string: "Please Type Something", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemRed])
            textField.attributedPlaceholder = placeHolderText
            return false
        }
    }
    
    func handleSearch() -> Bool? {
        searchField.resignFirstResponder()
        return true
    }
    
    
    // MARK:- Delegate
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let lat = location.coordinate.latitude
            let long = location.coordinate.longitude
            weather.fetchWeatherUsingLocation(latitude: lat, longitude: long)
            locationManager.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func didUpdateWeather(_ weatherManager: WeatherManager, _ weather: WeatherModel) {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            self.weatherModel = weather
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.temperatureLabel.text = weather.temperatureString
            self.cityLabel.text = weather.cityName
            self.conditionLabel.text = weather.description.capitalized
        }
    }
    
    func didFail(withError error: Error) {
        print(error.localizedDescription)
    }
    
    func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let frame = CGRect(x: blankView.frame.origin.x + 160, y: blankView.frame.origin.y + 50, width: 85, height: 250)
        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = .clear
        view.addSubview(collectionView)
        collectionView.anchor(top: conditionLabel.bottomAnchor, left: nil, bottom: nil, right: view.rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 85, height: 250)
        collectionView.register(WeatherDataCell.self, forCellWithReuseIdentifier: reusableIdentifier)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusableIdentifier, for: indexPath) as! WeatherDataCell
        cell.weatherData = weatherModel
        return cell
    }
}
