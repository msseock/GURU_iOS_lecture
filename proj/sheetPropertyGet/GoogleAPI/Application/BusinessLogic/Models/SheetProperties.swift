//
//  SheetProperties.swift
//  GoogleAPI
//
//  Created by 석민솔 on 2021/07/28.
//  Copyright © 2021 BytePace. All rights reserved.
//

// get으로 spreadsheet 내 sheet properties를 읽어오기 위한 코드


// MARK: - GetProperties
struct GetProperties: Decodable {
    let spreadsheetID: String
    let properties: GetPropertiesProperties
    let sheets: [Sheet]
    let spreadsheetURL: String

    enum CodingKeys: String, CodingKey {
        case spreadsheetID
        case properties, sheets
        case spreadsheetURL
    }
}

// MARK: - GetPropertiesProperties
struct GetPropertiesProperties: Decodable {
    let title, locale, autoRecalc, timeZone: String
    let defaultFormat: DefaultFormat
    let spreadsheetTheme: SpreadsheetTheme
}

// MARK: - DefaultFormat
struct DefaultFormat: Decodable {
    let backgroundColor: BackgroundColorClass
    let padding: Padding
    let verticalAlignment, wrapStrategy: String
    let textFormat: TextFormat
    let backgroundColorStyle: BackgroundColorStyle
}

// MARK: - BackgroundColorClass
struct BackgroundColorClass: Decodable {
    let red, green, blue: Double?
}

// MARK: - BackgroundColorStyle
struct BackgroundColorStyle: Decodable {
    let rgbColor: BackgroundColorClass
}

// MARK: - Padding
struct Padding: Decodable {
    let top, paddingRight, bottom, paddingLeft: Int

    enum CodingKeys: String, CodingKey {
        case top
        case paddingRight
        case bottom
        case paddingLeft
    }
}

// MARK: - TextFormat
struct TextFormat: Decodable {
    let foregroundColor: ForegroundColorClass
    let fontFamily: String
    let fontSize: Int
    let bold, italic, strikethrough, underline: Bool
    let foregroundColorStyle: ForegroundColorStyle
}

// MARK: - ForegroundColorClass
struct ForegroundColorClass: Decodable {
}

// MARK: - ForegroundColorStyle
struct ForegroundColorStyle: Decodable {
    let rgbColor: ForegroundColorClass
}

// MARK: - SpreadsheetTheme
struct SpreadsheetTheme: Decodable {
    let primaryFontFamily: String
    let themeColors: [ThemeColor]
}

// MARK: - ThemeColor
struct ThemeColor: Decodable {
    let colorType: String
    let color: BackgroundColorStyle
}

// MARK: - Sheet
struct Sheet: Decodable {
    let properties: SheetProperties
}

// MARK: - SheetProperties
struct SheetProperties: Decodable {
    let sheetID: Int
    let title: String // 받아올 값
    let index: Int
    let sheetType: String
    let gridProperties: GridProperties

    enum CodingKeys: String, CodingKey {
        case sheetID
        case title, index, sheetType, gridProperties
    }
}

// MARK: - GridProperties
struct GridProperties: Decodable {
    let rowCount, columnCount: Int
}
