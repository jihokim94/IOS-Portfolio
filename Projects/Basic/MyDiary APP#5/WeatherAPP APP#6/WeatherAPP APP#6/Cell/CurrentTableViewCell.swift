//
//  CurrentTableViewCell.swift
//  WeatherAPP APP#6
//
//  Created by 김지호 on 2022/04/18.
//

import UIKit

class CurrentTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundColor = .clear // 투명하게하기
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
