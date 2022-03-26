//
//  CodePresentViewController.swift
//  ScreenTransition APP#3
//
//  Created by 김지호 on 2022/03/24.
//

import UIKit

class CodePresentViewController: UIViewController {

    var data : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataLabel.text = data
    }
    
    @IBOutlet weak var dataLabel: UILabel!
    
    @IBAction func tapBackButton(_ sender: UIButton) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    

}
