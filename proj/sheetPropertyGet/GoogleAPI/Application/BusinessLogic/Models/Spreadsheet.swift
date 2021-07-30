//
//  Spreadsheet.swift
//  GoogleAPI
//
//  Created by Dmitriy Petrov on 18/10/2019.
//  Copyright © 2019 BytePace. All rights reserved.
//

// batchGet으로 시트 내 데이터들(values)을 읽어오기 위한 코드

// batchGet으로 읽어온 response body를 docode하기 위한 struct
struct Spreadsheet: Decodable {
    var spreadsheetId: String
    var valueRanges: [ValueRange]
}

// spreadsheets.valueRange
struct ValueRange: Decodable {
    var range: String // A1 notation으로 나오는 범위
    var majorDimension: String // ROWS || COLUMNS
    var values: [[String]] // 시트 내 데이터
}
