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
            
            self.degreeLabel.setTitle("F°", forState: UIControlState.Normal)
            weather.celsiusToFahrenheit(degreeTest)
            getWeather()
            degreeTest = false
            
        } else {
            
            self.degreeLabel.setTitle("C°", forState: UIControlState.Normal)
            weather.celsiusToFahrenheit(degreeTest)
            getWeather()
            degreeTest = true
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialRun()
    
    }
    
    override func viewWillAppear(animated: Bool) {
        
        userCurrentLocation()
        
    }
    
    func initialRun() {
        
        self.cityLabel.text = "Getting Weather!"
        self.descriptionLabel.text = "Please Wait...."
        iconImage.image = UIImage(named: "wifi")
        self.temperatureLabel.text = "--"
        self.degreeLabel.setTitle("?", forState: UIControlState.Normal)
        
    }
    
    func userCurrentLocation() {
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let locValue:CLLocationCoordinate2D = locationManager.location!.coordinate
        
        if locationManager != "" {

            weather.currentLocation(locValue.latitude, longitude: locValue.longitude)
        
            getWeather()
        
            self.locationManager.stopUpdatingLocation()
        
        } else {
            
            userCurrentLocation()
            
        }

    }
    
    func getWeather() {
        
        weather.downloadApiDetails { () -> () in
            
            self.configureUI()
            
            if self.weather.temperature != "" {
                
                self.backgroundColorChange()
            
            }else {
            
                self.view.backgroundColor = UIColor(red: 229.0/255.0, green: 229.0/255.0, blue: 229.0/255.0, alpha: 1.0)
                
                self.initialRun()
                
            }
            
        }
        
    }
    
    func configureUI() {
    
        cityLabel.text = weather.city
        descriptionLabel.text = weather.description
        iconImage.image = UIImage(named: weather.icon)
        temperatureLabel.text = weather.temperature
        degreeLabel.setTitle("F°", forState: UIControlState.Normal)
        minTemperatureLabel.text = weather.minTemperature
        maxTemperatureLabel.text = weather.maxTemperature
        humidityLabel.text = weather.humidity
        pressureLabel.text = weather.pressure
        sunriseLabel.text = weather.sunrise
        sunsetLabel.text = weather.sunset
        windSpeedLabel.text = weather.windSpeed
        windDirectionLabel.text = weather.windDirection
    
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
        }else if (temperatureTest) >= 10 && (temperatureTest) <= 19 {
            self.view.backgroundColor = UIColor(red: 216/255, green: 67/255, blue: 21/255, alpha: 1.0)
            textColor = UIColor.whiteColor()
        }else if (temperatureTest) >= 20 && (temperatureTest) <= 29 {
            self.view.backgroundColor = UIColor(red: 230/255, green: 74/255, blue: 25/255, alpha: 1.0)
            textColor = UIColor.whiteColor()
        }else if (temperatureTest) >= 30 && (temperatureTest) <= 39 {
            self.view.backgroundColor = UIColor(red: 244/255, green: 81/255, blue: 30/255, alpha: 1.0)
            textColor = UIColor.whiteColor()
        }else if (temperatureTest) >= 40 && (temperatureTest) <= 49 {
            self.view.backgroundColor = UIColor(red: 255/255, green: 138/255, blue: 101/255, alpha: 1.0)
            textColor = UIColor.darkGrayColor()
        }else if (temperatureTest) >= 50 && (temperatureTest) <= 59 {
            self.view.backgroundColor = UIColor(red: 220/255, green: 231/255, blue: 117/255, alpha: 1.0)
            textColor = UIColor.darkGrayColor()
        }else if (temperatureTest) >= 60 && (temperatureTest) <= 69 {
            self.view.backgroundColor = UIColor(red: 165/255, green: 214/255, blue: 167/255, alpha: 1.0)
            textColor = UIColor.darkGrayColor()
        }else if (temperatureTest) >= 70 && (temperatureTest) <= 79 {
            self.view.backgroundColor = UIColor(red: 179/255, green: 245/255, blue: 252/255, alpha: 1.0)
            textColor = UIColor.darkGrayColor()
        }else if (temperatureTest) >= 80 && (temperatureTest) <= 89 {
            self.view.backgroundColor = UIColor(red: 33/255, green: 150/255, blue: 243/255, alpha: 1.0)
            textColor = UIColor.whiteColor()
        }else if (temperatureTest) >= 90 && (temperatureTest) <= 99 {
            self.view.backgroundColor = UIColor(red: 63/255, green: 81/255, blue: 181/255, alpha: 1.0)
            textColor = UIColor.whiteColor()
        }else if (temperatureTest) >= 100 && (temperatureTest) <= 109 {
            self.view.backgroundColor = UIColor(red: 57/255, green: 73/255, blue: 171/255, alpha: 1.0)
            textColor = UIColor.whiteColor()
        }else if (temperatureTest) >= 110 {
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

