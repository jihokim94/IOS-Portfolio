//
//  EmailLoginViewController.swift
//  LoginAPPWithAuth APP#8
//
//  Created by 김지호 on 2022/05/02.
//

import UIKit
import FirebaseAuth

class EmailLoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        self.nextButton.isEnabled = false
        self.nextButton.layer.cornerRadius = 30
        
        self.emailTextField.becomeFirstResponder()
        
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
    }
    
    
    @IBAction func tapNextButton(_ sender: UIButton) {
        let email = self.emailTextField.text ?? ""
        let password = self.passwordTextField.text ?? ""
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            guard let self = self else { return }
            guard let result = authResult, error == nil  else {
                print(error?.localizedDescription)
                return}
            print("새로운 유저 저장 성공")
            self.showMainViewController()
        }
    }
    
    private func showMainViewController(){
        let MainVC = storyboard?.instantiateViewController(identifier: "MainViewController") as! MainViewController
        MainVC.modalPresentationStyle = .fullScreen
        navigationController?.show(MainVC, sender: nil)
    }
    
}

extension EmailLoginViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 입력값에 따라 커서 위치 변경
//        emailTextField.endEditing(true)
        if textField == emailTextField {
              passwordTextField.becomeFirstResponder()
            } else {
              passwordTextField.resignFirstResponder()
            }
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        nextButton.isEnabled = !(self.emailTextField.text == nil) && !(self.passwordTextField.text == nil)
    }
}
