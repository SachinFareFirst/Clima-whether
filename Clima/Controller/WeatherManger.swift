//
//  WeatherManger.swift
//  Clima
//
//  Created by Sachin H K on 22/07/24.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager : WeatherManger, weather: WeatherModel)
    func didFailWithError(error: Error)
    
}

struct WeatherManger {
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=ccb89181a3394acd2820154836124f0b&units=metric"
    
    var delegate : WeatherManagerDelegate?
 
    
    func fetchWeather(cityName : String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        //print(urlString)
        self.performanceRequest(with: urlString)// here we added self keyword bcz we are not using any object for particular calss instead of  we are using self current class object
    }
    func fetchWeather1(latitude : CLLocationDegrees, longtitude : CLLocationDegrees) {
         let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longtitude)"
        self.performanceRequest(with: urlString)
    }
    
    
    func performanceRequest(with urlString : String) {
        //1.create url
        if let url = URL(string: urlString) {
            print("urllll",url)
          //2. cerate a url session
            //createing object to perform the desired operartion
//            let session = URLSession(configuration: URLSessionConfiguration.default)
            let session = URLSession.shared
            //3 give a session task
            //first complete datatask
            //then moves to the completion handler which is in closure
            let task = session.dataTask(with: url) { (data,response,error) in
                
               // print(String(data: data!, encoding: .utf8)!)
               // print("respose",respose?.url)
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    //print("eror",error!)
                    return
                }
                
                if let safeData = data {
                    //print("safeData",safeData)
                    //self.parseJSON(safeData)
                    //self is added if we are calling method from the current class
                    
                    //below code is optional bindig bcz WeatherModel maight be nul
                    //var tempString : String = //custom json string 
                    if let weather = self.parseJSON(safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                    
                }
            }
            //4.start the task-->doesnot wait for the respose when respose is recived calls the callback for the task
            task.resume()
        }
    }
    func parseJSON(_ weatherData : Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
                      //type weather dta
        do {
            //WeatherData.self, it refer to the type itself
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData) //weatherData contains the data
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            //let minTemp = decodedData.main.tempMin
            //print(minTemp)
            let name = decodedData.name
            
            var weather = WeatherModel(conditionId: id, cityName: name, temperature: temp, description: decodedData.weather[0].description)
            //weather.minTemp = minTemp
            //print(weather.minTemp as Any)
            print(weather.conditionName)
            print(weather.temperatureString)
            
            return weather //if this fails then it will goes to the empty or nil
            
        } catch {
           // print("kjgkjbhk",error)
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}





