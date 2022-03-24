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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateDetailUI()
        prepareLabelAnimate()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        performLabelAnimate()
    }
    
    @IBOutlet weak var chanelTitleCenterX: NSLayoutConstraint!
    
    @IBOutlet weak var numberOfSubsCenterX: NSLayoutConstraint!
    private func updateDetailUI() {
        self.chanelTitle.text = viewModel.youtuber?.chanelName
        self.numberOfSub.text = viewModel.youtuber?.numberOfSubs
        self.imageView.image = UIImage(data: try! Data(contentsOf: (viewModel.youtuber?.imagePath)!))
    }
    
    private func prepareLabelAnimate() {
//        self.chanelTitleCenterX.constant = view.bounds.width
//        self.numberOfSubsCenterX.constant = view.bounds.width
        self.chanelTitle.transform = CGAffineTransform(translationX: view.bounds.width, y: 0).scaledBy(x: 3, y: 0).rotated(by: 180)
        self.numberOfSub.transform = CGAffineTransform(translationX: view.bounds.width, y: 0).scaledBy(x: 3, y: 0).rotated(by: 180)
    }
    
    private func performLabelAnimate() {
//        self.chanelTitleCenterX.constant = 0
//        self.numberOfSubsCenterX.constant = 0
       
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping:0.5, initialSpringVelocity: 1, options: .curveEaseIn ,animations: {
            self.chanelTitle.transform = CGAffineTransform.identity //트랜스폼 주기 이전 값으로 돌아감
        } , completion: nil)
        
        UIView.animate(withDuration: 1, delay: 0.2, usingSpringWithDamping:0.5, initialSpringVelocity: 1, options: .curveEaseInOut ,animations: {
            self.numberOfSub.transform = CGAffineTransform.identity //트랜스폼 주기 이전 값으로 돌아감
        } , completion: nil)
        
        UIView.transition(with: imageView, duration: 0.3, options: .transitionFlipFromRight, animations: nil)
    }
}


