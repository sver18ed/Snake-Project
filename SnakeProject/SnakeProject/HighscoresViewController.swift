//
//  HighscoresViewController.swift
//  SnakeProject
//
//  Created by Erik Sveningsson on 2019-11-15.
//  Copyright © 2019 Erik Sveningsson. All rights reserved.
//

import UIKit

class HighscoresViewController: UITableViewController {
    final let url = URL(string: "https://api.myjson.com/bins/1eiflu")
    var hs = [HighScoreData]()
    
    @IBOutlet var theTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadJson()
        //updateUserData()
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
                self.hs = downloadedHighscore.highScore
                DispatchQueue.main.async {
                    self.theTableView.reloadData()
                }
            } catch {
                print("Something wrong after downloaded")
            }
        }.resume()
    }
  
    override func numberOfSections(in tableView: UITableView) -> Int {
             return 1
        
    }

        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return hs.count
         }
        
        override func tableView(_ tableView: UITableView,cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? HighScoreCell {
                
                cell.nameLabel.text = hs[indexPath.row].name
                cell.pointsLabel.text = hs[indexPath.row].points
                return cell
            }
            
            return UITableViewCell()
        }

    
}
