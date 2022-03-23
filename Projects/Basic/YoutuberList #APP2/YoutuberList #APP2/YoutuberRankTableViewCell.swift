//
//  YoutuberRankTableViewCell.swift
//  YoutuberList #APP2
//
//  Created by 김지호 on 2022/03/22.
//

import UIKit

class YoutuberRankTableViewCell: UITableViewCell {

    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var chanelTitle: UILabel!
    @IBOutlet weak var numSubscriber: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // 이미지뷰 초기 세팅
        configureImageView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func configureImageView() {
        self.imageview.layer.cornerRadius = self.imageview.frame.height / 2
        self.imageview.layer.borderWidth = 1
        self.imageview.layer.borderColor = UIColor.clear.cgColor
        
        // 이 함수를 True로하게 되면, 이 후에 이 이미지에 들어가는 서브 컴포넌트들은 부모를 따라감.
        self.imageview.clipsToBounds = true
    }

}
