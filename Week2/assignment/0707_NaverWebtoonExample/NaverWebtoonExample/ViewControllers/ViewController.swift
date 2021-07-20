//
//  ViewController.swift
//  NaverWebtoonExample
//
//  Created by swuad_31 on 2021/07/14.
//

import UIKit

class ViewController: UIViewController {
    var titleImages = ["title_01", "title_02", "title_03", "title_04", "title_05", "title_06", "title_07", "title_08", "title_09", "title_10"]
    
    var webtoonData = [
        WebtoonData("독립일기", "title_01", 9.97, "자까"),
        WebtoonData("모죠의 일지", "title_02", 9.97, "모죠"),
        WebtoonData("숲속의 담", "title_03", 9.98, "다홍"),
        WebtoonData("대신 심부름을 해다오", "title_04", 9.98, "고아라"),
        WebtoonData("아홉수 우리들", "title_05", 9.98, "수박양"),
        WebtoonData("겟백", "title_06", 9.98, "세윤"),
        WebtoonData("세기말 풋사과 보습학원", "title_07", 9.98, "순끼"),
        WebtoonData("집이 없어", "title_08", 9.98, "와난"),
        WebtoonData("마음의 숙제", "title_09", 9.98, "고아라"),
        WebtoonData("엔딩 후 서브남을 주웠다", "title_10", 9.98, "황도톨, 정서 / 정서")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titleImages.count * 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "webtoonCell", for: indexPath) as! WebtoonCell
        // Todo: Title, 별점, 작가 명 채우기
        let data = webtoonData[indexPath.row % 10]
        cell.titleLabel.text = data.title
        cell.ratingLabel.text = "\(data.rating!)"
        cell.authorLabel.text = data.author
        // 타이틀 이미지 변경
        cell.titleImage.image = UIImage(named: data.title_image)
        
        cell.layer.borderWidth = 0.3
        cell.layer.borderColor = UIColor.lightGray.cgColor
        return cell
    }
}

extension ViewController:UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width = self.view.frame.size.width / 3
        let width = UIScreen.main.bounds.width / 3
        let height = width * 1.6
        return CGSize(width: width, height: height)
    }
}
