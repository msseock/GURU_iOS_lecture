//
//  DetailController.swift
//  AlamofireBasic
//
//  Created by swuad_21 on 2021/07/16.
//

import UIKit
import Alamofire
import AlamofireImage

class DetailController:UIViewController {
    var user_id:String!
    override func viewDidLoad() {
        super.viewDidLoad()
        getData(user_id)
    }
    
    func getData(_ user_id:String) {
        print("start loading")
        let headers: HTTPHeaders = [
            "app-id": "60efd91549dfc07aec023a46"
        ] // header 정보 전달

        // request 요청
        AF.request("https://dummyapi.io/data/api/user/\(user_id)", headers: headers).responseJSON { response in
            switch response.result {
            case .success(let data):
                print(data)
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                    print(data)
//                    let decoder = JSONDecoder() // 디코더 생성
//                    let dummy_data = try decoder.decode(DummyData.self, from: jsonData) // 디코딩
                    
                    print("finish parsing")
                } catch {
                    debugPrint(error)
                }
                
            case .failure(let data):
                print("fail")
            }
        }
        print("finish loading")
    }
}
