//
//  CodeViewController.swift
//  ScreenTransition APP#3
//
//  Created by 김지호 on 2022/03/24.
//

import UIKit

protocol SendingDataDelegate : AnyObject {
    func sendData(data : String)
}

class CodePushViewController: UIViewController {
    var data : String?
    
    //weak를 안달면 강한 순환 참조로 메모리 누수가 발생될 수 있다.
    weak var delegate : SendingDataDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataLabel.text = data
    }
    
    
    @IBOutlet weak var dataLabel: UILabel!
    
    @IBAction func tapBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        self.delegate?.sendData(data: data ?? "데이터없엉")
    }
    
}
