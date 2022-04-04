//
//  WriteDiaryViewController.swift
//  MyDiary APP#5
//
//  Created by 김지호 on 2022/04/01.
//

import UIKit
import Foundation

enum DiaryMode {
    case new
    case edit(IndexPath, Diary)
}

// 1. 델리게이트 프로토콜 생성
protocol WriteDiaryViewDelegate : AnyObject {
    func didRegisterDiary(diary : Diary)
}


class WriteDiaryViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentsTextView: UITextView!
    @IBOutlet weak var dateTextField: UITextField!
    
    @IBOutlet weak var confirmButton: UIBarButtonItem!
    
    
    private let datePicker = UIDatePicker()
    private var diaryDate : Date?
    
    var diaryMode = DiaryMode.new
    
    // 2. delegate 프로퍼티 생성
    weak var delegate : WriteDiaryViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureContentsTextView()
        self.configureDatePicker()
        self.configureTextFieldValidation()
        self.configureDiaryMode()
        self.contentsTextView.delegate = self
        
        // validation을 위한 등록버튼 비활성화
        self.confirmButton.isEnabled = false
    }
    // 수정 모드일때 컨피규어 메소드
    private func configureDiaryMode() {
        switch self.diaryMode {
        case let .edit(_, diary):
            self.titleTextField.text = diary.title
            self.contentsTextView.text = diary.contents
            self.dateTextField.text = self.dateToString(date: diary.date)
            self.diaryDate = diary.date
            self.confirmButton.title = "수정"
            break
        default:
            break
        }
    }
    // 아래 메소드들을 통해 인풋값의 변화가 있을시 validationDatas() 메소드로 유효성 체크 할거야~~ ㅇㅋ?
    private func configureTextFieldValidation() {
        // .editingchanged => 변경 될때 마다 셀럭터 함수가 호출될거임
        self.titleTextField.addTarget(self, action: #selector(titleTextFieldDidChange(_:)), for: .editingChanged)
        self.dateTextField.addTarget(self, action: #selector(dateTextFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc private func dateTextFieldDidChange (_ textfield : UITextField){
        self.validationDatas()
    }
    @objc private func titleTextFieldDidChange (_ textfield : UITextField){
        self.validationDatas()
    }
    
    func textViewDidChange(_ textView: UITextView) {
        self.validationDatas()
    }
    // 바로 위까지 validation
    
    private func validationDatas() {
        // 각 인풋 값들중 하나라도 false를 리턴하면 컨펌버튼이 언이네이블드 될거니 밑에 처럼 설정 화면 이지~
        self.confirmButton.isEnabled = !(self.titleTextField.text?.isEmpty ?? true) && !(self.contentsTextView.text.isEmpty ) && !(self.dateTextField.text?.isEmpty ?? true)
    }
    
    private func dateToString(date : Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy년 MM월 dd일(EEEEE)"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: date)
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
        // date textfield에 액션을 추가로 추가해주면 위에 validation 메소드가 작동되게 할수 잇음.
        self.dateTextField.sendActions(for: .editingChanged)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 빈공간 터치시 touchesBegan메소드가 실행 되며 아래와 같이 view의 editing 상태 resign to the first responder
        self.view.endEditing(true)
        
    }
    
    @IBAction func tapConfirmButton(_ sender: UIBarButtonItem) {
        
        guard let title = titleTextField.text else { return  }
        guard let contents = contentsTextView.text else { return  }
        guard let date = self.diaryDate else { return }

        let diary = Diary(title: title, contents: contents, date: date, isStar: false)
        
        switch self.diaryMode {
        case .new:
            self.delegate?.didRegisterDiary(diary: diary)
        case let .edit(indexpath, _):
            print("a")
            NotificationCenter.default.post(name: Notification.Name("editDiary"), object: diary, userInfo: ["indexpath.item" : indexpath.item])
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    
}

