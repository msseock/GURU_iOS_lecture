//
//  DriveFile.swift
//  GoogleAPI
//
//  Created by Dmitriy Petrov on 18/10/2019.
//  Copyright © 2019 BytePace. All rights reserved.
//

// for DriveViewController(거의 DriveViewController에서 많이 사용함)
import UIKit

struct FileResponse: Decodable {
    var kind: String
    var files: [File]
}

// 스프레드시트 전체
struct File: Decodable {
    var mimeType: String // 컨텐츠 타입
    var id: String // spreadsheetID
    var kind: String // The kind of reply
    var name: String // 시트 제목
    var modifiedTime: String // 변경된 시간
//    var thumbnailLink: Data
}
