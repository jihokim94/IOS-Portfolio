//
//  ViewController.swift
//  MyAlbum
//
//  Created by 김지호 on 2022/03/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func didTapButton(_ sender: UIButton) {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary // 픽커 인터페이스에 디스플레이될 하면 설정 포토앨범에서 가져오게하기
        vc.allowsEditing = true// 유저가 editing 가능 여부 설정 true시 선택한 포트를 edit가능하게 해준다.
        vc.delegate = self
        
        self.present(vc, animated: true, completion: nil)
    }
    
    
}




extension ViewController : UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("pick")
        // 어떠한 일이 벌어지는지 확인해 보자.
        print("\(info)")
        /* //사진 피킹시 이러한 형태로 나오는 구만!!!
         [__C.UIImagePickerControllerInfoKey(_rawValue: UIImagePickerControllerCropRect): NSRect: {{0, 684}, {1169.9999999999993, 1170}}, __C.UIImagePickerControllerInfoKey(_rawValue: UIImagePickerControllerEditedImage): <UIImage:0x600003410900 anonymous {1167, 1168}>, __C.UIImagePickerControllerInfoKey(_rawValue: UIImagePickerControllerReferenceURL): assets-library://asset/asset.PNG?id=73E61587-DA09-44BA-A993-04655C71CEBE&ext=PNG, __C.UIImagePickerControllerInfoKey(_rawValue: UIImagePickerControllerMediaType): public.image, __C.UIImagePickerControllerInfoKey(_rawValue: UIImagePickerControllerImageURL): file:///Users/jihokim/Library/Developer/CoreSimulator/Devices/7EE60A24-1AD1-4BE2-8825-C89865759479/data/Containers/Data/Application/E70A319B-E497-4B75-A37A-87AEF2E602CC/tmp/32F82E43-536C-4CC9-B808-6B338832BAA6.png, __C.UIImagePickerControllerInfoKey(_rawValue: UIImagePickerControllerOriginalImage): <UIImage:0x600003419290 anonymous {1170, 2532}>]
         
         */
        
        // 그중에 우리는 user가 editing 가능하게 했으니~~
        //UIImagePickerControllerInfoKey(_rawValue: UIImagePickerControllerEditedImage): <UIImage:0x600003410900 anonymous {1167, 1168}> 요걸 쓰면 되겠군.
        //밑에거는 오리지날~
        //UIImagePickerControllerInfoKey(_rawValue: UIImagePickerControllerOriginalImage): <UIImage:0x600003419290 anonymous {1170, 2532}>
        
        if let editImage = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            imageView.image = editImage
            
        } else if let originalImage = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerOriginalImage")] as? UIImage {
            imageView.image = originalImage
        }
        
        // 픽커뷰 끄기
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    // canel 누를시 작동~~
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("cancel")
        // 픽커뷰 끄기
        picker.dismiss(animated: true, completion: nil)
    }
}
