//
//  SpreadsheetViewModel.swift
//  GoogleAPI
//
//  Created by Dmitriy Petrov on 18/10/2019.
//  Copyright © 2019 BytePace. All rights reserved.
//
// 최종수정일 2021.07.28

import UIKit

class SpreadsheetViewModel {
    var fileName: String
    var driveFile: File
    var sheet: ValueRange?
    var propertySheets: [Sheet]?
    
    
    private var spreadsheetID: String
    
//    // for testing
//    private let mocker = Mocker()
//    private let testingID = "1ZWeF4vF5IV3OILoR9MaHihvJfhluRsTiuozi8eI2acM"
    
    init(withSpreadsheetFile file: File) {
        self.fileName = file.name
        self.driveFile = file
        self.spreadsheetID = file.id
    }
    
    // MARK: getSpreadsheetValues
    func getSpreadsheetValues(withID id: String,
                        withToken token: String,
                        completion: @escaping (ValueRange?) -> Void) {
        // 요청할 내용대로 url에 담도록 batchGetStringURL() 호출
        guard let url = URL(string: getStringURLForBatchGet(fromID: id, withToken: token)) else { return }
        print("batchGet url: ", url)
        
        // 생성해둔 url, get 방식으로 URLRequest 생성
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        
        URLSession.shared.dataTask(with: request) { data, _, _ in
            guard let jsonData = data else { return }
            
            let decoder = JSONDecoder()
            guard let spreadsheet = try? decoder.decode(Spreadsheet.self, from: jsonData) else { return }
            
            completion(spreadsheet.valueRanges.first)
        }
        .resume()
    }
    
    // MARK: getSpreadsheetProperties
    func getSpreadsheetProperties(withID id: String,
                        withToken token: String,
                        completion: @escaping ([Sheet]?) -> Void) {
        // 요청할 내용대로 url에 담도록 getStringURLForGet() 호출
        guard let url = URL(string: getStringURLForGet(fromID: id, withToken: token)) else { return }
        print("property get url: ", url)
        
        // 생성해둔 url, get 방식으로 URLRequest 생성
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        print("request header: ", request.allHTTPHeaderFields!)
        
        // 만들어둔 request로 http요청 보냄
        URLSession.shared.dataTask(with: request) { data, response, error in
            // request로 받아온 JSON 데이터
            if let JSONData = data {
                do {
                    let spreadsheetProperties = try JSONDecoder().decode(GetProperties.self, from: JSONData)
                    completion(spreadsheetProperties.sheets) // GetProperties 중 [Sheet]으로 completion
                    print("decoding 성공")
                } catch let jsonError as NSError {
                    print("JSON decode failed: \(jsonError.localizedDescription)")
                }
                return
            }
        }
        .resume()
    }
    
    // MARK: postNewRow
    func postNewRow(withID id: String,
                    withToken token: String,
                    completion: @escaping (URLResponse) -> Void) {
        getParameters(withID: id, withToken: token) { parameters in
            guard let url = URL(string: self.getStringURLForPOST(fromID: id, withToken: token)) else { return }
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = parameters
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            URLSession.shared.dataTask(with: request) { _, response, _ in
                guard let response = response else { return }
                
                completion(response)
            }
            .resume()
        }
    }
}

extension SpreadsheetViewModel {
    // MARK: getParameters
    private func getParameters(withID id: String,
                               withToken token: String,
                               completion: @escaping (Data) -> Void) {
        getRange(withID: id, withToken: token) { range in
            
            // 정식 소스
            if let sheet = self.sheet {
                let postData = POSTData(range: range, values: sheet.values)
                print("POST 요청문 HTTP body: ", postData.values) // test용 출력문
                let postRequest = POSTRequest(data: [postData])

                let encoder = JSONEncoder()
                guard let data = try? encoder.encode(postRequest) else {
                    return
                }

                completion(data)
            }
        }
    }
    
    // MARK: getRange
    private func getRange(withID id: String,
                          withToken token: String,
                          completion: @escaping (String) -> Void) {
        getSpreadsheetValues(withID: id, withToken: token) { sheet in
            guard let rows = sheet?.values.count else { return }
            guard let columns = sheet?.values[0].count else { return }
            
            let range = String("R1C1:R\(rows)C\(columns)")
            
            completion(range)
        }
    }
    
    // MARK: getStringURLForBatchGet
    // batchGet(values만 받는 용도로 씀)
    private func getStringURLForBatchGet(fromID id: String, withToken token: String) -> String {
        var url = "https://sheets.googleapis.com/v4/spreadsheets/"
//        print("이것도 야매지만 아무튼 property: ", property)
        
        if let sheets = propertySheets {
            print("title 잘 나왔는지 확인해봐: ", sheets[0].properties?.title)
//            url += id + "/values:batchGet/" + "?access_token=" + token + "&ranges=" + sheets.title + "&majorDimension=ROWS"
        } else {
            print("property가 없다네. 왜 없을까. 니가 코드를 잘못 짰겠지")
            url += id + "/values:batchGet/" + "?access_token=" + token + "&ranges=A1:N&majorDimension=ROWS" // A1:C => A1:끝값 범위가 충분히 넓으면 다 뜸
        }
        
        return url
    }
    
    // MARK: getStringURLForGet
    // get(시트 property 받는 용도)
    private func getStringURLForGet(fromID id: String, withToken token: String) -> String {
        var url = "https://sheets.googleapis.com/v4/spreadsheets/"
        url += id
        return url
    }
    
    // MARK: getStringURLForPOST
    // post, batchUpdate 형식
    private func getStringURLForPOST(fromID id: String, withToken token: String) -> String {
        var url = "https://sheets.googleapis.com/v4/spreadsheets/"
        url += id + "/values:batchUpdate/?access_token=" + token
        return url
    }
}
