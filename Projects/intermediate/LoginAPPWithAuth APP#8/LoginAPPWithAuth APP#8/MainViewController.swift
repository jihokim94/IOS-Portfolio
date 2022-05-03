//
//  MainViewController.swift
//  LoginAPPWithAuth APP#8
//
//  Created by 김지호 on 2022/05/02.
//

import UIKit
import FirebaseAuth

class MainViewController: UIViewController {
    
    @IBOutlet weak var welcomeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 기존 pop 제스쳐를 false를 함으로써 되돌아갈시 어색하지 않게 바꾼다.
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let email = Auth.auth().currentUser?.email ?? "고객"
        self.welcomeLabel.text = """
            환영합니다.
            \(email)
            """
        navigationController?.isNavigationBarHidden = true
    }
    @IBAction func taplogoutButton(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(identifier: "LoginViewController") as! LoginViewController
        self.navigationController?.popToViewController(vc, animated: true)
    }
}
