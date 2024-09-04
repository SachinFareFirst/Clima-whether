 

import UIKit
import CoreLocation

class WeatherViewController1: UIViewController{

    //here UITextFieldDelegate protocol already contain default function by extension
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    var weatherManger = WeatherManger()
    
    let locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("weather",type(of: weatherManger))
       
        searchTextField.delegate = self
        weatherManger.delegate = self
        
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation() //requestLocation -> this will trigger the didupdateLocation
       
    }
    
    @IBAction func currentLocation(_ sender: UIButton) {
        locationManager.requestLocation()
    }
}

//this represents the section
//MARK: -UITextFieldDelegate

extension WeatherViewController1 : UITextFieldDelegate {
    @IBAction func searchPressed(_ sender: UIButton) {
        //after pressing keyboard discard
        searchTextField.endEditing(true)
       //print(searchTextField.text!)
        
    }
    //"go" button in the keyboard which will return the text field value
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("delegats")
        searchTextField.endEditing(true)
        //print(searchTextField.text!)
        return true
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            print("palceholder")
            return true
        } else {
            textField.placeholder = "Enter The City Name"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("cityName")
        if let city = searchTextField.text{
            weatherManger.fetchWeather(cityName: city)
        }
        
        searchTextField.text = ""
    }
    
    
}

//MARK: -WeatherManagerDelegate

extension WeatherViewController1 : WeatherManagerDelegate{
    func didUpdateWeather(_ weatherManager : WeatherManger, weather: WeatherModel) {
        
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.cityLabel.text = weather.cityName
        }
        print(weather.temperature)
    }
    func didFailWithError(error: any Error) {
        print(error)
    }
}

//MARK: - CLLocationManagerDeleagte

extension WeatherViewController1 : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Got Location Data")
        
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManger.fetchWeather1(latitude : lat,longtitude: lon)
            print(lat,lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(error)
    }
}











