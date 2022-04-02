//
//  WriteDiaryViewController.swift
//  MyDiary APP#5
//
//  Created by 김지호 on 2022/04/01.
//

import UIKit

class WriteDiaryViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentsTextView: UITextView!
    @IBOutlet weak var dateTextField: UITextField!
    
    @IBOutlet weak var confirmButton: UIBarButtonItem!
    
    
    private let datePicker = UIDatePicker()
    private var diaryDate : Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureContentsTextView()
        self.configureDatePicker()
    }
    
    private func configureContentsTextView() {
        self.contentsTextView.layer.borderWidth = 1
        self.contentsTextView.layer.borderColor = UIColor(red: 225/255, green: 225/255, blue: 225/255, alpha: 1.0).cgColor
    }
    private func configureDatePicker() {
        self.datePicker.datePickerMode = .date
        self.datePicker.preferredDatePickerStyle = .wheels
        self.datePicker.locale = Locale(identifier: "ko_KR")
        // valueChange 할때 마다 셀럭터 함수가 호출 된다.
        self.datePicker.addTarget(self, action: #selector(datePickerValueDidChange(_:)), for: .valueChanged)
        // dateTextField를 누르면 데이트 픽커가 나온다.
        self.dateTextField.inputView = self.datePicker
    }
    
    @objc private func datePickerValueDidChange (_ datepicker : UIDatePicker ){
        let fommatter = DateFormatter()
        fommatter.locale = Locale(identifier: "ko_KR")
        fommatter.dateFormat = "yyyy년 MM월 dd일(EEEEE)"
        self.diaryDate = datepicker.date
        self.dateTextField.text = fommatter.string(from: datepicker.date)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 빈공간 터치시 touchesBegan메소드가 실행 되며 아래와 같이 datePikerView의 View의 editing 상태를 종료함
        self.datePicker.endEditing(true)
        
    }
    
    @IBAction func tapConfirmButton(_ sender: UIBarButtonItem) {
    }
    
}
