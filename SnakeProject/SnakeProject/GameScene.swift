//
//  GameScene.swift
//  SnakeProject
//
//  Created by Erik Sveningsson on 2019-11-15.
//  Copyright © 2019 Erik Sveningsson. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    //1
    var game: GameManager!
    var playerPositions: [(Int, Int)] = []
    var gameBG: SKShapeNode!
    var gameArray: [(node: SKShapeNode, x: Int, y: Int)] = []
    
    var leftDownButton: SKShapeNode!
    var rightUpButton: SKShapeNode!
    
    
    override func didMove(to view: SKView) {
        //2
        game = GameManager(scene: self)
        initializeGameView()
        startGame()
        
        //1
//        let swipeRight:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeR))
//        swipeRight.direction = .right
//        view.addGestureRecognizer(swipeRight)
//        let swipeLeft:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeL))
//        swipeLeft.direction = .left
//        view.addGestureRecognizer(swipeLeft)
//        let swipeUp:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeU))
//        swipeUp.direction = .up
//        view.addGestureRecognizer(swipeUp)
//        let swipeDown:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeD))
//        swipeDown.direction = .down
//        view.addGestureRecognizer(swipeDown)
    }
    
//    //2
//    @objc func swipeR() {
//        game.swipe(ID: 3)
//    }
//    @objc func swipeL() {
//        game.swipe(ID: 1)
//    }
//    @objc func swipeU() {
//        game.swipe(ID: 2)
//    }
//    @objc func swipeD() {
//        game.swipe(ID: 4)
//    }
    
     override func update(_ currentTime: TimeInterval) {
        game.update(time: currentTime)
    }
    
    //3
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = self.nodes(at: location)
            for node in touchedNode {
                if node.name == "leftDownButton" {
                    game.changeDirection(button: "L")
                }
                if node.name == "rightUpButton" {
                    game.changeDirection(button: "R")
                }
            }
        }
    }
    
    //3
    public func initializeGameView() {
        //5
        let width = 550
        let height = 1100
        let rect = CGRect(x: -width / 2, y: -height / 2, width: width, height: height)
        gameBG = SKShapeNode(rect: rect, cornerRadius: 0.02)
        gameBG.fillColor = SKColor.darkGray
        gameBG.zPosition = 2
        gameBG.isHidden = true
        self.addChild(gameBG)
        //6
        createGameBoard(width: width, height: height)
        
        //Create left & down button
        leftDownButton = SKShapeNode()
        leftDownButton.name = "leftDownButton"
        leftDownButton.zPosition = 3
        leftDownButton.position = CGPoint(x: -80 - (frame.size.width / 6), y: (frame.size.height / -2) + 60)
        leftDownButton.fillColor = SKColor.blue
        let topCorner = CGPoint(x: 20, y: 20)
        let bottomCorner = CGPoint(x: 20, y: -20)
        let middle = CGPoint(x: -20, y: 0)
        let path = CGMutablePath()
        path.addLine(to: topCorner)
        path.addLines(between: [topCorner, bottomCorner, middle])
        leftDownButton.path = path
        self.addChild(leftDownButton)
        
        //Create right & up button
        rightUpButton = SKShapeNode()
        rightUpButton.name = "rightUpButton"
        rightUpButton.zPosition = 3
        rightUpButton.position = CGPoint(x: 80 + (frame.size.width / 6), y: (frame.size.height / -2) + 60)
        rightUpButton.fillColor = SKColor.blue
        let topCorner2 = CGPoint(x: -20, y: 20)
        let bottomCorner2 = CGPoint(x: -20, y: -20)
        let middle2 = CGPoint(x: 20, y: 0)
        let path2 = CGMutablePath()
        path2.addLine(to: topCorner2)
        path2.addLines(between: [topCorner2, bottomCorner2, middle2])
        rightUpButton.path = path2
        self.addChild(rightUpButton)
    }

    private func createGameBoard(width: Int, height: Int) {
        let cellWidth: CGFloat = 27.5
        let numRows = 40
        let numCols = 20
        var x = CGFloat(width / -2) + (cellWidth / 2)
        var y = CGFloat(height / 2) - (cellWidth / 2)
        //loop through rows and columns, create cells
        for i in 0...numRows - 1 {
            for j in 0...numCols - 1 {
                let cellNode = SKShapeNode(rectOf: CGSize(width: cellWidth, height: cellWidth))
                cellNode.strokeColor = SKColor.black
                cellNode.zPosition = 2
                cellNode.position = CGPoint(x: x, y: y)
                //add to array of cells -- then add to game board
                gameArray.append((node: cellNode, x: i, y: j))
                gameBG.addChild(cellNode)
                //iterate x
                x += cellWidth
            }
            //reset x, iterate y
            x = CGFloat(width / -2) + (cellWidth / 2)
            y -= cellWidth
        }
    }

    //4
    private func startGame() {
        print("start game")
        
        self.gameBG.isHidden = false
        self.gameBG.run(SKAction.scale(to: 1, duration: 0.4))
        self.game.initGame()
    }
}
