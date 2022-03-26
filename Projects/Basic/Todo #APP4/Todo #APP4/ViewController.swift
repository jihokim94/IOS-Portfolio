//
//  ViewController.swift
//  Todo #APP4
//
//  Created by 김지호 on 2022/03/26.
//

import UIKit

class ViewController: UIViewController {
    
    var tasks = [Task]() {
        didSet {
            self.saveTasks()
        }
    }
    
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadTasks()
        self.tableview.dataSource = self
        //        self.tableview.delegate = self
    }
    
    
    private func saveTasks() {
        var data : [[String : Any]] = self.tasks.map {
            return [ "title" : $0.title ,"done" : $0.done ]
        }
        let userDefaults = UserDefaults.standard
        //유저디폴츠에 저장 하는 법
        /*
         value : 저장할 데이터를 넣어야함
        forKey : 저장 데이터의 키를 지정해 줄수있음 추후에 이 키를 통해 데이터 뽑을거임
         */
        userDefaults.set(data, forKey: "tasks")
    }
    
    private func loadTasks() {
        let userDefaults = UserDefaults.standard
        // 저장할 당시 set에 지정한 Key를 통해 오브젝트를 뽑을수 있다.
        // Returns the object associated with the specified key.
        // 데이터 유무 확인 없음 리턴
        guard let data = userDefaults.object(forKey: "tasks") as? [[String : Any]] else { return }
        
        //
//        self.tasks = data.compactMap({ taskList in
//            guard let title = taskList["title"] as? String else { return nil }
//            guard let done = taskList["done"] as? Bool else { return nil }
//            return Task(title: title, done: done)
//        })
        
        self.tasks = data.compactMap {
            guard let title = $0["title"] as? String else {return nil}
            guard let done = $0["done"] as? Bool else {return nil}
            return Task(title: title, done: done)
        }
        
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


