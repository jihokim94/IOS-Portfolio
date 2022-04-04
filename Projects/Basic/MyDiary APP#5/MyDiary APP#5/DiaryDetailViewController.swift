//
//  DiaryDetailViewController.swift
//  MyDiary APP#5
//
//  Created by 김지호 on 2022/04/01.
//

import UIKit

protocol DetailViewDelegate : AnyObject {
    func didDeleteDiary(indexpath : IndexPath)
}

class DiaryDetailViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentsTextView: UITextView!
    @IBOutlet weak var dateLabel: UILabel!
    
    var diary : Diary?
    var indexpath : IndexPath?
    
    weak var delegate : DetailViewDelegate?
    
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
        
    }
    
    @IBAction func tapEditButton(_ sender: UIButton) {
    }
    @IBAction func tapDeleteButton(_ sender: UIButton) {
        guard let indexPath = self.indexpath else { return }
        self.delegate?.didDeleteDiary(indexpath: indexPath)
        self.navigationController?.popViewController(animated: true)
    }
    
}
