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
        self.collectionview.delegate = self
        self.collectionview.dataSource = self
        self.fetchDiaryList()
        NotificationCenter.default.addObserver(self, selector: #selector(editDiaryNotification(_:)), name: NSNotification.Name(rawValue: "editDiary"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(starDiaryNotification(_:)), name: NSNotification.Name("starDiary"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(deleteDiaryNotification(_:)), name: NSNotification.Name("deleteDiary"), object: nil)
        
    }
    
    @objc private func editDiaryNotification(_ notification : Notification) {
        guard let diary = notification.object as? Diary else { return }
        guard let indexPathItem = notification.userInfo?["indexpath.item"] as? Int else { return }
        self.diaryList[indexPathItem] = diary
        self.diaryList.sort(by: { $0.date > $1.date })
        
        self.collectionview.reloadData()
    }
    
    @objc private func starDiaryNotification (_ notification : Notification) {
        guard let data = notification.object as? [String : Any] else { return }
        guard let diary = data["diary"] as? Diary else { return }
        guard let isStar = data["isStar"] as? Bool else { return }
        guard let indexpath = data["indexPath"] as? IndexPath else { return }
        if isStar {
            self.diaryList.append(diary)
            self.diaryList = self.diaryList.sorted(by: { $0.date.compare($1.date) == .orderedDescending })
            self.collectionview.reloadData()
        } else {
            self.diaryList.remove(at: indexpath.item)
            self.collectionview.deleteItems(at: [indexpath])
        }
        
    }
    @objc private func deleteDiaryNotification(_ notification : Notification) {
        guard let indexPath = notification.object as? IndexPath else { return }
        self.diaryList.remove(at: indexPath.item)
        self.collectionview.deleteItems(at: [indexPath])
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
        
        self.collectionview.reloadData()
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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let vc = self.storyboard?.instantiateViewController(identifier: "DiaryDetailViewController") as? DiaryDetailViewController else { return }
        
        vc.diary = self.diaryList[indexPath.item]
        vc.indexpath = indexPath
        print(indexPath)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
extension StarViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSpacing = 20
        let width =  CGFloat(self.view.bounds.width) - CGFloat(itemSpacing)
        return CGSize(width: width, height: 80)
    }
}
