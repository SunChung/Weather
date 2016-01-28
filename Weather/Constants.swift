//
//  Constants.swift
//  Weather
//
//  Created by Sun Chung on 1/27/16.
//  Copyright © 2016 anseha. All rights reserved.
//

import Foundation

let URL_BASE = "http://api.openweathermap.org/data/2.5/weather?q="
let CITY = "miramar"
let API_KEY = "&appid=3a5198449205135ddb3e265bea29fb70"
let IMPERIAL = "&units=imperial"
let METRIC = "&units=metric"

// SIMPLE CLOSURE
typealias DownLoadComplete = () -> ()