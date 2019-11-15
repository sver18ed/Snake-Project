//
//  GameManager.swift
//  SnakeProject
//
//  Created by Andreas Malmström on 2019-11-15.
//  Copyright © 2019 Erik Sveningsson. All rights reserved.
//

import SpriteKit

class GameManager {
    
    var scene: GameScene!
    
    var nextTime: Double?
    var timeExtension: Double = 0.15
    var playerDirection: Int = 1
    
    init(scene: GameScene) {
        self.scene = scene
    }
    func initGame() {
        scene.PlayerPositions.append((10, 10))
        scene.PlayerPositions.append((10,11))
        scene.PlayerPositions.append((10, 12))
        renderChange()
    }
    
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
    
    private func updatePlayerPosition(){
        var xChange = -1
        var yChange = 0
        
        switch playerDirection {
            case 1:
                xChange = -1
                yChange = 0
                break
            case 2:
                xChange = 0
                yChange = -1
                break
            case 3:
                xChange = 1
                yChange = 0
                break
            case 4:
                xChange = 0
                    yChange = 1
                    break
                default:
                    break
        }
        if scene.PlayerPositions.count > 0 {
            var start = scene.PlayerPositions.count - 1
            while start > 0 {
                scene.PlayerPositions[start] = scene.PlayerPositions[start - 1]
                start -= 1
            }
            scene.PlayerPositions[0] = (scene.PlayerPositions[0].0 +
                yChange, scene.PlayerPositions[0].1 + xChange)
        }
        if scene.PlayerPositions.count > 0 {
            let x = scene.PlayerPositions[0].1
            let y = scene.PlayerPositions[0].0
            if y > 40 {
                scene.PlayerPositions[0].0 = 0
            } else if y < 0 {
                scene.PlayerPositions[0].0 = 40
            } else if x > 20 {
                scene.PlayerPositions[0].1 = 0
            } else if x < 0 {
                scene.PlayerPositions[0].1 = 20
            }
        }
        renderChange()
    }
    
    
    
    func renderChange() {
        for (node, x, y) in scene.gameArray {
            if contains(a: scene.PlayerPositions, v: (x,y)) {
                node.fillColor = SKColor.cyan
            } else {
                node.fillColor = SKColor.clear
            }
        }
    }
    
    func contains(a:[(Int, Int)], v:(Int, Int)) -> Bool {
        let (c1, c2) = v
        for (v1, v2) in a { if v1 == c1 && v2 == c2 { return true}}
        return false
        
    }
    
    func swipe(ID: Int) {
        if !(ID == 2 && playerDirection == 4) && !(ID == 4 && playerDirection == 2) {
            if !(ID == 1 && playerDirection == 3) && !(ID == 3 && playerDirection == 1) {
                playerDirection = ID
            }
        }
    }
    
}
