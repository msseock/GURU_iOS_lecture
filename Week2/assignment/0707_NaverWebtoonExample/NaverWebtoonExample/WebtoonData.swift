//
//  WebtoonData.swift
//  NaverWebtoonExample
//
//  Created by swuad_31 on 2021/07/14.
//

struct WebtoonData {
    var title_image:String!
    var title:String!
    var rating:Float!
    var author:String!
    
    init(_ title:String, _ title_image:String, _ rating:Float, _ author:String) {
        self.title = title
        self.title_image = title_image
        self.rating = rating
        self.author = author
    }
}

