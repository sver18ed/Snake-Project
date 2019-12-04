//
//  MainMenuViewController.swift
//  SnakeProject
//
//  Created by Erik Sveningsson on 2019-11-15.
//  Copyright © 2019 Erik Sveningsson. All rights reserved.
//

import UIKit
import SpriteKit

class MainMenuViewController: UIViewController {
    
    @IBOutlet weak var snakeScene: SKView!
    
    var scene:SnakeClass?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.scene = SnakeClass(size: CGSize(width: self.snakeScene.frame.size.width, height: self.snakeScene.frame.size.height))
        self.snakeScene.presentScene(scene)
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake{
            let number = arc4random() % 2 == 0
            if number {
                self.scene?.moveSnakeHorizontal()
            }
            else{
                self.scene?.moveSnakeVertical()
            }
        }
    }
    
    @IBAction func prepareForUnwind(segue:UIStoryboardSegue){}
}
