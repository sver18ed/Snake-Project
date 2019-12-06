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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        bestScore.text = "Local Best: \(DataHandler.instance.bestScore)"
        currentScore.text = "Score: \(DataHandler.instance.currentScore)"
    }
    
    @IBAction func setNameButton(_ sender: Any) {
        if nameField.text != ""{
            DataHandler.instance.highScoreData.append(HighScoreData.init(name: nameField.text ?? "", points: Int(DataHandler.instance.currentScore)))
            performSegue(withIdentifier: "mainMenuSegue", sender: self)
        }
    }
    
    @IBAction func prepareForUnwind(segue:UIStoryboardSegue){}
}
