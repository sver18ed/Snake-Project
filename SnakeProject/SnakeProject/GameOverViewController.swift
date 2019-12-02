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
    
    var scene:SnakeClass?
    var timer:Timer?
    var name: String?
    var points: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
     override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        bestScore.text = "Best Score: \(DataHandler.instance.bestScore)"
        currentScore.text = "Your Score: \(DataHandler.instance.currentScore)"
        points = "\(DataHandler.instance.currentScore)"
        timer = Timer.scheduledTimer(timeInterval: 6, target: self, selector:  #selector(MainMenuViewController.moveIt), userInfo: nil, repeats: true)
        self.scene = SnakeClass(size: CGSize(width: self.snakeScene2.frame.size.width, height: self.snakeScene2.frame.size.height))
        self.snakeScene2.presentScene(scene)
        moveIt()
        print("two snakes")
    }
    
    @objc func moveIt(){
        self.scene?.moveSnakeHorizontal()
        self.scene?.moveSnakeVertical()
        print("many snakes in loop")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        timer?.invalidate()
        print("timer deactivate")
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



