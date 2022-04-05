//
//  ViewController.swift
//  MyDiary APP#5
//
//  Created by 김지호 on 2022/03/31.
//

import UIKit

class ViewController: UIViewController {
    
    private var diaryList : [Diary] = [] {
        didSet {
            self.saveDiaryList()
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? WriteDiaryViewController {
            vc.delegate = self
        }
    }
    @IBOutlet weak var collectionview: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        fetchDiaryList()
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
        guard let isStar = data["isStar"] as? Bool else { return }
        guard let indexpath = data["indexPath"] as? IndexPath else { return }
        
        self.diaryList[indexpath.item].isStar = isStar
    }
    @objc private func deleteDiaryNotification(_ notification : Notification) {
        guard let indexPath = notification.object as? IndexPath else { return }
        self.diaryList.remove(at: indexPath.item)
        self.collectionview.deleteItems(at: [indexPath])
    }
    
    private func configureCollectionView() {
        self.collectionview.dataSource = self
        self.collectionview.delegate = self
        //The custom distance that the content view is inset from the safe area or scroll view edges.
        // 번역 : safe area or scroll view 가장자리에서 삽입되는 사용자 지정 거리입니다.
        self.collectionview.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    private func saveDiaryList() {
        let data = self.diaryList.map { diary in
            ["title" : diary.title , "contents" : diary.contents , "date" : diary.date , "isStar" : diary.isStar]
        }
        
        let userdefaults = UserDefaults.standard
        userdefaults.set(data, forKey: "diaryList")
    }
    
    private func fetchDiaryList() {
        let userdefaults = UserDefaults.standard
        if let data = userdefaults.object(forKey: "diaryList") as? [[String : Any]] {
            self.diaryList = data.compactMap {
                guard let title = $0["title"] as? String else {return nil}
                guard let contents = $0["contents"] as? String else {return nil}
                guard let date  = $0["date"] as? Date else {return nil}
                guard let isStar = $0["isStar"] as? Bool else {return nil}
                
                return Diary(title: title, contents: contents, date: date, isStar: isStar)
            }
        }
        self.diaryList.sort(by: { return $0.date > $1.date }) // 내림차순 정렬
        debugPrint(self.diaryList)
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


extension ViewController :UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let vc = self.storyboard?.instantiateViewController(identifier: "DiaryDetailViewController") as? DiaryDetailViewController else { return }
        vc.diary = self.diaryList[indexPath.item]
        vc.indexpath = indexPath
//        vc.delegate = self
        
        self.navigationController?.pushViewController(vc, animated: true)
        //        self.collectionview.deselectItem(at: [indexPath.item], animated: true)
    }
}


extension ViewController : WriteDiaryViewDelegate {
    func didRegisterDiary(diary: Diary) {
        self.diaryList.append(diary)
        debugPrint(self.diaryList)
        self.collectionview.reloadData()
    }
}

//extension ViewController : DetailViewDelegate {
//    func didSelectStar(indexpath: IndexPath, isStar: Bool) {
//        self.diaryList[indexpath.item].isStar = isStar
//    }
    
//    func didDeleteDiary(indexpath: IndexPath) {
//        self.diaryList.remove(at: indexpath.item)
//        self.collectionview.deleteItems(at: [indexpath])
//    }
//}
