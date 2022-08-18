
import UIKit

class ViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var tapButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
    }
    
    
    @IBAction func getTapButton(_ sender: UISearchBar) {
            searchBar.resignFirstResponder()
            
            var temperature: Double?
            var localName: String?
        
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(searchBar.text!)&appid=e8bbd8f5f7619142c9d029e8f07d00c8"
        let url = URL(string: urlString)!
           
        let task = URLSession.shared.dataTask(with: url) { (data, responce, error) in
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String : AnyObject]
                        
                    if let temp = json["main"] {
                        temperature = temp["temp"] as? Double
                    }
                    let localName = json["name"] as? String
               
                    DispatchQueue.main.async {
                        self.cityLabel.text = localName
                        self.temperatureLabel.text! = "\(temperature!)"
                    }
                }
                catch let jsonError {
                    print(jsonError)
                }
            }
            task.resume()
        }
    }


