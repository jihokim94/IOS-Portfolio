//
//  DetailViewController.swift
//  YoutuberList #APP2
//
//  Created by 김지호 on 2022/03/22.
//

import UIKit

class YoutuberDetailViewController: UIViewController {
    
    var youtuber : Youtuber? = nil
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var chanelTitle: UILabel!
    @IBOutlet weak var numberOfSub: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.chanelTitle.text = youtuber?.chanelName
        self.numberOfSub.text = youtuber?.numberOfSubs
        self.imageView.image = UIImage(data: try! Data(contentsOf: (youtuber?.imagePath)!))

    }

}
