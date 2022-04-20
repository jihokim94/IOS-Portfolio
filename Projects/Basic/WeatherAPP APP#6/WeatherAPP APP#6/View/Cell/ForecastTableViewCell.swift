//
//  ForecastTableViewCell.swift
//  WeatherAPP APP#6
//
//  Created by 김지호 on 2022/04/18.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {

    @IBOutlet weak var forecastDate: UILabel!
    @IBOutlet weak var forecastTime: UILabel!
    @IBOutlet weak var forecastImage: UIImageView!
    @IBOutlet weak var forecastStatus: UILabel!
    @IBOutlet weak var forecastTemp: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundColor = .clear
        forecastDate.textColor = .white
        forecastTime.textColor = .white
        forecastStatus.textColor = .white
        forecastTemp.textColor = .white
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
