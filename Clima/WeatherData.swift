//
//  WeatherData.swift
//  Clima
//
//  Created by Sachin H K on 23/07/24.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation

//codable = decodable & encodable
//nut below code takes codable protocol
struct WeatherData : Codable {
    let name : String
    let main : Main 
    let weather : [Weather]
   // let coord : Coord
}

struct Main : Codable {
    let temp : Double
    let tempMin : Double
}

struct Weather : Codable {
    let description : String
    let id : Int
   // let coord : Coord
}

//struct Coord : Codable{
//    let lon : Float
//}

