//
//  HighscoresViewController.swift
//  SnakeProject
//
//  Created by Erik Sveningsson on 2019-11-15.
//  Copyright © 2019 Erik Sveningsson. All rights reserved.
//

import UIKit

let theApi = "https://api.myjson.com/bins/1at7dy"

class HighscoresViewController: UITableViewController {
    final let url = URL(string: theApi)
    var highScore = [HighScoreData]()
    var setName: String?
    var setPoints: String?
    
    @IBOutlet var theTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadJson()
        updateUserData()
    }
    
    func downloadJson(){
        guard let downloadURL = url else {return}
        URLSession.shared.dataTask(with: downloadURL){data,urlResponse,error in
            guard let data = data, error==nil,urlResponse != nil else {
                print("something is wrong")
                return
            }
            do
            {
                let decoder = JSONDecoder()
                let downloadedHighscore = try decoder.decode(HighScores.self, from: data)
                self.highScore.append(contentsOf: downloadedHighscore.highScore)
                self.sendData()
                self.highScore = self.highScore.sorted(by: { $0.points > $1.points })
                DispatchQueue.main.async {
                    self.theTableView.reloadData()
                }
            } catch {
                print("Something wrong after downloaded")
            }
        }.resume()
    }
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return highScore.count
         }
        
        override func tableView(_ tableView: UITableView,cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? HighScoreCell {
                
                cell.nameLabel.text = highScore[indexPath.row].name
                cell.pointsLabel.text = String(highScore[indexPath.row].points)
                
                return cell
            }
            
            return UITableViewCell()
        }
    
    func updateUserData(){
        let newUserData = [HighScoreData.init(name: self.setName ?? "" , points: Int(self.setPoints ?? "") ?? 0)]
        highScore.append(contentsOf: newUserData)
    
    }

    func sendData(){
        guard let url = URL(string: theApi) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONEncoder().encode(HighScores.init(highScore: self.highScore)) else {return}
        
        request.httpBody = httpBody

        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
        }.resume()
    }

    
        
}
   

   
  
    


