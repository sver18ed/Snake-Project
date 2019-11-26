//
//  GameManager.swift
//  SnakeProject
//
//  Created by Andreas Malmström on 2019-11-15.
//  Copyright © 2019 Erik Sveningsson. All rights reserved.
//

import SpriteKit


class GameManager{
    
    
    var scene: GameScene!
    
    var nextTime: Double?
    var timeExtension: Double = 0.15
    var playerDirection: Int = 1
    var currentScore: Int = 0
    
    init(scene: GameScene) {
        self.scene = scene
    }
    func initGame() {
        scene.playerPositions.append((10, 10))
        scene.playerPositions.append((10,11))
        scene.playerPositions.append((10, 12))
        scene.playerPositions.append((10, 13))
        scene.playerPositions.append((10, 14))
        scene.playerPositions.append((10, 15))
        scene.playerPositions.append((10, 16))
        scene.playerPositions.append((10, 17))
        scene.playerPositions.append((10, 18))
        scene.playerPositions.append((10, 19))
        scene.playerPositions.append((10, 20))
        scene.playerPositions.append((10, 21))
        scene.playerPositions.append((10, 22))
        scene.playerPositions.append((10, 23))
        scene.playerPositions.append((10, 24))
        
        renderChange()
        generateNewPoint()
    }
    
    private func checkForScore() {
        if scene.scorePos != nil {
            let x = scene.playerPositions[0].0
            let y = scene.playerPositions[0].1
            if Int((scene.scorePos?.x)!) == y && Int((scene.scorePos?.y)!) == x {
                currentScore += 1
                scene.currentScore.text = "Score: \(currentScore)"
                generateNewPoint()
                scene.playerPositions.append(scene.playerPositions.last!)
                
            }
        }
    }
    
    private func generateNewPoint() {
        var randomX = CGFloat(arc4random_uniform(19))
        var randomY = CGFloat(arc4random_uniform(29))
        while contains(a: scene.playerPositions, v: (Int(randomX), Int(randomY))) {
            randomX = CGFloat(arc4random_uniform(19))
            randomY = CGFloat(arc4random_uniform(29))
        }
        
        scene.scorePos = CGPoint(x: randomX, y: randomY)
        
    }
    
    func update(time: Double) {
        if nextTime == nil {
            nextTime = time + timeExtension
        } else {
            if time >= nextTime! {
                nextTime = time + timeExtension
                updatePlayerPosition()
                checkForScore()
                checkForDeath()
                finishAnimation()
            }
        }
    }
    
    
    private func finishAnimation(){
        if playerDirection == 0 && scene.playerPositions.count > 0 {
            var hasFinished = true
            let headOfSnake = scene.playerPositions[0]
            for position in scene.playerPositions {
                if headOfSnake != position {
                    hasFinished = false
                }
            }
            if hasFinished{
                
               //goToGameOver()
                print("end game")
                playerDirection = 4
                goToGameOver()
            }
            
        }
        

    }
    
    private func checkForDeath() {
        if scene.playerPositions.count > 0 {
            var arrayOfPositions = scene.playerPositions
            let headOfSnake = arrayOfPositions[0]
            arrayOfPositions.remove(at: 0)
            if contains(a: arrayOfPositions, v: headOfSnake) {
                playerDirection = 0
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
            case 0:
                xChange = 0
                yChange = 0
                break
            default:
                break
        }
        if scene.playerPositions.count > 0 {
            var start = scene.playerPositions.count - 1
            while start > 0 {
                scene.playerPositions[start] = scene.playerPositions[start - 1]
                start -= 1
            }
            scene.playerPositions[0] = (scene.playerPositions[0].0 +
                yChange, scene.playerPositions[0].1 + xChange)
        }
        if scene.playerPositions.count > 0 {
            let x = scene.playerPositions[0].1
            let y = scene.playerPositions[0].0
            if y > 30 {
                scene.playerPositions[0].0 = 0
            } else if y < 0 {
                scene.playerPositions[0].0 = 30
            } else if x > 20 {
                scene.playerPositions[0].1 = 0
            } else if x < 0 {
                scene.playerPositions[0].1 = 20
            }
        }
        renderChange()
    }
    
    
    
    func renderChange() {
        for (node, x, y) in scene.gameArray {
            if contains(a: scene.playerPositions, v: (x,y)) {
                node.fillColor = SKColor.cyan
            } else {
                node.fillColor = SKColor.clear
                if scene.scorePos != nil {
                    if Int((scene.scorePos?.x)!) == y && Int((scene.scorePos?.y)!) == x {
                        node.fillColor = SKColor.red
                    }
                }
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
                if playerDirection != 0 {
                    playerDirection = ID
                }
            }
        }
    }
    func goToGameOver() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "gameOverSegue"), object: nil)    }
    
}
