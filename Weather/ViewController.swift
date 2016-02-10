//
//  ViewController.swift
//  Weather
//
//  Created by Sun Chung on 1/27/16.
//  Copyright © 2016 anseha. All rights reserved.
//

import UIKit
import Alamofire
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {

    var weather = Weather()
    var locationManager : CLLocationManager!
    var degreeTest = false
    var temperatureTest = Int()
    var textColor : UIColor!
    
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
    
    @IBOutlet var degreeLabel: UIButton!

    @IBAction func degreeButton(sender: AnyObject) {
        
        if degreeTest == true {
            
            self.degreeLabel.setTitle("F", forState: UIControlState.Normal)
            weather.celsiusToFahrenheit(degreeTest)
            getWeather()
            degreeTest = false
            
        } else {
            
            self.degreeLabel.setTitle("C", forState: UIControlState.Normal)
            weather.celsiusToFahrenheit(degreeTest)
            getWeather()
            degreeTest = true
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let locValue:CLLocationCoordinate2D = locationManager.location!.coordinate
        
        weather.currentLocation(locValue.latitude, longitude: locValue.longitude)
        
        getWeather()
        
        self.locationManager.stopUpdatingLocation()

    }
    
    func getWeather() {
        
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
        windDirectionLabel.text = weather.windDirection
        
        backgroundColorChange()
    
    }
    
    func backgroundColorChange() {
        
        if degreeTest == true {
            temperatureTest = ((Int(weather.temperature)! * 9) / 5) + 32
        } else {
            temperatureTest = Int(weather.temperature)!
        }
        
        if (temperatureTest) < 10 {
            self.view.backgroundColor = UIColor(red: 191/255, green: 54/255, blue: 12/255, alpha: 1.0)
            textColor = UIColor.whiteColor()
        }
        if (temperatureTest) >= 10 && (temperatureTest) <= 19 {
            self.view.backgroundColor = UIColor(red: 216/255, green: 67/255, blue: 21/255, alpha: 1.0)
            textColor = UIColor.whiteColor()
        }
        if (temperatureTest) >= 20 && (temperatureTest) <= 29 {
            self.view.backgroundColor = UIColor(red: 230/255, green: 74/255, blue: 25/255, alpha: 1.0)
            textColor = UIColor.whiteColor()
        }
        if (temperatureTest) >= 30 && (temperatureTest) <= 39 {
            self.view.backgroundColor = UIColor(red: 244/255, green: 81/255, blue: 30/255, alpha: 1.0)
            textColor = UIColor.whiteColor()
        }
        if (temperatureTest) >= 40 && (temperatureTest) <= 42 {
            self.view.backgroundColor = UIColor(red: 255/255, green: 138/255, blue: 101/255, alpha: 1.0)
            textColor = UIColor.darkGrayColor()
        }
        if (temperatureTest) >= 43 && (temperatureTest) <= 45 {
            self.view.backgroundColor = UIColor(red: 255/255, green: 183/255, blue: 77/255, alpha: 1.0)
            textColor = UIColor.darkGrayColor()
        }
        if (temperatureTest) >= 46 && (temperatureTest) <= 49 {
            self.view.backgroundColor = UIColor(red: 255/255, green: 204/255, blue: 128/255, alpha: 1.0)
            textColor = UIColor.darkGrayColor()
        }
        if (temperatureTest) >= 50 && (temperatureTest) <= 51 {
            self.view.backgroundColor = UIColor(red: 220/255, green: 231/255, blue: 117/255, alpha: 1.0)
            textColor = UIColor.darkGrayColor()
        }
        if (temperatureTest) >= 52 && (temperatureTest) <= 53 {
            self.view.backgroundColor = UIColor(red: 230/255, green: 238/255, blue: 156/255, alpha: 1.0)
            textColor = UIColor.darkGrayColor()
        }
        if (temperatureTest) >= 54 && (temperatureTest) <= 55 {
            self.view.backgroundColor = UIColor(red: 197/255, green: 225/255, blue: 165/255, alpha: 1.0)
            textColor = UIColor.darkGrayColor()
        }
        if (temperatureTest) >= 56 && (temperatureTest) <= 57 {
            self.view.backgroundColor = UIColor(red: 174/255, green: 213/255, blue: 129/255, alpha: 1.0)
            textColor = UIColor.darkGrayColor()
        }
        if (temperatureTest) >= 58 && (temperatureTest) <= 59 {
            self.view.backgroundColor = UIColor(red: 129/255, green: 199/255, blue: 132/255, alpha: 1.0)
            textColor = UIColor.darkGrayColor()
        }
        if (temperatureTest) >= 60 && (temperatureTest) <= 61 {
            self.view.backgroundColor = UIColor(red: 165/255, green: 214/255, blue: 167/255, alpha: 1.0)
            textColor = UIColor.darkGrayColor()
        }
        if (temperatureTest) >= 62 && (temperatureTest) <= 63 {
            self.view.backgroundColor = UIColor(red: 178/255, green: 223/255, blue: 219/255, alpha: 1.0)
            textColor = UIColor.darkGrayColor()
        }
        if (temperatureTest) >= 64 && (temperatureTest) <= 65 {
            self.view.backgroundColor = UIColor(red: 128/255, green: 203/255, blue: 196/255, alpha: 1.0)
            textColor = UIColor.darkGrayColor()
        }
        if (temperatureTest) >= 66 && (temperatureTest) <= 67 {
            self.view.backgroundColor = UIColor(red: 128/255, green: 222/255, blue: 234/255, alpha: 1.0)
            textColor = UIColor.darkGrayColor()
        }
        if (temperatureTest) >= 68 && (temperatureTest) <= 69 {
            self.view.backgroundColor = UIColor(red: 178/255, green: 235/255, blue: 242/255, alpha: 1.0)
            textColor = UIColor.darkGrayColor()
        }
        if (temperatureTest) >= 70 && (temperatureTest) <= 71 {
            self.view.backgroundColor = UIColor(red: 179/255, green: 245/255, blue: 252/255, alpha: 1.0)
            textColor = UIColor.darkGrayColor()
        }
        if (temperatureTest) >= 72 && (temperatureTest) <= 73 {
            self.view.backgroundColor = UIColor(red: 129/255, green: 212/255, blue: 250/255, alpha: 1.0)
            textColor = UIColor.darkGrayColor()
        }
        if (temperatureTest) >= 74 && (temperatureTest) <= 75 {
            self.view.backgroundColor = UIColor(red: 79/255, green: 195/255, blue: 247/255, alpha: 1.0)
            textColor = UIColor.darkGrayColor()
        }
        if (temperatureTest) >= 76 && (temperatureTest) <= 77 {
            self.view.backgroundColor = UIColor(red: 41/255, green: 182/255, blue: 246/255, alpha: 1.0)
            textColor = UIColor.darkGrayColor()
        }
        
        if (temperatureTest) >= 78 && (temperatureTest) <= 79 {
            self.view.backgroundColor = UIColor(red: 3/255, green: 169/255, blue: 244/255, alpha: 1.0)
            textColor = UIColor.darkGrayColor()
        }
        if (temperatureTest) >= 80 && (temperatureTest) <= 89 {
            self.view.backgroundColor = UIColor(red: 33/255, green: 150/255, blue: 243/255, alpha: 1.0)
            textColor = UIColor.whiteColor()
        }
        if (temperatureTest) >= 90 && (temperatureTest) <= 99 {
            self.view.backgroundColor = UIColor(red: 63/255, green: 81/255, blue: 181/255, alpha: 1.0)
            textColor = UIColor.whiteColor()
        }
        if (temperatureTest) >= 100 && (temperatureTest) <= 109 {
            self.view.backgroundColor = UIColor(red: 57/255, green: 73/255, blue: 171/255, alpha: 1.0)
            textColor = UIColor.whiteColor()
        }
        if (temperatureTest) >= 110 {
            self.view.backgroundColor = UIColor(red: 48/255, green: 63/255, blue: 159/255, alpha: 1.0)
            textColor = UIColor.whiteColor()
        }
        
        textColorSetting()
        
    }
    
    func textColorSetting() {
        
        cityLabel.textColor = textColor
        descriptionLabel.textColor = textColor
        temperatureLabel.textColor = textColor
        minTemperatureLabel.textColor = textColor
        maxTemperatureLabel.textColor = textColor
        humidityLabel.textColor = textColor
        pressureLabel.textColor = textColor
        sunriseLabel.textColor = textColor
        sunsetLabel.textColor = textColor
        windSpeedLabel.textColor = textColor
        windDirectionLabel.textColor = textColor
        self.degreeLabel.setTitleColor(textColor, forState: UIControlState.Normal)
        
    }
    
}

