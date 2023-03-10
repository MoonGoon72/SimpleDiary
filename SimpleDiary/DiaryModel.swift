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
        // βοΈβοΈπ§οΈπ¨οΈπ¨βοΈπ₯
        switch self {
        case .sunny: return "βοΈ"
        case .cloudy: return "βοΈ"
        case .rain: return "π§οΈ"
        case .snow: return "π¨οΈ"
        case .wind: return "π¨"
        case .cold: return "βοΈ"
        case .hot: return "π₯"
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
            return "π"
        case .good:
            return "βΊοΈ"
        case .soso:
            return "π"
        case .bad:
            return "π "
        case .verybad:
            return "π€¬"
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
    // λ§μ§λ§ μμ  λ μ§
    var lastModifiedDate:Date?
    
    // νμ€ μΌκΈ° λ° μΌκΈ° λ΄μ©
    var title: String
    var contents: String?
    
    // μ¬μ©μ id λ° κ΅νμΌκΈ°μ© μλ id
    var userId:UUID?
    var partnerId:UUID?
    
    // λ μ¨
    var weather:DiaryWeatherItem?
    var feeling:DiaryFeelingItem?
    var state:DiaryStateItem?
}
