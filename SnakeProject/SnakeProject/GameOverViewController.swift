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
    
    var scene:SnakeClass?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scene?.moveSnakeHorizontal()
        self.scene?.moveSnakeVertical()
        Timer.scheduledTimer(timeInterval: 6, target: self, selector:  #selector(GameOverViewController.moveIt), userInfo: nil, repeats: true)
        bestScore.text = "Best Score: \(DataHandler.instance.bestScore)"
        currentScore.text = "Your Score: \(DataHandler.instance.currentScore)"
    }
    
    @objc func moveIt(){
        self.scene?.moveSnakeHorizontal()
        self.scene?.moveSnakeVertical()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        self.scene = SnakeClass(size: CGSize(width: self.snakeScene2.frame.size.width, height: self.snakeScene2.frame.size.height))
        self.snakeScene2.presentScene(scene)
        
        self.scene?.moveSnakeHorizontal()
        self.scene?.moveSnakeVertical()
    }
    
    
}

