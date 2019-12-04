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
        nameField.doneButtonToKeyboard()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        bestScore.text = "Local Best Score: \(DataHandler.instance.bestScore)"
        currentScore.text = "Your Score: \(DataHandler.instance.currentScore)"
        points = "\(DataHandler.instance.currentScore)"
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

// MARK: - UITextField extension

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



