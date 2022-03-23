//
//  YoutuberCollectionViewCell.swift
//  YoutuberList #APP2
//
//  Created by 김지호 on 2022/03/23.
//

import UIKit

class YoutuberCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var chanelTitle: UILabel!
    @IBOutlet weak var numberOfSubs: UILabel!
    
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
}
