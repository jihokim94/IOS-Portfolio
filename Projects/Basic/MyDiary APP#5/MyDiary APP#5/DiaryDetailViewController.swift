//
//  DiaryDetailViewController.swift
//  MyDiary APP#5
//
//  Created by 김지호 on 2022/04/01.
//

import UIKit

//protocol DetailViewDelegate : AnyObject {
//    func didDeleteDiary(indexpath : IndexPath)
//    func didSelectStar(indexpath : IndexPath , isStar : Bool)
//}

class DiaryDetailViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentsTextView: UITextView!
    @IBOutlet weak var dateLabel: UILabel!
    
    var diary : Diary?
    var indexpath : IndexPath?
    
    var starButton : UIBarButtonItem?
    
//    weak var delegate : DetailViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureDetailView()
    }
    
    private func dateToString(date : Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy년 MM월 dd일(EEEEE)"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: date)
    }
    
    private func configureDetailView() {
        guard let diary = self.diary  else { return }
        self.titleLabel.text = diary.title
        self.contentsTextView.text = diary.contents
        self.dateLabel.text = dateToString(date: diary.date)
        
        // 즐겨찾기 버튼 추가
        self.starButton = UIBarButtonItem(image: nil, style: .plain, target: self, action: #selector(tapStarButton))
        self.starButton?.image = diary.isStar ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        self.starButton?.tintColor = .orange
        self.navigationItem.rightBarButtonItem = self.starButton
        
    }
    @objc private func tapStarButton() {
        guard let isStar = self.diary?.isStar else { return }
        guard let indexPath = self.indexpath else { return }
        if isStar {
            self.starButton?.image = UIImage(systemName: "star")
        } else {
            self.starButton?.image = UIImage(systemName: "star.fill")
        }
        // 토글시 값변경
        self.diary?.isStar = !isStar
        // 델리게이트로 데이터 루트vc 로 전달
        NotificationCenter.default.post(
            name: NSNotification.Name("starDiary"),
            object: ["diary" : self.diary ,"isStar" : self.diary?.isStar ?? false , "indexPath" : indexPath],
            userInfo: nil)
//        self.delegate?.didSelectStar(indexpath: indexPath , isStar: self.diary?.isStar ?? false)
    }
    
    
    @objc private func editDiaryNotification (_ notification : Notification) {
        guard let diary = notification.object as? Diary else { return }
        guard let indexpathItem = notification.userInfo?["indexpath.item"] as? Int else { return }
        self.diary = diary
        self.configureDetailView()
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @IBAction func tapEditButton(_ sender: UIButton) {
        guard let vc = self.storyboard?.instantiateViewController(identifier: "WriteDiaryViewController") as? WriteDiaryViewController else { return }
        guard let indexPath = self.indexpath else { return }
        guard let diary = self.diary else { return }
        debugPrint(diary)
        vc.diaryMode = .edit(indexPath, diary)
        
        NotificationCenter.default.addObserver(self, selector: #selector(editDiaryNotification(_:)), name: NSNotification.Name("editDiary"), object: nil)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func tapDeleteButton(_ sender: UIButton) {
        guard let indexPath = self.indexpath else { return }
        
        NotificationCenter.default.post(name:Notification.Name("deleteDiary"), object: indexPath, userInfo: nil)
//        self.delegate?.didDeleteDiary(indexpath: indexPath)
        self.navigationController?.popViewController(animated: true)
    }
    
}
