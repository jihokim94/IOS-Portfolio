//
//  Date+Formatter.swift
//  WeatherAPP APP#6
//
//  Created by 김지호 on 2022/04/26.
//

import Foundation


private var dateFormatter : DateFormatter {
   let f = DateFormatter()
   f.locale = Locale(identifier: "ko_kr")
   return f
}

extension Date{
   var dateString : String { // 날짜
       dateFormatter.dateFormat = "M월 d일"
       return dateFormatter.string(from: self)
   }
   
   var timeString : String { //시간
       dateFormatter.dateFormat = "HH:00"
       return dateFormatter.string(from: self)
   }
}




