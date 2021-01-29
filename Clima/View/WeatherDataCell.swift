//
//  WeatherDataCell.swift
//  Clima
//
//  Created by Jeet Pujara on 1/18/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import UIKit

class WeatherDataCell: UICollectionViewCell {
    
    var weatherData: WeatherModel? {
        didSet {
            configureCells()
        }
    }
    
    // MARK:- Properties
    
    let feelsLikeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        let attributedText = NSMutableAttributedString(string: "Feels Like: ", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
        attributedText.append(NSAttributedString(string: "22°C", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.systemBlue]))
        label.attributedText = attributedText
        label.numberOfLines = 2
        return label
    }()
    
    let minimumTemperature: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        let attributedText = NSMutableAttributedString(string: "Min: ", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
        attributedText.append(NSAttributedString(string: "22°C", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.systemBlue]))
        label.attributedText = attributedText
        label.numberOfLines = 2
        return label
    }()
    
    let maximumTemperature: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        let attributedText = NSMutableAttributedString(string: "Max: ", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
        attributedText.append(NSAttributedString(string: "22°C", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.systemBlue]))
        label.attributedText = attributedText
        label.numberOfLines = 2
        return label
    }()
    
    let sunRise: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        let attributedText = NSMutableAttributedString(string: "SUNRISE\n", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
        attributedText.append(NSAttributedString(string: "6:00 AM", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.systemBlue]))
        label.attributedText = attributedText
        label.numberOfLines = 2
        return label
    }()
    
    let sunSet: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        let attributedText = NSMutableAttributedString(string: "SUNSET\n", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
        attributedText.append(NSAttributedString(string: "7:22 PM", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.systemBlue]))
        label.attributedText = attributedText
        label.numberOfLines = 2
        return label
    }()
    
    // MARK:- Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(feelsLikeLabel)
        feelsLikeLabel.anchor(top: topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        addSubview(minimumTemperature)
        minimumTemperature.anchor(top: feelsLikeLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        addSubview(maximumTemperature)
        maximumTemperature.anchor(top: minimumTemperature.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        addSubview(sunRise)
        sunRise.anchor(top: maximumTemperature.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        addSubview(sunSet)
        sunSet.anchor(top: sunRise.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- Handlers
    
    func configureCells() {
        self.configureAttributedText(label: feelsLikeLabel, attribute: "Feels Like", temperature: weatherData?.feelsLikeString ?? "21")
        self.configureAttributedText(label: minimumTemperature, attribute: "Min", temperature: weatherData?.temperatureMinString ?? "22")
        self.configureAttributedText(label: maximumTemperature, attribute: "Max", temperature: weatherData?.temperatureMaxString ?? "22")
        self.configureTime(label: sunRise, attribute: "SUNRISE", time: weatherData?.sunriseConverted ?? "6:00 AM")
        self.configureTime(label: sunSet, attribute: "SUNSET", time: weatherData?.sunsetConverted ?? "6:00 PM")
    }
    
    func configureAttributedText(label: UILabel, attribute: String, temperature: String) {
        let attributedText = NSMutableAttributedString(string: "\(attribute)\n", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13, weight: .semibold)])
        attributedText.append(NSAttributedString(string: "\(temperature)°C", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .bold)]))
        label.attributedText = attributedText
    }
    
    func configureTime(label: UILabel, attribute: String, time: String) {
        let attributedText = NSMutableAttributedString(string: "\(attribute)\n", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13, weight: .semibold)])
        attributedText.append(NSAttributedString(string: "\(time)", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .bold)]))
        label.attributedText = attributedText
    }
}
