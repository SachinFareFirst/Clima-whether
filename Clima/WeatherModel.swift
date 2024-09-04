//
//  WeatherModel.swift
//  Clima
//
//  Created by Sachin H K on 23/07/24.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    
    //stored property
    let conditionId : Int
    let cityName : String
    let temperature : Double
    var description: String?
    //var minTemp: Double?
    init(conditionId: Int, cityName: String, temperature: Double,description: String) {
        self.conditionId = conditionId
        self.cityName = cityName
        self.temperature = temperature
        self.description = description
    }
  
  

    var temperatureString : String {
        String(format: "%.1f", temperature)
    }
    
    //computed property
    var conditionName : String {
        switch conditionId {
        case 200...232:
            return self.description ?? "cloud.bolt"
        case 300...331:
            return "cloud.drizzle"
        case 500...531:
            return  "cloud.rain"
        case 600...622:
            return  "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
          return "sun.max"
        case 801...804:
            return  "cloud.sun.fill"
        default:
          return "cloud"
        }
    }
}
