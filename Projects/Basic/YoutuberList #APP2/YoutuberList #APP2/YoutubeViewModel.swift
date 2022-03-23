//
//  YoutubeViewModel.swift
//  YoutuberList #APP2
//
//  Created by 김지호 on 2022/03/23.
//

import Foundation
import UIKit

class YoutuberListViewModel {
     let list = [Youtuber(imagePath: URL(string: "https://ww.namu.la/s/cc84b0ccee586e7c86c13a9351ae95907e4ccd25d57dadeee91f69257b9483c482f1da019e16530efbb2c3f58652e9083b39302db4201d0027f52d14c26b31b973d6cc06a33f93acdfdfe482c29d004e3063796a772cb7c323afab946564ba77")!, chanelName: "T-Series", numberOfSubs: "구독자 2.03억") ,
                Youtuber(imagePath: URL(string: "https://ww.namu.la/s/ab485cd428b50b96b14969f8df7a3d525f9199d37999fecac4993ec712b4dd0ee179187a2fb64b82211b5ca7e4a458fe57557e8beda2bb2059a717ac324d0667126d7debb92fb2353e5c44d1531564267f607ad5dd188fa46465a724bb5254f811c977136bf370963965db4071b8dcd5")!, chanelName: "Cocomelon", numberOfSubs: "구독자 1.32억") ,
                Youtuber(imagePath: URL(string: "https://yt3.ggpht.com/ytc/AKedOLTRpFl9QM_NJEPXePeARLsgedgqXujizE0dqoEovA=s176-c-k-c0x00ffffff-no-rj")!, chanelName: "SET India", numberOfSubs: "구독자 1.29억명") ,
                Youtuber(imagePath: URL(string: "https://yt3.ggpht.com/5oUY3tashyxfqsjO5SGhjT4dus8FkN9CsAHwXWISFrdPYii1FudD4ICtLfuCw6-THJsJbgoY=s176-c-k-c0x00ffffff-no-rj")!, chanelName: "PewDiePie", numberOfSubs: "구독자 1.11억명") ,
                Youtuber(imagePath: URL(string: "https://w.namu.la/s/43f5e6059d1a14847d0526b03af352a87df019941ba522ac0f4b8ef0ebc315ff32dbfda4105e5a05217474172cfa006c4e572b27835ee18edefa2e6f478556b46bb9aab66e44757004b4122bcb763782997ce326162a303a9bb96e2bd0262ff2")!, chanelName: "MrBeast", numberOfSubs: "구독자 9040만") ,
                Youtuber(imagePath: URL(string:  "https://w.namu.la/s/8e21b015dd483e2cef23517fe12473f4bbccafcb449ff88b139f79ecea063cc9d6bbedc1fb2dc82f5b79ef3bc9165c27006854041d907a06cf8d88970f83d4f43f736d76b9d59a790047e803b31d603d1ccdd5a8784e5da1afefc477dd376541")!, chanelName: "Kids Diana Show", numberOfSubs: "구독자 8120만명") ,
                Youtuber(imagePath: URL(string: "https://w.namu.la/s/b35a01b7a065d6b6ba3b00d69f4f7f92d0d4529990d9648217f58cd89db9078be7eb13dc4b0fff00e107137eae97a300bc1f2985463cb16d5dc11c76eb1cfe0e1f2c48c31cf17dfa024a380d37a273a36580a786d968077745da70947d6cc540")!, chanelName: "Like Nastya", numberOfSubs: "구독자 6540만") ,
                Youtuber(imagePath: URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/d/df/WWE_white_logo.svg/1200px-WWE_white_logo.svg.png")!, chanelName: "WWE", numberOfSubs: "구독자 6320만") ,
                Youtuber(imagePath: URL(string:  "https://yt3.ggpht.com/ytc/AKedOLQqRcxPdBWjWCN8FJYzl4FSrh4hHanWNy8pqwGW_w=s176-c-k-c0x00ffffff-no-rj")!, chanelName: "Zee Music Company", numberOfSubs: "구독자 5740만") ]
    
    
    
    
    
    var numberOfYoutuber : Int {
        return list.count
    }
    
    func fetchYoutuberList () -> [Youtuber] {
        return list
    }
    
    func getYoutuberByIndex (at index : IndexPath) -> Youtuber {
        return list[index.item]
    }
    
}
