//
//  ViewController.swift
//  ScreenTransition APP#3
//
//  Created by 김지호 on 2022/03/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func tapCodePushButton(_ sender: UIButton) {
        if let vc = self.storyboard?.instantiateViewController(identifier: "CodeViewController") as? CodePushViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    

    @IBAction func tapCodePresentButton(_ sender: UIButton) {
        
        guard let vc = self.storyboard?.instantiateViewController(identifier: "CodePresentViewController") as? CodePresentViewController else {return}
        vc.modalPresentationStyle = .fullScreen // 풀스크린 형태로 Present
        self.present(vc, animated: true, completion: nil)
    }
}

