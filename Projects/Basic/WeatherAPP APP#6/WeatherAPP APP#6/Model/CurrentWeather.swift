//
//  CurrentWeather.swift
//  WeatherAPP APP#6
//
//  Created by 김지호 on 2022/04/19.
//

import Foundation

struct CurrentWeather : Codable {
    let name : String
    let cod : Int
    let main : Main
    let weather : [Weather]
}

struct Main : Codable{
    let temp : Double
}

struct Weather : Codable{
    let id : Int
    let description : String
}


struct CurrentData : Codable {
    let weatherId : Int
    let cityName : String
    let temperature : Double
    let description : String
    
    var iconName : String {
        switch weatherId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
}
