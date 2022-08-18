import Foundation

struct Category: Codable {
    var main: Mains
    var dt_txt: String
}
struct Mains: Codable {
    var temp: Double
}
