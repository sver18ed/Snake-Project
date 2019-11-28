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
    
    var scene:SnakeClass?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scene?.moveSnakeHorizontal()
        self.scene?.moveSnakeVertical()
        Timer.scheduledTimer(timeInterval: 5, target: self, selector:  #selector(GameOverViewController.moveIt), userInfo: nil, repeats: true)
        // Do any additional setup after loading the view.
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
