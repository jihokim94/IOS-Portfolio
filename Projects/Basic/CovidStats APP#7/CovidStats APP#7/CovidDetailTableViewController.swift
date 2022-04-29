//
//  CovidDetailTableViewController.swift
//  CovidStats APP#7
//
//  Created by 김지호 on 2022/04/28.
//

import UIKit

class CovidDetailTableViewController: UITableViewController {
    
    var cityOverView : CityOverView? = nil
    
    @IBOutlet weak var newCaseCell: UITableViewCell!
    @IBOutlet weak var totalCaseCell: UITableViewCell!
    @IBOutlet weak var recoveredCell: UITableViewCell!
    @IBOutlet weak var deathCell: UITableViewCell!
    @IBOutlet weak var percentageCell: UITableViewCell!
    @IBOutlet weak var overseaInflowCell: UITableViewCell!
    @IBOutlet weak var regionalOutBreakCell: UITableViewCell!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureCells(cityOverView: cityOverView)
    }
    
    private func configureCells(cityOverView : CityOverView?) {
        guard let cityOverView = cityOverView else { return }
        
        self.title = cityOverView.countryName
        newCaseCell.detailTextLabel?.text = cityOverView.newCase
        totalCaseCell.detailTextLabel?.text = cityOverView.totalCase
        recoveredCell.detailTextLabel?.text = cityOverView.recovered
        deathCell.detailTextLabel?.text = cityOverView.death
        percentageCell.detailTextLabel?.text = cityOverView.percentage
        overseaInflowCell.detailTextLabel?.text = cityOverView.newFcase
        regionalOutBreakCell.detailTextLabel?.text = cityOverView.newCcase
        
    }
}
