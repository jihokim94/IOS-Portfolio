import UIKit

//MARK: - Concurrency 동시성
// 간단하게 말하면 앱이 한번에 여러개의 일을 할당받아서 일하게 한다~.

/*
 사용자 인터랙션 처리
 네트워킹
 백그라운드 파일 다운로드
 파일 저장하고 읽기
 
 
 이러한 것들을 처리하기위해선 GCD를 통한 쓰레드 처리를 해야한다!!
 그리고 이녀석은 Queue를 이용해서 관리된다.
 
 */
//Queue - Main , Global , Custom

//Main  : 보통 ui처리시 메인쓰레드 사용
DispatchQueue.main.async {
    let view = UIView()
    view.backgroundColor = .black
}
// Global : qos의 우선 순위에 따라 쓰레드 처리

DispatchQueue.global(qos: .userInteractive).async {
    // 지금 당장해야할일 핵중요한거~~
}
DispatchQueue.global(qos: .userInitiated).async {
    // 거의 바로 해줘야 할것들 , 예 : 사용자가 결과를 기다린다.
}
DispatchQueue.global(qos: .default).async {
    // 이건뭐 굳이?
}
DispatchQueue.global() // 위랑 똑같은거 default
DispatchQueue.global(qos: .utility).async {
    // 시간이 좀 걸리는일들
    //사용자가 당장 기다리지않는것들
    // 네트워킹 , 디스크에서 큰 파일 불러올때
}
DispatchQueue.global(qos: .background).async {
    //사용자 한테 당장 인식될 필요가 없는것들
    //뉴스 데이터 미리 받기 , 위치 업데이트 , 영상 다운받기
}

//Queue
let concurrent = DispatchQueue.init(label: "concurrent", qos: .background, attributes: .concurrent)
let serial = DispatchQueue.init(label: "serial", qos: .background)

//Sync , Async

//// Async 비동기
//DispatchQueue.global(qos: .background).async {
//    for i in 0...5 {
//        print("😈 \(i)")
//    }
//}
//
//
//DispatchQueue.global(qos: .userInteractive).async {
//    for i in 0...5 {
//        print("🦑 \(i)")
//    }
//}

//Sync 동기
DispatchQueue.global(qos: .background).sync {
    for i in 0...5 {
        print("😈 \(i)")
    }
} // 동기 뒤에는 끝나기 전까지 블락처리 되며 이후 작동

DispatchQueue.global(qos: .userInitiated).async {
    for i in 0...5 {
        print("🦑 \(i)")
    }
}

