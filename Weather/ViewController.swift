//
//  ViewController.swift
//  Weather
//
//  Created by Sun Chung on 1/27/16.
//  Copyright © 2016 anseha. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    var weather = Weather()
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var minTemperatureLabel: UILabel!
    @IBOutlet weak var maxTemperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel : UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var windDirectionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weather.downloadApiDetails { () -> () in
            
            self.configureUI()
        }
    
    }
    
    func configureUI() {
    
        cityLabel.text = weather.city
        descriptionLabel.text = weather.description
        iconImage.image = UIImage(named: weather.icon)
        temperatureLabel.text = weather.temperature
        minTemperatureLabel.text = weather.minTemperature
        maxTemperatureLabel.text = weather.maxTemperature
        humidityLabel.text = weather.humidity
        pressureLabel.text = weather.pressure
        sunriseLabel.text = weather.sunrise
        sunsetLabel.text = weather.sunset
        windSpeedLabel.text = weather.windSpeed
        windDirectionLabel.text = weather.windGust
    
    }

}

