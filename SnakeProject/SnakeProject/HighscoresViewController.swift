//
//  HighscoresViewController.swift
//  SnakeProject
//
//  Created by Erik Sveningsson on 2019-11-15.
//  Copyright © 2019 Erik Sveningsson. All rights reserved.
//

import UIKit

let theApi = "https://api.myjson.com/bins/q4e78"

class HighscoresViewController: UITableViewController {
    final let url = URL(string: theApi)
    var highScoreData = [HighScoreData]()
    var name: String?
    var points: String?
    
    @IBOutlet var theTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadJson()
        updateHighScoreData()
    }
    
    // MARK: - downloadJson
    
    func downloadJson(){
        guard let downloadURL = url else {return}
        URLSession.shared.dataTask(with: downloadURL){data,urlResponse,error in
            guard let data = data, error==nil,urlResponse != nil else {
                print("something wrong")
                return
            }
            do
            {
                let decoder = JSONDecoder()
                let downloadedHighscore = try decoder.decode(HighScoreDict.self, from: data)
                self.highScoreData.append(contentsOf: downloadedHighscore.highScore)
                self.sendNewHighScoreDict()
                self.highScoreData = self.highScoreData.sorted(by: { $0.points > $1.points })
                DispatchQueue.main.async {
                    self.theTableView.reloadData()
                }
            } catch {
                print("Something wrong after download")
            }
        }.resume()
    }
    
    // MARK: - updateHighScoreData
    
    func updateHighScoreData(){
        if name != nil {
            if name != ""{
                let newUserData = [HighScoreData.init(name: self.name ?? "" , points: Int(self.points ?? "") ?? 0)]
                highScoreData.append(contentsOf: newUserData)
                print(highScoreData)
            }
        }
    }

    // MARK: - sendNewHighScoreDict
    
    func sendNewHighScoreDict(){
        guard let url = URL(string: theApi) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONEncoder().encode(HighScoreDict.init(highScore: self.highScoreData)) else {return}
        
        request.httpBody = httpBody

        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
        }.resume()
    }
    
    // MARK: - writing out the information in tableView
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if highScoreData.count > 10{
            return 10
        }
        else {
            return highScoreData.count
        }
     }
    
    override func tableView(_ tableView: UITableView,cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? HighScoreCell {
            
            cell.rankLabel.text = String(indexPath.row+1)+"."
            cell.nameLabel.text = highScoreData[indexPath.row].name
            cell.pointsLabel.text = String(highScoreData[indexPath.row].points)+"p"
            
            return cell
        }
        
        return UITableViewCell()
    }
    
}
   

   
  
    


