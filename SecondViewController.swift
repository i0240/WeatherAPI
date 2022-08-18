//
//  SecondViewController.swift
//  Weather API
//
//  Created by MyMac on 2/12/22.
//

import UIKit

class SecondViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate {
    
   
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tapButton: UIButton!
    
    var sCategory = [AllCategorys]()

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sCategory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as? CategoryCell {
            let wFA = sCategory[indexPath.row]
//            let weatherData = AllCategorys()
            cell.cityLabel?.text = "\(searchBar.text!)"
            cell.dateLabel?.text = wFA.dt_txt
            cell.temperatureLabel?.text = "\(wFA.temp!)"
            cell.descriptionLabel?.text = wFA.description
            return cell
        }
        return UITableViewCell()
    }
    
    @IBAction func getTapButton(_ sender: Any) {
        
        let urlString = "https://api.openweathermap.org/data/2.5/forecast?q=\(searchBar.text!)&mode=json&appid=0f2f1f757674f9b1d3c3ef8b32b7fbfd"
           
            let url = URL(string: urlString)
            let request = URLRequest(url: url!)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String: AnyObject]
            
//            guard let json = responce.value as? NSDictionary,

                let list = json["list"] as? NSArray

                            for i in list ?? [] {

                                guard let day = i as? NSDictionary,

                                let main = day["main"] as? NSDictionary,

                                let weather = day["weather"] as? NSArray,

                                let dt_txt = day["dt_txt"] as? String,

                                let temp = main["temp"] as? Double,

                                let weatherDir = weather[0] as? NSDictionary,

                                let description = weatherDir["description"] as? String,

                                let main1 = weatherDir["main"] as? String else {continue}

                                let weatherForArray = AllCategorys(temp: temp, description: description, main: main1, dt_txt: dt_txt)

                                self.sCategory.append(weatherForArray)
                            }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                    }
            catch let jsonError {
                print(jsonError)
            }
    }
        task.resume()
}
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    
    }
   
        override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
}
