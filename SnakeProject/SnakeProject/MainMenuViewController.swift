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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        timer = Timer.scheduledTimer(timeInterval: 6, target: self, selector:  #selector(MainMenuViewController.moveIt), userInfo: nil, repeats: true)
        self.scene = SnakeClass(size: CGSize(width: self.snakeScene.frame.size.width, height: self.snakeScene.frame.size.height))
        self.snakeScene.presentScene(scene)
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
        self.snakeScene.removeFromSuperview()
        print("timer deactivate")
    }
    
    @IBAction func playbuttonClicked(_ sender: Any) {}
    
    @IBAction func highscoresbuttonClicked(_ sender: Any) {}
    
    @IBAction func prepareForUnwind(segue:UIStoryboardSegue){}
    
}
