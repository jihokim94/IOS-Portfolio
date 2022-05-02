//
//  ViewController.swift
//  LoginAPPWithAuth APP#8
//
//  Created by 김지호 on 2022/05/02.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailLoginButton: UIButton!
    @IBOutlet weak var googleLoginButton: UIButton!
    @IBOutlet weak var appleLoginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureLoginButtonStyle()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    private func configureLoginButtonStyle() {
        [emailLoginButton , googleLoginButton , appleLoginButton].forEach { button in
            button?.layer.borderWidth = 1
            button?.layer.borderColor = UIColor.white.cgColor
            button?.layer.cornerRadius = 30
        }
    }
}

