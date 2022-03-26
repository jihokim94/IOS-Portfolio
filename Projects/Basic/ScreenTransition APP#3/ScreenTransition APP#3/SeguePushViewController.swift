//
//  SeguePushViewController.swift
//  ScreenTransition APP#3
//
//  Created by 김지호 on 2022/03/24.
//

import UIKit

class SeguePushViewController: UIViewController {

    @IBOutlet weak var segueLabel: UILabel!
    var segueData : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("\(#function) , SeguePushViewController 뷰가 로드 되었다.")
        if let segueData = self.segueData {
            self.segueLabel.text = segueData
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("\(#function) ,SeguePushViewController 뷰가 나타날 것이다.")
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("\(#function) ,SeguePushViewController 뷰가 나타났다.")
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("\(#function) ,SeguePushViewController 뷰가 사라질 것이다.")
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("\(#function) ,SeguePushViewController 뷰가 사라졌다.")
    }
    
    @IBAction func tapBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
