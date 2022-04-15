import UIKit


//MARK: - URLSession
//IOS에서 네트워킹 하기 위해선 사용해야하는 녀석!!!!!

struct Response : Codable {
    let resultCount : Int
    let tracks : [Track]
    
    enum CodingKeys : String , CodingKey {
        case resultCount
        case tracks = "results"
    }
}
struct Track : Codable {
    let title : String
    let artistName : String
    let thumbnailPath : String
    
    enum CodingKeys : String , CodingKey {
        case title = "trackName"
        case artistName
        case thumbnailPath = "artworkUrl30"
    }
}

var urlComponents = URLComponents(string: "https://itunes.apple.com/search?")!

let mediaQuery = URLQueryItem(name: "t", value: "music")
let entityQuery = URLQueryItem(name: "entity", value: "song")
let termQuery = URLQueryItem(name: "term", value: "지드래곤")

urlComponents.queryItems?.append(mediaQuery)
urlComponents.queryItems?.append(entityQuery)
urlComponents.queryItems?.append(termQuery)

let requestURL = urlComponents.url!


let config = URLSessionConfiguration.default
let session = URLSession(configuration: config)
let dataTask = session.dataTask(with: requestURL) { data, response, error in
    guard error == nil else { return }
    guard let statusCode = (response as? HTTPURLResponse)?.statusCode else { return }
    let successRange = 200..<300
    guard successRange.contains(statusCode) else { return }
    guard let resultData = data else { return }
    
//    let strResultData = String(data: resultData, encoding: .utf8)
//    print(strResultData)
    
    // 목표 : 우리가원하는 데이터를 트랙리스트 오브젝트 뽑기
    // Data -> Track 우리가 원하는 오브젝트 형태로 가져오고싶다!
    // Track 오브젝트를 만들자
    // Data를 struct 형태로 파싱해야한다. Codable을 사용해서 하면 되지룽
    
    do {
        let decoder = JSONDecoder()
        let data = try decoder.decode(Response.self, from: resultData)
        let tracks = data.tracks
        dump(tracks)
        print(tracks.count)
    } catch let error {
        print(error.localizedDescription)
    }
    
     
}
// 태스크를 리쥼하면 실제 네트워킹 실행된다~
dataTask.resume()
    
   
    





