import Foundation

enum DiaryWeatherItem: String, CaseIterable, Codable {
    case sunny
    case cloudy
    case rain
    case snow
    case wind
    case cold
    case hot
    
    var displayImoji: String {
        // ☀️⛅️🌧️🌨️💨❄️🔥
        switch self {
        case .sunny: return "☀️"
        case .cloudy: return "⛅️"
        case .rain: return "🌧️"
        case .snow: return "🌨️"
        case .wind: return "💨"
        case .cold: return "❄️"
        case .hot: return "🔥"
        }
    }
}

enum DiaryFeelingItem: CaseIterable, Codable {
    case happy
    case delight
    case excited
    case sad
    case moodiness
    case annoying
    case angry
    case soso
}

enum DiaryStateItem: Int, CaseIterable, Codable {
    case verygood = 5
    case good     = 4
    case soso     = 3
    case bad      = 2
    case verybad  = 1
    
    var displayStateImoji: String {
        switch self {
        case .verygood:
            return "😆"
        case .good:
            return "☺️"
        case .soso:
            return "🙂"
        case .bad:
            return "😠"
        case .verybad:
            return "🤬"
        }
    }
}

struct DiaryModel:Codable {
    var keyDate:Date
    
    func keyDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = .current
        
        return dateFormatter.string(from: keyDate)
    }
    // 마지막 수정 날짜
    var lastModifiedDate:Date?
    
    // 한줄 일기 및 일기 내용
    var title: String
    var contents: String?
    
    // 사용자 id 및 교환일기용 상대 id
    var userId:UUID?
    var partnerId:UUID?
    
    // 날씨
    var weather:DiaryWeatherItem?
    var feeling:DiaryFeelingItem?
    var state:DiaryStateItem?
}
