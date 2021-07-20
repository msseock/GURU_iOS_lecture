//
//  WebtoonCell.swift
//  NaverWebtoonExample
//
//  Created by swuad_31 on 2021/07/14.
//

import UIKit

// 어떤 클래스를 상속받는다라는 것은 이미 구현되어 있는 기능을 가져다 쓰겠다.
// 그 중에 일부만 커스터마이징을 해서 사용하겠다
class WebtoonCell:UICollectionViewCell {
    
    @IBOutlet weak var titleImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
}
