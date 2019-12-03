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

    
    @IBOutlet weak var snakeScene2: SKView!
    @IBOutlet weak var currentScore: UILabel!
    
    @IBOutlet weak var bestScore: UILabel!
    
    @IBOutlet weak var nameField: UITextField!
    
    var scene2:SnakeClass?
    var name: String?
    var points: String?
    
    
     override func viewDidLoad() {
        super.viewDidLoad()
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.doneIsClicked))
        
        toolbar.setItems([doneButton], animated: true)
        nameField.inputAccessoryView = toolbar

    }
    
    @objc func doneIsClicked(){
        view.endEditing(true)
    }
    
     override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        bestScore.text = "Local Best Score: \(DataHandler.instance.bestScore)"
        currentScore.text = "Your Score: \(DataHandler.instance.currentScore)"
        points = "\(DataHandler.instance.currentScore)"
        self.scene2 = SnakeClass(size: CGSize(width: self.snakeScene2.frame.size.width, height: self.snakeScene2.frame.size.height))
        self.snakeScene2.presentScene(scene2)
    }
    
    override func becomeFirstResponder() -> Bool {
        return true
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake{
            let number = Int.random(in: 0 ..< 10)
            if number % 2 == 0{
                self.scene2?.moveSnakeHorizontal()
            }
            else{
                self.scene2?.moveSnakeVertical()
            }
        }
    }

    @IBAction func setNameButton(_ sender: Any) {
        name = nameField.text
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as? HighscoresViewController
        destination?.setName = name
        destination?.setPoints = points
        
    }
    
}



