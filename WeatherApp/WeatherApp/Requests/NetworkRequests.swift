//
//  NetworkRequests.swift
//  WeatherApp
//
//  Created by Pattison, Brian (Cognizant) on 5/15/23.
//

import Foundation
import Alamofire

class NetworkRequests {
    
    private var apiKey = "b1bff03aead181f037cbd7a892ef44f3"
    
    //handles return of weather search and parses it into manageable object
    func getWeatherSearch(lat: Double, lon: Double, completion: @escaping (WeatherResult?) -> ()) {
        let url = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(apiKey)"
        print(url)
            AF.request(url, method: .get, parameters: nil).validate(statusCode: 200 ..< 600).responseData { response in
                switch response.result {
                case .success(let data):
                    let jsonData = try? JSONDecoder().decode(WeatherResult.self, from: data)
                    completion(jsonData)
                    
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    //handles return of coordinates search and parses it into manageable object
    func getCoordinates(city: String, completion: @escaping ([LocationSearchResult]?) -> ()) {
        let adjustedCity = city.replacingOccurrences(of: " ", with: "+")
        let url = "https://api.openweathermap.org/geo/1.0/direct?q=\(adjustedCity),US&limit=5&appid=\(apiKey)"
            AF.request(url, method: .get, parameters: nil).validate(statusCode: 200 ..< 299).responseData { response in
                switch response.result {
                case .success(let data):
                    let jsonData = try? JSONDecoder().decode([LocationSearchResult].self, from: data)
                    completion(jsonData)
                    
                case .failure(let error):
                    print(error)
            }
        }
    }
}
