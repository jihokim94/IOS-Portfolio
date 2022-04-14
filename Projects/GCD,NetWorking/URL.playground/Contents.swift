import UIKit

//MARK: - Networking with IOS


let urlString = "https://itunes.apple.com/search?media=music&entity=song&term=Gdragon"

let url = URL(string: urlString)

url?.absoluteString
url?.scheme
url?.host
url?.query
url?.path
url?.baseURL

let baseURL = URL(string: "https://itunes.apple.com")
let relativeURL = URL(string:"search?media=music&entity=song&term=Gdragon" , relativeTo: baseURL)

relativeURL?.absoluteString
relativeURL?.scheme
relativeURL?.host
relativeURL?.query
relativeURL?.path
relativeURL?.baseURL

// 추가 하거나 접근 할때 더 변한 녀석이 있는데 바로 아래와 같다 url을 한번더 추상화 시킨걸로 보면된다.
//MARK: - URLComponents

var urlComponents = URLComponents(string: "https://itunes.apple.com/search?")

let mediaQuery = URLQueryItem(name: "media", value: "music")
let entityQuery = URLQueryItem(name: "entity", value: "song")
let termQuery = URLQueryItem(name: "term", value: "지드래곤")

urlComponents?.queryItems?.append(mediaQuery)
urlComponents?.queryItems?.append(entityQuery)
urlComponents?.queryItems?.append(termQuery)

urlComponents?.url?.scheme
urlComponents?.url?.query

urlComponents?.string // 한국어는 퍼센트 인코딩되어서 넘어가네? 영어는 상관없는데
urlComponents?.host
urlComponents?.queryItems



