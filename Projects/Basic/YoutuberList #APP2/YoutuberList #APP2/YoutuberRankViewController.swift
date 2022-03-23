//
//  ViewController.swift
//  YoutuberList #APP2
//
//  Created by 김지호 on 2022/03/22.
//

import UIKit

class YoutuberRankViewController: UIViewController {

    //    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    //    let youtuberList = YoutuberList.list
    let viewModel = YoutuberListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        self.tableview.delegate = self
        //        self.tableview.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    private func urlToImage(url : URL , indexPath : IndexPath) -> UIImage {
        let data = try! Data(contentsOf: viewModel.getYoutuberByIndex(at: indexPath).imagePath)
        let image = UIImage(data: data)
        return image!
    }
    
   
}


//extension YoutuberRankViewController : UITableViewDelegate  {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        guard let vc = self.storyboard?.instantiateViewController(identifier: "DetailViewController") as? YoutuberDetailViewController else { return }
//
//        vc.youtuber = youtuberList[indexPath.row]
//        vc.viewModel.youtuber = viewModel.getYoutuberByIndex(at: indexPath)
//
//        self.navigationController?.pushViewController(vc, animated: true)
//        self.tableview.deselectRow(at: indexPath, animated: true)
//    }
//}


extension YoutuberRankViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfYoutuber
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as? YoutuberCollectionViewCell else {return UICollectionViewCell ()}
        
        let youtuber = viewModel.getYoutuberByIndex(at: indexPath)
                cell.chanelTitle.text = youtuber.chanelName
                cell.numberOfSubs.text = youtuber.numberOfSubs
                cell.imageview.image = urlToImage(url: youtuber.imagePath, indexPath: indexPath)
        
        return cell
    }
    
}

extension YoutuberRankViewController :  UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
        guard let vc = self.storyboard?.instantiateViewController(identifier: "DetailViewController") as? YoutuberDetailViewController else { return }
        
        vc.viewModel.youtuber = self.viewModel.getYoutuberByIndex(at: indexPath)
        
        self.navigationController?.pushViewController(vc, animated: true)
        self.collectionView.deselectItem(at: indexPath, animated: true)
    }
}

extension YoutuberRankViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSpacing = 10
        let width = (Int(self.view.bounds.width) - itemSpacing) / 2
        let height = (Int(self.view.bounds.height) - itemSpacing) / 2
        
        return CGSize(width: width, height: height)
    }
}

//extension YoutuberRankViewController : UITableViewDelegate  {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        guard let vc = self.storyboard?.instantiateViewController(identifier: "DetailViewController") as? YoutuberDetailViewController else { return }
//
////        vc.youtuber = youtuberList[indexPath.row]
//        vc.viewModel.youtuber = viewModel.getYoutuberByIndex(at: indexPath)
//
//        self.navigationController?.pushViewController(vc, animated: true)
//        self.tableview.deselectRow(at: indexPath, animated: true)
//    }
//}
//
//
//extension YoutuberRankViewController :  UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
////        return youtuberList.count
//        return viewModel.numberOfYoutuber
//    }
//
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? YoutuberRankTableViewCell else
//        { return UITableViewCell()}
//        print(indexPath.row)
//
//        let youtuber = viewModel.getYoutuberByIndex(at: indexPath)
//        cell.chanelTitle.text = youtuber.chanelName
//        cell.numSubscriber.text = youtuber.numberOfSubs
//        cell.imageview.image = urlToImage(url: youtuber.imagePath, indexPath: indexPath)
//
////        cell.chanelTitle.text = youtuberList[indexPath.row].chanelName
////
////        cell.imageview.image = urlToImage(url: youtuberList[indexPath.row].imagePath, indexPath: indexPath)
////        cell.numSubscriber.text = youtuberList[indexPath.row].numberOfSubs
//
//        return cell
//    }
//}
