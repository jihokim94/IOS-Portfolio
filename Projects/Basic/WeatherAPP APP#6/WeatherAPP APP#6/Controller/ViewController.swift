//
//  ViewController.swift
//  WeatherAPP APP#6
//
//  Created by 김지호 on 2022/04/15.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableview: UITableView!
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    @IBOutlet weak var viewForTable: UIView!
    
    let dataSource = WeatherDataSource.share
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableview.delegate = self
        self.tableview.dataSource = self
        self.searchTextField.delegate = self
        self.tableview.showsVerticalScrollIndicator = false
    }
    @objc private func locationDidUpdate(_ notification : Notification) {
        
    }
    
    @IBAction func tapLocationButton(_ sender: UIButton) {
        
        로이케이션 불러오기
        유아이 업데이트로 돌아가기 위한 조건을 충족하는경우 indicator 돌리기
        데이터 센터로 불러온 로이케이션 전달 및 네트워킹 진행후 인스턴스 벨리어블 초기화
        그다음 테이블 뷰 업데이트
        
//        let location = LocationManager.getCurrentLocation()
//        NotificationCenter.default.post(name: NSNotification.Name("locationDidUpdate"), object: location, userInfo: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(locationDidUpdate(_:)), name: NSNotification.Name("LocationDidUpdate"), object: )
    }
    
    @IBAction func tapSearchButton(_ sender: UIButton) {
        guard let cityName = self.searchTextField.text else { return }
        searchTextField.endEditing(true)
        // 노티피세이션으로 시티네임 업데이트  데이터 소스에서 
        NotificationCenter.default.post(name: NSNotification.Name("cityNameDidUpdate"), object: cityName, userInfo: nil)
        
        let urlString = WeatherDataSource.share.fetchUrlString(cityName: cityName)
        WeatherDataSource.share.fetchWeather(urlString: urlString) { (result : Result<CurrentWeather , Error>) in
            
            switch result {
            case .success(let data) :
                dump(data);
                self.tableview.reloadData()
            case .failure(let error):
                print(error.localizedDescription); break
                
            }
        }
    }
}






extension ViewController : UITableViewDelegate {
    
}

extension ViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return WeatherDataSource.share.forecastWeather.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        let indexWeather = self.WeatherData[indexPath.section][indexPath.row]
        switch (indexPath.section , indexPath.row) {
        case (0 ,indexPath.row):
            guard let currentCell = self.tableview.dequeueReusableCell(withIdentifier: "currentCell") as? CurrentTableViewCell else { return UITableViewCell() }
            let currentWeather = WeatherDataSource.share.currentWeather
            
            currentCell.currentCity.text = currentWeather?.cityName
            currentCell.currentImage.image = UIImage(systemName: currentWeather?.iconName ?? "")
            currentCell.currentStatus.text = currentWeather?.description
            currentCell.currentTemp.text = String(format: "1.f",currentWeather?.temperature ?? 0) + "°C"
            return currentCell
        case  (1 , indexPath.row):
            guard let forecastCell = self.tableview.dequeueReusableCell(withIdentifier: "forecastCell") as? ForecastTableViewCell else { return UITableViewCell()}
            let forecastData = WeatherDataSource.share.forecastWeather[indexPath.row]
            forecastCell.forecastDate.text = forecastData.date.dateString
            forecastCell.forecastTime.text = forecastData.date.timeString
            forecastCell.forecastTemp.text = String(forecastData.temperature) + "°C"
            forecastCell.forecastImage.image = UIImage(systemName: forecastData.iconName)
            forecastCell.forecastStatus.text = forecastData.description
            
            return forecastCell
        default : return UITableViewCell()
            
        }
    }
}

extension ViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != ""{
            return true
        } else {
            textField.placeholder = "Type CityName!"
            return false
        }
    }
}
