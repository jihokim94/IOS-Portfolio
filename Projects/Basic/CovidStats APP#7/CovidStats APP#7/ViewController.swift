//
//  ViewController.swift
//  CovidStats APP#7
//
//  Created by 김지호 on 2022/04/28.
//

import Alamofire
import Charts
import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var totalCaseLabel: UILabel!
    @IBOutlet weak var newCaseLabel: UILabel!
    @IBOutlet weak var pieChart: PieChartView!
    
    
    //    var covidOverView : CovidOverView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCovidOverView (completionHandler: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(data) :
                self.configureStackView(koreaCovidOverView: data.korea)
                self.configurePieChart()
            case let .failure(error) :
                print(error.localizedDescription)
            }
        })
    }
    
    private func configureStackView(koreaCovidOverView : CityOverView){
        totalCaseLabel.text = "\(koreaCovidOverView.totalCase)명"
        newCaseLabel.text = "\(koreaCovidOverView.newCase)명"
    }
    private func configurePieChart() {
        
    }
    
    private func fetchCovidOverView(completionHandler : @escaping (Result<CovidOverView , Error>) -> ()) {
        let url = URL(string: "https://api.corona-19.kr/korea/country/new/")!
        let param = ["serviceKey" : APIKey.key]
        
        AF.request(url, method: .get , parameters: param).responseData { response in
                    switch response.result {
                    case let .success(data) :
                        do {
                            let decoder = JSONDecoder()
                            let covidOverView = try decoder.decode(CovidOverView.self, from: data)
                            completionHandler(.success(covidOverView))
                        } catch let error {
                            completionHandler(.failure(error))
                        }
                    case let .failure(error) :
                        completionHandler(.failure(error))
                    }
                   }
    }
    
}

