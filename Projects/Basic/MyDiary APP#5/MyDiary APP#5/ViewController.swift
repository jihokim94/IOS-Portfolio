//
//  ViewController.swift
//  MyDiary APP#5
//
//  Created by 김지호 on 2022/03/31.
//

import UIKit

class ViewController: UIViewController {
    
    private var diaryList : [Diary] = []
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? WriteDiaryViewController {
            vc.delegate = self
        }
    }
    @IBOutlet weak var collectionview: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
    }
    
    private func configureCollectionView() {
        self.collectionview.dataSource = self
        self.collectionview.delegate = self
        //The custom distance that the content view is inset from the safe area or scroll view edges.
        // 번역 : safe area or scroll view 가장자리에서 삽입되는 사용자 지정 거리입니다.
        self.collectionview.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}



extension ViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return diaryList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = self.collectionview.dequeueReusableCell(withReuseIdentifier: "diaryCell", for: indexPath) as? DiaryCollectionViewCell else { return UICollectionViewCell()}
        
        let diary = self.diaryList[indexPath.item]
        
        let fommatter = DateFormatter()
        fommatter.locale = Locale(identifier: "ko_KR")
        fommatter.dateFormat = "yy년 MM월 dd일(EEEEE)"
        
        cell.titleLabel.text = diary.title
        cell.dateLabel.text = fommatter.string(from: diary.date)
        cell.dateLabel.sizeToFit()
        
        return cell
    }
    
}

extension ViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemSpacing = 20
        let width = (Int(self.view.bounds.width) / 2) - itemSpacing
        let height = 200
        let size = CGSize(width: width, height: height)
        return size
    }
}

extension ViewController : WriteDiaryViewDelegate {
    func didRegisterDiary(diary: Diary) {
        self.diaryList.append(diary)
        self.collectionview.reloadData()
    }
}
