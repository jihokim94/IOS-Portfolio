//
//  WeatherDataSource.swift
//  WeatherAPP APP#6
//
//  Created by 김지호 on 2022/04/20.
//

import Foundation
import UIKit

class WeatherDataSource {
    
    static let share = WeatherDataSource()
   
    private init() {
    }
    
    var currentWeather : CurrentData?
    var forecastWeather = [ForecastData]()

    
    /*
     https://api.openweathermap.org/data/2.5/forecast?appid=b4456772e951b06210b35ba19ebed430&q=seoul&lang=kr&units=metric
     
     */
        let apiKey = "b4456772e951b06210b35ba19ebed430"
//        let cityName = "seoul"
    //
//        let urlstrByCity = "https://api.openweathermap.org/data/2.5/weather?appid=\(apiKey)&q=\(cityName)&lang=kr&units=metric"
    
    
    //    let urlstrByGeo = "https://api.openweathermap.org/data/2.5/forecast?appid=\(apiKey)&lat=\(126.9778)& lon=\(37.5683)&lang=kr&units=metric"
    //
    //    let url = URL(string: urlstrByCity)
    
      func fetchUrlString(cityName : String) -> String {
        let urlstrByCity = "https://api.openweathermap.org/data/2.5/weather?appid=\(apiKey)&q=\(cityName)&lang=kr&units=metric"
        
        return urlstrByCity
    }
    
     func fetchWeather <T:Codable> (urlString : String ,completion : @escaping (Result<T ,Error>)->())  {
        
        guard let url = URL(string: urlString) else {
            completion(.failure(print("Error") as! Error))
            return
        }
        
        let task = URLSession(configuration: .default).dataTask(with: url) { data, response, error in
            guard let data = data else {
                completion(.failure(ApiError.NoData))
                return
            }
            guard error == nil else {
                print(error?.localizedDescription)
                completion(.failure(ApiError.Ext))
                return
            }
            // respone이 존재하지 않다면 에러표시
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(ApiError.NoResponese))
                print("noResponse")
                return
            }
            guard (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(ApiError.InvalidResponse(httpResponse.statusCode)))
                return
            }
            do {
                let decoder = JSONDecoder()
                let data = try decoder.decode(T.self, from: data)
                completion(.success(data))
            } catch let error {
                print(error.localizedDescription)
                completion(.failure(error))
                return
            }
            
        }
        task.resume()
    }
    
    
    
}

enum ApiError : Error {
    case InvalidURL(String)
    case InvalidResponse(Int)
    case NoResponese
    case NoData
    case Ext
}
