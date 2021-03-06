//
//  ViewController.swift
//  ScreenTransition APP#3
//
//  Created by ๊น์งํธ on 2022/03/24.
//

import UIKit

class ViewController: UIViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? SeguePushViewController {
            let data = "jiho ๐ถ"
            vc.segueData = data
        }
        print(#function)
    }
    
    
    
    @IBOutlet weak var mainLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("\(#function) ,ViewController ๋ทฐ๊ฐ ๋ก๋ ๋์๋ค.")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("\(#function) ,ViewController ๋ทฐ๊ฐ ๋ํ๋  ๊ฒ์ด๋ค.")
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("\(#function) ,ViewController ๋ทฐ๊ฐ ๋ํ๋ฌ๋ค.")
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("\(#function) ,ViewController ๋ทฐ๊ฐ ์ฌ๋ผ์ง ๊ฒ์ด๋ค.")
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("\(#function) ,ViewController ๋ทฐ๊ฐ ์ฌ๋ผ์ก๋ค.")
    }
    
    @IBAction func tapCodePushButton(_ sender: UIButton) {
        guard let vc = self.storyboard?.instantiateViewController(identifier: "CodeViewController") as? CodePushViewController else { return }
        let data = "์งํธ๐"
        vc.data = data
        
        // ViewController๊ฐ delegate ์์ํจ
        vc.delegate = self
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    @IBAction func tapCodePresentButton(_ sender: UIButton) {
        
        guard let vc = self.storyboard?.instantiateViewController(identifier: "CodePresentViewController") as? CodePresentViewController else {return}
        let data = "์งํธ๐"
        vc.data = data
        vc.modalPresentationStyle = .fullScreen // ํ์คํฌ๋ฆฐ ํํ๋ก Present
        self.present(vc, animated: true, completion: nil)
    }
}


// delegate ์ฑํ ํ ์ ์
extension ViewController : SendingDataDelegate {
    func sendData(data: String) {
        self.mainLabel.text = data
        self.mainLabel.sizeToFit()
    }
}
