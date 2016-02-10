//
//  Weather.swift
//  Weather
//
//  Created by Sun Chung on 1/27/16.
//  Copyright © 2016 anseha. All rights reserved.
//

import Foundation
import Alamofire

class Weather {

    private var _humidity : String!
    private var _pressure : String!
    private var _temperature : String!
    private var _maxTemperature : String!
    private var _minTemperature : String!
    private var _sunrise : String!
    private var _sunset : String!
    private var _description : String!
    private var _icon : String!
    private var _id : String!
    private var _windDirection : String!
    private var _windSpeed : String!
    private var _dt : String!
    private var _city : String!
    var DEGREE = "&units=imperial"
    var degree = true
    
    // Cupertino - CA
    var latitude = 37.33233141
    var longitude = -122.0312186
    
    var humidity : String {
        if self._humidity == nil {
            _humidity = "--"
        }
        return _humidity
    }
    
    var pressure : String {
        if self._pressure == nil {
            _pressure = "--"
        }
        return _pressure
    }
    
    var temperature : String {
        if self._temperature == nil {
            _temperature = "--"
        }
        return _temperature
    }
    
    var maxTemperature : String {
        if self._maxTemperature == nil {
            _maxTemperature = "--"
        }
        return _maxTemperature
    }
    
    var minTemperature : String {
        if self._minTemperature == nil {
            _minTemperature = "--"
        }
        return _minTemperature
    }
    
    var city : String {
        if self._city == nil {
            _city = "--"
        }
        return _city
    }
    
    var sunrise : String {
        if self._sunrise == nil {
            _sunrise = "--"
        }
        return _sunrise
    }
    
    var sunset : String {
        if self._sunset == nil {
            _sunset = "--"
        }
        return _sunset
    }
    
    var description : String {
        if _description == nil {
            _description = "--"
        }
        return _description
    }
    
    var icon : String {
        if self._icon == nil {
            _icon = "--"
        }
        return _icon
    }
    
    var id : String {
        if self._id == nil {
            _id = "--"
        }
        return _id
    }
    
    var windDirection : String {
        if self._windDirection == nil {
            _windDirection = "--"
        }
        return _windDirection
    }
    
    var windSpeed : String {
        if self._windSpeed == nil {
            _windSpeed = "--"
        }
        return _windSpeed
    }
    
    var dt : String {
        if self._dt == nil {
            _dt = "--"
        }
        return _dt
    }
    
    func currentLocation(latitude : Double, longitude : Double) {
        
        self.latitude = latitude
        self.longitude = longitude
        
    }
    
    func celsiusToFahrenheit(degree : Bool) {
        
        self.degree = degree
        
        if degree == true {
        
            DEGREE = "&units=imperial"
        
        } else {
        
            DEGREE = "&units=metric"
        
        }
        
    }
    
    func downloadApiDetails(completed : DownLoadComplete) {
        
        let COORDINATE = "lat=\(latitude)&lon=\(longitude)"
        
        let urlGps = "\(URL_BASE_GPS)\(COORDINATE)\(DEGREE)\(API_KEY)"
        
        let nsUrl = NSURL(string: urlGps)!
        
        Alamofire.request(.GET, nsUrl).responseJSON { response in
            
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let city = dict["name"] as? String {
                    self._city = "\(city)"
                }
                if let dt = dict["dt"] as? Double {
                    self._dt = self.epochTimeToHumanTime(dt) as! String
                }
                if let temperature = dict["main"]!["temp"] as? Int {
                    self._temperature = "\(temperature)"
                }
                if let minTemperature = dict["main"]!["temp_min"] as? Int {
                    self._minTemperature = "\(minTemperature)"
                }
                if let maxTemperature = dict["main"]!["temp_max"] as? Int {
                    self._maxTemperature = "\(maxTemperature)"
                }
                if let pressure = dict["main"]!["pressure"] as? Int {
                    self._pressure = "\(pressure)"
                }
                if let humidity = dict["main"]!["humidity"] as? Int {
                    self._humidity = "\(humidity)"
                }
                if let weather = dict["weather"] as? [Dictionary<String, AnyObject>] where weather.count > 0 {
                    if let id = weather[0]["id"] as? Int {
                        self._id = "\(id)"
                    }
                    if let description = weather[0]["description"] as? String {
                        self._description = description.capitalizedString
                    }
                    if let icon = weather[0]["icon"] as? String {
                        self._icon = icon
                    }
                }
                if let wind = dict["wind"] as? Dictionary<String, AnyObject> {
                    if let windSpeed = wind["speed"] as? Int {
                        self._windSpeed = "\(windSpeed)"
                    }
                    if let windDirection = wind["deg"] as? Double {
                        self._windDirection = self.changeDegreeToCoordinates(windDirection)
                    }
                }
                if let sys = dict["sys"] as? Dictionary<String, AnyObject> {
                    if let sunrise = sys["sunrise"] as? Double {
                        self._sunrise = self.epochTimeToHumanTime(sunrise) as! String
                    }
                    if let sunset = sys["sunset"] as? Double {
                        self._sunset = self.epochTimeToHumanTime(sunset) as! String
                    }
                }
                
            } // END OF RESULT
        
            completed()
        
        } //END OF ALAMOFIRE REQUEST
        
    } //END OF FUNC
    
    func epochTimeToHumanTime(time : Double) -> AnyObject {
        
        if  let timeResult = (time as? Double) {
            let date = NSDate(timeIntervalSince1970: timeResult)
            let dateFormatter = NSDateFormatter()
            dateFormatter.timeStyle = NSDateFormatterStyle.MediumStyle
            dateFormatter.timeZone = NSTimeZone()
            let localDate = dateFormatter.stringFromDate(date)
            return localDate
        }
        
    }
    
    func changeDegreeToCoordinates(wind : Double) -> String {
        
        var direction = "--"
        
        if wind > 0 && wind < 45 {
            direction = "NNE"
        }
        if wind == 45 {
            direction = "NE"
        }
        if wind > 45 && wind < 90 {
            direction = "ENE"
        }
        if wind == 90 {
            direction = "E"
        }
        if wind > 90 && wind < 135 {
            direction = "ESE"
        }
        if wind == 135 {
            direction = "SE"
        }
        if wind > 135 && wind < 180 {
            direction = "SSE"
        }
        if wind == 180 {
            direction = "S"
        }
        if wind > 180 && wind < 225 {
            direction = "SSW"
        }
        if wind == 225 {
            direction = "SW"
        }
        if wind > 225 && wind < 270 {
            direction = "WSW"
        }
        if wind == 270 {
            direction = "W"
        }
        if wind > 270 && wind < 315 {
            direction = "WNW"
        }
        if wind == 315 {
            direction = "NW"
        }
        if wind > 315 && wind < 360 {
            direction = "NNW"
        }
        if wind == 360 {
            direction = "N"
        }
        return direction
    }

}