
import Foundation

class AllCategorys{
    var dt_txt: String?
    var main: String?
    var temp: Double?
    var description: String?
    
    init(temp: Double, description: String, main: String, dt_txt: String){
        self.temp = temp
        self.description = description
        self.main = main
        self.dt_txt = dt_txt
    }
}
