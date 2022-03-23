//
//  DetailViewController.swift
//  YoutuberList #APP2
//
//  Created by 김지호 on 2022/03/22.
//

import UIKit

class YoutuberDetailViewController: UIViewController {
    
//    var youtuber : Youtuber? = nil
    let viewModel = DetailViewModel()
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var chanelTitle: UILabel!
    @IBOutlet weak var numberOfSub: UILabel!
    
   
    private func updateDetailUI() {
        self.chanelTitle.text = viewModel.youtuber?.chanelName
        self.numberOfSub.text = viewModel.youtuber?.numberOfSubs
        self.imageView.image = UIImage(data: try! Data(contentsOf: (viewModel.youtuber?.imagePath)!))
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        updateDetailUI()
    }

}
