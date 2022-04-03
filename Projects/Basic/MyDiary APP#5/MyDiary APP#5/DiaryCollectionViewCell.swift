//
//  DiaryCollectionViewCell.swift
//  MyDiary APP#5
//
//  Created by 김지호 on 2022/04/01.
//

import UIKit

class DiaryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.contentView.layer.cornerRadius = 5
        self.contentView.layer.borderColor = UIColor.black.cgColor
        self.contentView.layer.borderWidth = 1
    }
}
