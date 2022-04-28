//
//  CovidDetailTableViewController.swift
//  CovidStats APP#7
//
//  Created by 김지호 on 2022/04/28.
//

import UIKit

class CovidDetailTableViewController: UITableViewController {
    
    @IBOutlet weak var newCaseCell: UITableViewCell!
    @IBOutlet weak var totalCaseCell: UITableViewCell!
    @IBOutlet weak var recoveredCell: UITableViewCell!
    @IBOutlet weak var deathCell: UITableViewCell!
    @IBOutlet weak var percentageCell: UITableViewCell!
    @IBOutlet weak var overseaInflowCell: UITableViewCell!
    @IBOutlet weak var regionalOutBreakCell: UITableViewCell!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}
