//
//  GameOverViewController.swift
//  SnakeProject
//
//  Created by Erik Sveningsson on 2019-11-15.
//  Copyright © 2019 Erik Sveningsson. All rights reserved.
//

import UIKit
import SpriteKit

class GameOverViewController: UIViewController {

    @IBOutlet weak var currentScore: UILabel!
    
    @IBOutlet weak var bestScore: UILabel!
    
    @IBOutlet weak var nameField: UITextField!
    
    var name: String?
    var points: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        bestScore.text = "Local Best: \(DataHandler.instance.bestScore)"
        currentScore.text = "Score: \(DataHandler.instance.currentScore)"
        points = "\(DataHandler.instance.currentScore)"
    }
    
    @IBAction func setNameButton(_ sender: Any) {
        name = nameField.text
        if name != ""{
            performSegue(withIdentifier: "highScoreSegue", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "highScoreSegue") {
            let destination = segue.destination as? HighscoresViewController
            destination?.name = name
            destination?.points = points
        }

    }
    @IBAction func prepareForUnwind(segue:UIStoryboardSegue){}
}
