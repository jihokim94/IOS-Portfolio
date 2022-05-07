//
//  ViewController.swift
//  LoginAPPWithAuth APP#8
//
//  Created by 김지호 on 2022/05/02.
//

import UIKit
import Firebase
import GoogleSignIn

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailLoginButton: UIButton!
    @IBOutlet weak var googleLoginButton: GIDSignInButton!
    @IBOutlet weak var appleLoginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureLoginButtonStyle()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    
    @IBAction func tapGoogleSignIn(_ sender: UIButton) {
        self.googleSignIn()
    }
    @IBAction func tapAppleSignIn(_ sender: UIButton) {
    }
    private func configureLoginButtonStyle() {
        [emailLoginButton , googleLoginButton , appleLoginButton].forEach { button in
            button?.layer.borderWidth = 1
            button?.layer.borderColor = UIColor.white.cgColor
            button?.layer.cornerRadius = 30
        }
    }
    private func showMainViewController() {
        let mainVC = storyboard?.instantiateViewController(identifier: "MainViewController") as! MainViewController
        navigationController?.pushViewController(mainVC, animated: true)
    }
    
    private func googleSignIn() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let signInConfig = GIDConfiguration.init(clientID: clientID)
        
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self) { user, error in
            guard error == nil else { return }
            
            guard let authentication = user?.authentication else { return }
            let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken!, accessToken: authentication.accessToken)
            // access token 부여 받음
            
            // 파베 인증정보 등록
            Auth.auth().signIn(with: credential) {_,_ in
                // token을 넘겨주면, 성공했는지 안했는지에 대한 result값과 error값을 넘겨줌
                self.showMainViewController()
                
            }
            
        }
    }
}
