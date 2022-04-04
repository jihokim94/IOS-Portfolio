//
//  StarViewController.swift
//  MyDiary APP#5
//
//  Created by 김지호 on 2022/04/01.
//

import UIKit

class StarViewController: UIViewController {
    
    @IBOutlet weak var collectionview: UICollectionView!
    
    var diaryList : [Diary] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchDiaryList()
        self.collectionview.delegate = self
        self.collectionview.dataSource = self
    }
    private func dateToString(date : Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy년 MM월 dd일(EEEEE)"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: date)
    }
    
    private func fetchDiaryList() {
        let userdefaults = UserDefaults.standard
        guard let data = userdefaults.object(forKey: "diaryList") as? [[String : Any]] else { return }
        self.diaryList = data.compactMap({
            guard let title = $0["title"] as? String else { return nil }
            guard let contents = $0["contents"] as? String else { return nil }
            guard let date = $0["date"] as? Date else { return nil }
            guard let isStar = $0["isStar"] as? Bool else { return nil }
            return Diary(title: title, contents: contents, date: date, isStar: isStar)
        }).filter({
            $0.isStar == true
        }).sorted(by: { $0.date.compare($1.date) == .orderedDescending })
    }
}


extension StarViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.diaryList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = self.collectionview.dequeueReusableCell(withReuseIdentifier: "starCell", for: indexPath) as? StarCollectionViewCell else { return UICollectionViewCell() }
        
        cell.titleLabel.text = self.diaryList[indexPath.item].title
        cell.dateLabel.text = self.dateToString(date :self.diaryList[indexPath.item].date)
        
        return cell
    }
}
extension StarViewController : UICollectionViewDelegate {
    
}
extension StarViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSpacing = 20
        let width =  CGFloat(self.view.bounds.width) - CGFloat(itemSpacing)
        return CGSize(width: width, height: 80)
    }
}
