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
    
    var game: GameManager!
    
    
    var playerPositions: [(Int, Int)] = []
    var gameBG: SKShapeNode!
    var gameArray: [(node: SKShapeNode, x: Int, y: Int)] = []
    
    var leftButton: SKShapeNode!
    var upButton: SKShapeNode!
    var rightButton: SKShapeNode!
    var downButton: SKShapeNode!
    
    var currentScore: SKLabelNode!
    var scorePos: CGPoint?
    
    // MARK: - didMove
    
    override func didMove(to view: SKView) {
        game = GameManager(scene: self)
        initializeGameView()
        startGame()
    }
    
    // MARK: - update
    
     override func update(_ currentTime: TimeInterval) {
        game.update(time: currentTime)
    }
    
    // MARK: - touchesBegan
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = self.nodes(at: location)
            for node in touchedNode {
                if node.name == "leftButton" {
                    game.changeDirection(direction: "left")
                }
                if node.name == "upButton" {
                    game.changeDirection(direction: "up")
                }
                
                if node.name == "rightButton" {
                    game.changeDirection(direction: "right")
                }
                if node.name == "downButton" {
                    game.changeDirection(direction: "down")
                }
            }
        }
    }
    
    // MARK: - initializeGameView
    
    public func initializeGameView() {
        
        let width = 600
        let height = 900
        let rect = CGRect(x: -width / 2, y: (-height / 2 + width / 3) - 30, width: width, height: height)
        gameBG = SKShapeNode(rect: rect, cornerRadius: 0.02)
        gameBG.fillColor = SKColor.systemTeal
        gameBG.zPosition = 2
        gameBG.isHidden = true
        self.addChild(gameBG)
        

        createGameBoard(width: width, height: height)
        
        //Create left, up, right & down buttons
        
        leftButton = getButton(name: "leftButton", position: CGPoint(x: -100, y: (frame.size.height / -3)), corner1: CGPoint(x: 40, y: 40), corner2: CGPoint(x: 40, y: -40), corner3: CGPoint(x: -40, y: 0))
        self.addChild(leftButton)
        
        upButton = getButton(name: "upButton", position: CGPoint(x: 0, y: (frame.size.height / -3) + 100), corner1: CGPoint(x: 0, y: 40), corner2: CGPoint(x: 40, y: -40), corner3: CGPoint(x: -40, y: -40))
        self.addChild(upButton)
        
        rightButton = getButton(name: "rightButton", position: CGPoint(x: 100, y: (frame.size.height / -3)), corner1: CGPoint(x: -40, y: 40), corner2: CGPoint(x: -40, y: -40), corner3: CGPoint(x: 40, y: 0))
        self.addChild(rightButton)
        
        downButton = getButton(name: "downButton", position: CGPoint(x: 0, y: (frame.size.height / -3) - 100), corner1: CGPoint(x: 0, y: -40), corner2: CGPoint(x: 40, y: 40), corner3: CGPoint(x: -40, y: 40))
        self.addChild(downButton)
        
        currentScore = SKLabelNode(fontNamed: "ArialRoundedMTBold")
        currentScore.zPosition = 1
        currentScore.position = CGPoint(x: 170, y: (frame.size.height / -2) + 325)
        currentScore.fontSize = 40
        DataHandler.instance.resetCurrentScore()
        currentScore.text = "Score: \(DataHandler.instance.currentScore)"
        currentScore.fontColor = SKColor.white
        self.addChild(currentScore)
    }

    // MARK: - createGameBoard
    
    private func createGameBoard(width: Int, height: Int) {
        
        let cellWidth: CGFloat = 30
        let numRows = 30
        let numCols = 20
        var x = CGFloat(width / -2) + (cellWidth / 2)
        var y = CGFloat(height / 2 + width / 3) - 30 - (cellWidth / 2)
        //loop through rows and columns, create cells
        for i in 0...numRows - 1 {
            for j in 0...numCols - 1 {
                let cellNode = SKShapeNode(rectOf: CGSize(width: cellWidth, height: cellWidth))
                cellNode.strokeColor = SKColor.systemTeal
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

    // MARK: - startGame
    
    private func startGame() {
        self.gameBG.isHidden = false
        self.gameBG.run(SKAction.scale(to: 1, duration: 0.4))
        self.game.initGame()
    }
    
    // MARK: - getButton
    
    private func getButton(name: String, position: CGPoint, corner1: CGPoint, corner2: CGPoint, corner3: CGPoint) -> SKShapeNode {
        
        let button = SKShapeNode()
        button.name = name
        button.zPosition = 3
        button.position = position
        button.fillColor = SKColor.systemOrange
        let path = CGMutablePath()
        path.addLines(between: [corner1, corner2, corner3])
        button.path = path
        return button
    }
}
