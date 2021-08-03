 // This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let getProperties = try? newJSONDecoder().decode(GetProperties.self, from: jsonData)

import Foundation

// MARK: - GetProperties
struct GetProperties: Codable {
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
struct GetPropertiesProperties: Codable {
    let title, locale, autoRecalc, timeZone: String
    let defaultFormat: Format
    let spreadsheetTheme: SpreadsheetTheme
}

// MARK: - Format
struct Format: Codable {
    let backgroundColor: BackgroundColorClass
    let padding: Padding
    let verticalAlignment: VerticalAlignment
    let wrapStrategy: WrapStrategy
    let textFormat: TextFormat
    let backgroundColorStyle: BackgroundColorStyle
    let horizontalAlignment: HorizontalAlignment?
    let hyperlinkDisplayType: HyperlinkDisplayType?
}

// MARK: - BackgroundColorClass
struct BackgroundColorClass: Codable {
    let red, green, blue: Double?
}

// MARK: - BackgroundColorStyle
struct BackgroundColorStyle: Codable {
    let rgbColor: BackgroundColorClass
}

enum HorizontalAlignment: String, Codable {
    case horizontalAlignmentLEFT = "LEFT"
}

enum HyperlinkDisplayType: String, Codable {
    case plainText = "PLAIN_TEXT"
}

// MARK: - Padding
struct Padding: Codable {
    let top, paddingRight, bottom, paddingLeft: Int

    enum CodingKeys: String, CodingKey {
        case top
        case paddingRight
        case bottom
        case paddingLeft
    }
}

// MARK: - TextFormat
struct TextFormat: Codable {
    let foregroundColor: ForegroundColorClass
    let fontFamily: FontFamily
    let fontSize: Int
    let bold, italic, strikethrough, underline: Bool
    let foregroundColorStyle: ForegroundColorStyle
}

enum FontFamily: String, Codable {
    case arial = "Arial"
    case arialSansSansSerif = "arial,sans,sans-serif"
}

// MARK: - ForegroundColorClass
struct ForegroundColorClass: Codable {
}

// MARK: - ForegroundColorStyle
struct ForegroundColorStyle: Codable {
    let rgbColor: ForegroundColorClass
}

enum VerticalAlignment: String, Codable {
    case bottom = "BOTTOM"
}

enum WrapStrategy: String, Codable {
    case overflowCell = "OVERFLOW_CELL"
}

// MARK: - SpreadsheetTheme
struct SpreadsheetTheme: Codable {
    let primaryFontFamily: FontFamily
    let themeColors: [ThemeColor]
}

// MARK: - ThemeColor
struct ThemeColor: Codable {
    let colorType: String
    let color: BackgroundColorStyle
}

// MARK: - Sheet
struct Sheet: Codable {
    let properties: SheetProperties
    let data: [Datum]
}

// MARK: - Datum
struct Datum: Codable {
    let rowData: [RowDatum]
    let rowMetadata, columnMetadata: [Metadatum]
}

// MARK: - Metadatum
struct Metadatum: Codable {
    let pixelSize: Int
}

// MARK: - RowDatum
struct RowDatum: Codable {
    let values: [Value]
}

// MARK: - Value
struct Value: Codable {
    let userEnteredValue, effectiveValue: EffectiveValueClass?
    let formattedValue: String?
    let effectiveFormat: Format
    let userEnteredFormat: UserEnteredFormat?
}

// MARK: - EffectiveValueClass
struct EffectiveValueClass: Codable {
    let stringValue: String
}

// MARK: - UserEnteredFormat
struct UserEnteredFormat: Codable {
    let horizontalAlignment: HorizontalAlignment
}

// MARK: - SheetProperties
struct SheetProperties: Codable {
    let sheetID: Int
    let title: String
    let index: Int
    let sheetType: String
    let gridProperties: GridProperties

    enum CodingKeys: String, CodingKey {
        case sheetID
        case title, index, sheetType, gridProperties
    }
}

// MARK: - GridProperties
struct GridProperties: Codable {
    let rowCount, columnCount: Int
}
