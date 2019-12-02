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
    var timer:Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scene?.moveSnakeHorizontal()
        self.scene?.moveSnakeVertical()
        Timer.scheduledTimer(timeInterval: 4, target: self, selector:  #selector(MainMenuViewController.moveIt), userInfo: nil, repeats: true)
    }

    @objc func moveIt(){
        self.scene?.moveSnakeHorizontal()
        self.scene?.moveSnakeVertical()
    }
  
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.scene = SnakeClass(size: CGSize(width: self.snakeScene.frame.size.width, height: self.snakeScene.frame.size.height))
        self.snakeScene.presentScene(scene)
        self.scene?.moveSnakeHorizontal()
        self.scene?.moveSnakeVertical()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        timer?.invalidate()
    }
    
    @IBAction func playbuttonClicked(_ sender: Any) {}
    
    @IBAction func highscoresbuttonClicked(_ sender: Any) {}
    
    @IBAction func prepareForUnwind(segue:UIStoryboardSegue){}
    
}
