//
//  ViewController.swift
//  YoutuberList #APP2
//
//  Created by 김지호 on 2022/03/22.
//

import UIKit

class YoutuberRankViewController: UIViewController {
    
    
    @IBOutlet weak var tableview: UITableView!
    
    let youtuberList = YoutuberList.list
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableview.delegate = self
        self.tableview.dataSource = self
    }
    
    private func urlToImage(url : URL , indexPath : IndexPath) -> UIImage {
        let data = try! Data(contentsOf: youtuberList[indexPath.row].imagePath)
        let image = UIImage(data: data)
        return image!
    }
}


extension YoutuberRankViewController : UITableViewDelegate  {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = self.storyboard?.instantiateViewController(identifier: "DetailViewController") as? YoutuberDetailViewController else { return }
        
        vc.youtuber = youtuberList[indexPath.row]
        
        self.navigationController?.pushViewController(vc, animated: true)
        self.tableview.deselectRow(at: indexPath, animated: true)
    }
}


extension YoutuberRankViewController :  UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return youtuberList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? YoutuberRankTableViewCell else
        { return UITableViewCell()}
        
        cell.chanelTitle.text = youtuberList[indexPath.row].chanelName
       
        cell.imageview.image = urlToImage(url: youtuberList[indexPath.row].imagePath, indexPath: indexPath)
        cell.numSubscriber.text = youtuberList[indexPath.row].numberOfSubs
        
        return cell
    }
    
}
