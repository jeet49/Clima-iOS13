//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchField: UITextField!
    var weather = WeatherManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        searchField.delegate = self
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
        if let city = searchField.text {
            weather.fetchWeather(cityName: city)
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
    
}

