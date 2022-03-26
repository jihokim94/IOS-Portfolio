//
//  ViewController.swift
//  ScreenTransition APP#3
//
//  Created by 김지호 on 2022/03/24.
//

import UIKit

class ViewController: UIViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? SeguePushViewController {
            let data = "jiho 🐶"
            vc.segueData = data
        }
        print(#function)
    }
    
    
    
    @IBOutlet weak var mainLabel: UILabel!
    
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
        guard let vc = self.storyboard?.instantiateViewController(identifier: "CodeViewController") as? CodePushViewController else { return }
        let data = "지호👍"
        vc.data = data
        
        // ViewController가 delegate 위임함
        vc.delegate = self
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    @IBAction func tapCodePresentButton(_ sender: UIButton) {
        
        guard let vc = self.storyboard?.instantiateViewController(identifier: "CodePresentViewController") as? CodePresentViewController else {return}
        let data = "지호👍"
        vc.data = data
        vc.modalPresentationStyle = .fullScreen // 풀스크린 형태로 Present
        self.present(vc, animated: true, completion: nil)
    }
}


// delegate 채택 후 정의
extension ViewController : SendingDataDelegate {
    func sendData(data: String) {
        self.mainLabel.text = data
        self.mainLabel.sizeToFit()
    }
}
