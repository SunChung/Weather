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
    private var _city : String!
    private var _sunrise : String!
    private var _sunset : String!
    private var _description : String!
    private var _icon : String!
    private var _id : String!
    private var _main : String!
    private var _windGust : String!
    private var _windSpeed : String!
    
    var humidity : String {
        if self._humidity == nil {
            _humidity = ""
        }
        return _humidity
    }
    
    var pressure : String {
        if self._pressure == nil {
            _pressure = ""
        }
        return _pressure
    }
    
    var temperature : String {
        if self._temperature == nil {
            _temperature = ""
        }
        return _temperature
    }
    
    var maxTemperature : String {
        if self._maxTemperature == nil {
            _maxTemperature = ""
        }
        return _maxTemperature
    }
    
    var minTemperature : String {
        if self._minTemperature == nil {
            _minTemperature = ""
        }
        return _minTemperature
    }
    
    var city : String {
        if self._city == nil {
            _city = ""
        }
        return _city
    }
    
    var sunrise : String {
        if self._sunrise == nil {
            _sunrise = ""
        }
        return _sunrise
    }
    
    var sunset : String {
        if self._sunset == nil {
            _sunset = ""
        }
        return _sunset
    }
    
    var description : String {
        if _description == nil {
            _description = ""
        }
        return _description
    }
    
    var icon : String {
        if self._icon == nil {
            _icon = ""
        }
        return _icon
    }
    
    var id : String {
        if self._id == nil {
            _id = ""
        }
        return _id
    }
    
    var main : String {
        if self._main == nil {
            _main = ""
        }
        return _main
    }
    
    var windGust : String {
        if self._windGust == nil {
            _windGust = ""
        }
        return _windGust
    }
    
    var windSpeed : String {
        if self._windSpeed == nil {
            _windSpeed = ""
        }
        return _windSpeed
    }
    
    func downloadApiDetails(completed : DownLoadComplete) {
        
        let NEWCITY = CITY.stringByReplacingOccurrencesOfString(" ", withString: "")
        
        let url = "\(URL_BASE)\(NEWCITY)\(IMPERIAL)\(API_KEY)"
        
        let nsUrl = NSURL(string: url)!
        Alamofire.request(.GET, nsUrl).responseJSON { response in
            
            let result = response.result
            print(result.value)
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let humidity = dict["main"]!["humidity"] as? Int {
                    self._humidity = "\(humidity)"
                }
                if let pressure = dict["main"]!["pressure"] as? Int {
                    self._pressure = "\(pressure)"
                }
                if let temperature = dict["main"]!["temp"] as? Int {
                    self._temperature = "\(temperature)"
                }
                if let maxTemperature = dict["main"]!["temp_max"] as? Int {
                    self._maxTemperature = "\(maxTemperature)"
                }
                if let minTemperature = dict["main"]!["temp_min"] as? Int {
                    self._minTemperature = "\(minTemperature)"
                }
                if let city = dict["name"] as? String {
                    self._city = city
                }
                if let sunrise = dict["sys"]!["sunrise"] as? Double {
                    self._sunrise = self.epochTimeToHumanTime(sunrise) as! String
                }
                if let sunset = dict["sys"]!["sunset"] as? Double {
                    self._sunset = self.epochTimeToHumanTime(sunset) as! String
                }
                if let weather = dict["weather"] as? [Dictionary<String, AnyObject>] where weather.count > 0 {
                    if let description = weather[0]["description"] as? String {
                        self._description = description.capitalizedString
                    }
                    if let icon = weather[0]["icon"] as? String {
                        self._icon = icon
                    }
                    if let id = weather[0]["id"] as? Double {
                        self._id = "\(id)"
                    }
                    if let main = weather[0]["main"] as? String {
                        self._main = main
                    }
                }
                if let windGust = dict["wind"]!["gust"] as? Double {
                    self._windGust = "\(windGust)"
                }
                if let windSpeed = dict["wind"]!["speed"] as? Double {
                    self._windSpeed = "\(windSpeed)"
                }
                completed() 
            }
          completed()
        }
        
    }
    
    func epochTimeToHumanTime(time : Double) -> AnyObject {
        
        if  let timeResult = (time as? Double) {
            let date = NSDate(timeIntervalSince1970: timeResult)
            let dateFormatter = NSDateFormatter()
            dateFormatter.timeStyle = NSDateFormatterStyle.MediumStyle
            //dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
            dateFormatter.timeZone = NSTimeZone()
            let localDate = dateFormatter.stringFromDate(date)
            return localDate
        }
        
    }
    
    func changeDegreeToCoordinates(wind : Double) -> String {
        
        var direction = "Wind Direction"
        
        if wind > 0 && wind < 90 {
            direction = "NE"
        }
        if wind == 90 {
            direction = "E"
        }
        if wind > 90 && wind < 180 {
            direction = "SE"
        }
        if wind == 180 {
            direction = "S"
        }
        if wind > 180 && wind < 270 {
            direction = "SW"
        }
        if wind == 270 {
            direction = "W"
        }
        if wind > 270 && wind < 360 {
            direction = "NW"
        }
        return direction
    }

}