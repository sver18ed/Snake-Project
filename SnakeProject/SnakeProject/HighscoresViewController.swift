//
//  HighscoresViewController.swift
//  SnakeProject
//
//  Created by Erik Sveningsson on 2019-11-15.
//  Copyright © 2019 Erik Sveningsson. All rights reserved.
//

import UIKit

class HighscoresViewController: UITableViewController {
    
    var highScoreData = [HighScoreData]()
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
   

   
  
    


