//
//  ViewController.swift
//  Todo #APP4
//
//  Created by 김지호 on 2022/03/26.
//

import UIKit

class ViewController: UIViewController {
    
    var tasks = [Task]()
    
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableview.dataSource = self
//        self.tableview.delegate = self
    }
    @IBAction func tapEditButton(_ sender: UIBarButtonItem) {
        
    }
    
    @IBAction func tapAddButton(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Todo", message: "할일을 작성해주세요.", preferredStyle: .alert)
        let register = UIAlertAction(title: "추가", style: .default) { [weak self] _ in
            print(alert.textFields?[0].text)
            
            // 타이틀 작성 여부 없으면 그냥 리턴되버림 태스크를 생성하지 못할거야
            guard let title = alert.textFields?[0].text else { return }
            
            let newTask = Task(title: title, done: false)
            
            self?.tasks.append(newTask)
            self?.tableview.reloadData()
            
        }
        
        
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(register)
        alert.addAction(cancel)
        alert.addTextField { textfield in
            textfield.placeholder = "여기에 작성 해주세요! :)"
        }
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
}


extension ViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableview.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath)
        cell.textLabel?.text = tasks[indexPath.row].title
        if tasks[indexPath.row].done {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
       return cell
    }
    
    
}


