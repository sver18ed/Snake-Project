//
//  HighscoresViewController.swift
//  SnakeProject
//
//  Created by Erik Sveningsson on 2019-11-15.
//  Copyright © 2019 Erik Sveningsson. All rights reserved.
//

import UIKit

let theApi = "https://api.myjson.com/bins/14ki1k"

class HighscoresViewController: UITableViewController {
    final let url = URL(string: theApi)
    var highScoreData = [HighScoreData]()
    var highScoreManager: HighScoreManager?
    
    
    @IBOutlet var theTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchJson()
    }
    
    func fetchJson(){
           HighScoreManager.fetchHighScore { (results:[HighScoreData]) in
              self.highScoreData = results
              DispatchQueue.main.async {
                  self.theTableView.reloadData()
              }
           }
       }
    
    // MARK: - writing out the information in tableView
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if DataHandler.instance.highScoreData.count > 10{
            return 10
        }
        else {
            return DataHandler.instance.highScoreData.count
        }
     }
    
    override func tableView(_ tableView: UITableView,cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? HighScoreCell {
            
            cell.rankLabel.text = String(indexPath.row+1)+"."
            cell.nameLabel.text = DataHandler.instance.highScoreData[indexPath.row].name
            cell.pointsLabel.text = String(DataHandler.instance.highScoreData[indexPath.row].points)+"p"
            
            return cell
        }
        
        return UITableViewCell()
    }
}
   

   
  
    


