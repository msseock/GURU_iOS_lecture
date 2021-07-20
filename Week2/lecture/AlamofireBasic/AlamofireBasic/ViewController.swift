//
//  ViewController.swift
//  AlamofireBasic
//
//  Created by swuad_21 on 2021/07/15.
//

import UIKit
import Alamofire
import AlamofireImage


class ViewController: UIViewController {
    
    var person_data = [PersonInfo]()

    @IBOutlet weak var personCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getData()
    }
    
    func getData() {
        print("start loading")
        let headers: HTTPHeaders = [
            "app-id": "60efd91549dfc07aec023a46"
        ] // header 정보 전달

        // request 요청
        AF.request("https://dummyapi.io/data/api/user?limit=10", headers: headers).responseJSON { response in
            switch response.result {
            case .success(let data):
                print(data)
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                    let decoder = JSONDecoder() // 디코더 생성
                    let dummy_data = try decoder.decode(DummyData.self, from: jsonData) // 디코딩
                    self.person_data = dummy_data.data
                    self.personCollectionView.reloadData()
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

extension ViewController:UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return person_data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "personCell", for: indexPath) as! PersonCell
        
        let data = person_data[indexPath.row]

        if let url = data.picture {
        cell.profileImage.af.setImage(withURL: url)
        }
        cell.idLabel.text = data.id
        cell.nameLabel.text = data.firstName
        cell.emailLabel.text = data.email
        
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 0.5
        cell.layer.cornerRadius = 7
        return cell
    }
}

extension ViewController:UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.view.frame.size.width - 20) / 3
        let height = width * 1.6
        return CGSize(width: width, height: height)
    }
}

extension ViewController:UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        print(person_data[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = self.personCollectionView.indexPathsForSelectedItems?.first {
            let person_info = person_data[indexPath.row]
            print(person_info)
            
        }
    }
}
