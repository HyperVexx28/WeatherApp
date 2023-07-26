//
//  WeatherManager.swift
//  WeatherApp
//
//  Created by Mohamad Shehab on 26/07/2023.
//

import Foundation
import CoreLocation

class WeatherManager{
    func getCurrentWeather(latitude: CLLocationDegrees, longitude:CLLocationDegrees) async throws{
        guard let theUrl = URL(string: "http://api.openweathermap.org/geo/1.0/reverse?lat=\(latitude)&lon=\(longitude)&limit={limit}&appid=\("b698ee495c86db6dde230ae805eb021e")&units =metric") else {fatalError("Missing URL")}
        
        let urlRequest = URLRequest(url: theUrl)
       
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard(response as? HTTPURLResponse)?.statusCode == 200 else{
            fatalError("Error fetching weather data")
        }
    }
}

// Model of the response body we get from calling the OpenWeather API
struct ResponseBody: Decodable {
    var coord: CoordinatesResponse
    var weather: [WeatherResponse]
    var main: MainResponse
    var name: String
    var wind: WindResponse

    struct CoordinatesResponse: Decodable {
        var lon: Double
        var lat: Double
    }

    struct WeatherResponse: Decodable {
        var id: Double
        var main: String
        var description: String
        var icon: String
    }

    struct MainResponse: Decodable {
        var temp: Double
        var feels_like: Double
        var temp_min: Double
        var temp_max: Double
        var pressure: Double
        var humidity: Double
    }
    
    struct WindResponse: Decodable {
        var speed: Double
        var deg: Double
    }
}

extension ResponseBody.MainResponse {
    var feelsLike: Double { return feels_like }
    var tempMin: Double { return temp_min }
    var tempMax: Double { return temp_max }
}
