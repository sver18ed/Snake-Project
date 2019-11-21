//
//  GameManager.swift
//  SnakeProject
//
//  Created by Erik Sveningsson on 2019-11-15.
//  Copyright © 2019 Erik Sveningsson. All rights reserved.
//

import SpriteKit

class GameManager {
    var scene: GameScene!
    
    var nextTime: Double?
    var timeExtension: Double = 0.15
    
    //1
    var playerDirection: Int = 4
    
    init(scene: GameScene) {
        self.scene = scene
    }
    
    //1
    func initGame() {
        //starting player position
        scene.playerPositions.append((10, 10))
        scene.playerPositions.append((10, 11))
        scene.playerPositions.append((10, 12))
        renderChange()
    }
    //2
    func update(time: Double) {
        if nextTime == nil {
            nextTime = time + timeExtension
        } else {
            if time >= nextTime! {
                nextTime = time + timeExtension
                
                updatePlayerPosition()
            }
        }
    }
    //3
    private func updatePlayerPosition() {
        //4
        var xChange = -1
        var yChange = 0
        //5
        switch playerDirection {
            case 1:
                //left
                xChange = -1
                yChange = 0
                break
            case 2:
                //up
                xChange = 0
                yChange = -1
                break
            case 3:
                //right
                xChange = 1
                yChange = 0
                break
            case 4:
                //down
                xChange = 0
                yChange = 1
                break
            default:
                break
        }
        //6
        if scene.playerPositions.count > 0 {
            var start = scene.playerPositions.count - 1
            while start > 0 {
                scene.playerPositions[start] = scene.playerPositions[start - 1]
                start -= 1
            }
            scene.playerPositions[0] = (scene.playerPositions[0].0 + yChange, scene.playerPositions[0].1 + xChange)
        }
        //1
        if scene.playerPositions.count > 0 {
            let x = scene.playerPositions[0].1
            let y = scene.playerPositions[0].0
            if y > 40 {
                scene.playerPositions[0].0 = 0
            } else if y < 0 {
                scene.playerPositions[0].0 = 40
            } else if x > 20 {
               scene.playerPositions[0].1 = 0
            } else if x < 0 {
                scene.playerPositions[0].1 = 20
            }
        
        }
        //7
        renderChange()
    }
    
    
    func changeDirection(button: String) {
        
        if (button == "R") {
            if (playerDirection == 2 || playerDirection == 4) {
                playerDirection = 3
            }
            else if (playerDirection == 1) {
                playerDirection = 2
            }
            
            else if (playerDirection == 3) {
                playerDirection = 4
            }
        }
        
        if (button == "L") {
            if (playerDirection == 2 || playerDirection == 4) {
                playerDirection = 1
            }
            else if (playerDirection == 1) {
                playerDirection = 4
            }
            
            else if (playerDirection == 3) {
                playerDirection = 2
            }
        }
        
//        if !(ID == 2 && playerDirection == 4) && !(ID == 4 && playerDirection == 2) {
//            if !(ID == 1 && playerDirection == 3) && !(ID == 3 && playerDirection == 1) {
//                playerDirection = ID
//            }
//        }
    }
    
    //2
    func renderChange() {
        for (node, x, y) in scene.gameArray {
            if contains(a: scene.playerPositions, v: (x,y)) {
                node.fillColor = SKColor.green
            } else {
                node.fillColor = SKColor.clear
            }
        }
    }
    //3
    func contains(a:[(Int, Int)], v:(Int, Int)) -> Bool {
        let (c1, c2) = v
        for (v1, v2) in a { if v1 == c1 && v2 == c2 { return true } }
        return false
    }
}
