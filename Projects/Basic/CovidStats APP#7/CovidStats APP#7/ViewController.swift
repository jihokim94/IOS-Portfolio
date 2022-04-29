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
                let cityList = self.makeCityOverViewList(covidOverView: data)
                self.configurePieChart(cityOverViewList : cityList)
            case let .failure(error) :
                print(error.localizedDescription)
            }
        })
    }
    private func makeCityOverViewList(covidOverView : CovidOverView) -> [CityOverView] {
        return [covidOverView.busan,covidOverView.daegu,covidOverView.daegu,covidOverView.ulsan,covidOverView.jeju,covidOverView.jeonbuk,covidOverView.jeonnam,covidOverView.chungbuk,covidOverView.chungnam,covidOverView.incheon,covidOverView.gangwon,covidOverView.gwangju,covidOverView.gyeongbuk,covidOverView.gyeongnam,covidOverView.sejong]
    }
    private func configureStackView(koreaCovidOverView : CityOverView){
        totalCaseLabel.text = "\(koreaCovidOverView.totalCase)명"
        newCaseLabel.text = "\(koreaCovidOverView.newCase)명"
    }
    private func configurePieChart(cityOverViewList : [CityOverView]) {
        let entries = cityOverViewList.compactMap { [weak self] overview -> PieChartDataEntry? in
            guard let self = self else {return nil}
            return PieChartDataEntry(value: self.numberFormmatter(str :overview.newCase), label: overview.countryName)
        }
        let dataSet = PieChartDataSet(entries: entries, label: "코로나 발생 현황")
        dataSet.sliceSpace = 1
        dataSet.entryLabelColor = .black
        dataSet.valueTextColor = .black
        dataSet.xValuePosition = .outsideSlice
        dataSet.valueLinePart1Length = 0.25
        dataSet.valueLinePart2Length = 0.35
        dataSet.colors = ChartColorTemplates.vordiplom()
            + ChartColorTemplates.joyful()
            + ChartColorTemplates.colorful()
            + ChartColorTemplates.liberty()
            + ChartColorTemplates.pastel()
            + ChartColorTemplates.material()
        self.pieChart.data = PieChartData(dataSet: dataSet)
    }
    private func numberFormmatter(str : String) -> Double {
        let f = NumberFormatter()
        f.numberStyle = .decimal
        return f.number(from: str)?.doubleValue ?? 0
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

