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
        nameField.doneButtonToKeyboard()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        bestScore.text = "Local Best Score: \(DataHandler.instance.bestScore)"
        currentScore.text = "Your Score: \(DataHandler.instance.currentScore)"
        points = "\(DataHandler.instance.currentScore)"
        self.scene2 = SnakeClass(size: CGSize(width: self.snakeScene2.frame.size.width, height: self.snakeScene2.frame.size.height))
        self.snakeScene2.presentScene(scene2)
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
        if name != ""{
            performSegue(withIdentifier: "highScoreSegue", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as? HighscoresViewController
        destination?.setName = name
        destination?.setPoints = points
        
    }
    
}

extension UITextField{
    @IBInspectable var doneAccessory: Bool{
        get{
            return self.doneAccessory
        }
        set (hasDone){
            if hasDone{
                doneButtonToKeyboard()
            }
        }
    }
    
    func doneButtonToKeyboard(){
        let toolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        let doneButton:UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonResponder))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolbar.barStyle = .default
        toolbar.setItems([doneButton, flexSpace], animated: false)
        toolbar.sizeToFit()
        
        self.inputAccessoryView = toolbar
    }
    
    @objc func doneButtonResponder(){
        self.resignFirstResponder()
    }
}



