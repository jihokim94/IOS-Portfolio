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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableview.delegate = self
        self.tableview.dataSource = self
        self.searchTextField.delegate = self
    }
    
    @IBAction func tapLocationButton(_ sender: UIButton) {
    }
    
    @IBAction func tapSearchButton(_ sender: UIButton) {
    }
    @IBAction func cityTextField(_ sender: UITextField) {
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
            return 2
        default:
            return 0
        }
    }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            //        let indexWeather = self.WeatherData[indexPath.section][indexPath.row]
            switch (indexPath.section , indexPath.row) {
            case (0 ,indexPath.row):
                guard let currentCell = self.tableview.dequeueReusableCell(withIdentifier: "currentCell") as? CurrentTableViewCell else { return UITableViewCell() }
                return currentCell
            case  (1 , indexPath.row):
                guard let forecastCell = self.tableview.dequeueReusableCell(withIdentifier: "forecastCell") as? ForecastTableViewCell else { return UITableViewCell()}
                
                return forecastCell
            default : return UITableViewCell()
                
            }
        }
    }
    
    extension ViewController : UITextFieldDelegate {
        
    }
