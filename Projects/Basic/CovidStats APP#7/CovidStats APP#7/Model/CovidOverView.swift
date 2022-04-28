//
//  CityOverView.swift
//  CovidStats APP#7
//
//  Created by 김지호 on 2022/04/28.
//

import Foundation

struct CovidOverView : Codable {
    let resultCode : String
    let resultMessage : String
    
    let korea : CityOverView
    let seoul : CityOverView
    let busan : CityOverView
    let daegu : CityOverView
    let incheon : CityOverView
    let gwangju : CityOverView
    let daejeon : CityOverView
    let ulsan : CityOverView
    let sejong : CityOverView
    let gangwon: CityOverView
    let chungbuk: CityOverView
    let chungnam: CityOverView
    let jeonbuk: CityOverView
    let jeonnam: CityOverView
    let gyeongbuk: CityOverView
    let gyeongnam : CityOverView
    let jeju : CityOverView
    let quarantine : CityOverView
    
    
    
}

struct CityOverView : Codable {
    let countryName : String
    let newCase : String
    let totalCase : String
    let recovered : String
    let death : String
    let percentage : String
    let newCcase : String
    let newFcase : String
}
