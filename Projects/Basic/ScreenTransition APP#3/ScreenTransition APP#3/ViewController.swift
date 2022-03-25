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
        print("\(#function) ,ViewController 뷰가 로드 되었다.")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("\(#function) ,ViewController 뷰가 나타날 것이다.")
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("\(#function) ,ViewController 뷰가 나타났다.")
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("\(#function) ,ViewController 뷰가 사라질 것이다.")
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("\(#function) ,ViewController 뷰가 사라졌다.")
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

