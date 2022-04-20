//
//  ForecastWeather.swift
//  WeatherAPP APP#6
//
//  Created by 김지호 on 2022/04/20.
//

import Foundation

struct ForecastWeather : Codable {
    let cod : String
    let message : Int
    let list : [ListItem]
    
    struct ListItem : Codable {
        let dt : Int
        let main : Main
        let weather : [Weather]
        
        struct Weather : Codable{
            let id : Int
            let description : String
        }
        struct Main : Codable {
            let temp : Double
        }
        
    }
}

struct ForecastData { // 테이블에 잘 넣을 수 있도록 구조체 하나 더만듬
    let weatherId : Int
    let date : Date
    let description : String
    let temperature : Double
    
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
