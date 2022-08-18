
import Foundation

struct SecondCategory: Codable {
    var dt_txt: String
    var main: Main
}

struct Main: Codable {
    var temp: Double
}
