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
    
    var gameManager: GameManager!
    
    var playerPositions: [(Int, Int)] = []
    var gameBackGround: SKShapeNode!
    var gameArray: [(node: SKShapeNode, x: Int, y: Int)] = []
    
    var leftButton: SKShapeNode!
    var upButton: SKShapeNode!
    var rightButton: SKShapeNode!
    var downButton: SKShapeNode!
    
    var numberOfColumns: Int!
    var numberOfRows: Int!
    
    var currentScoreLabel: SKLabelNode!
    var applePosition: CGPoint?
    
    // MARK: - didMove
    
    override func didMove(to view: SKView) {
        gameManager = GameManager(scene: self)
        DataHandler.instance.resetCurrentScore()
        initializeGameView()
        startGame()
    }
    
    // MARK: - update
    
     override func update(_ currentTime: TimeInterval) {
        gameManager.update(currentTime: currentTime)
    }
    
    // MARK: - touchesBegan
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = self.nodes(at: location)
            for node in touchedNode {
                if node.name == "leftButton" {
                    gameManager.changeDirection(direction: "left")
                }
                if node.name == "upButton" {
                    gameManager.changeDirection(direction: "up")
                }
                if node.name == "rightButton" {
                    gameManager.changeDirection(direction: "right")
                }
                if node.name == "downButton" {
                    gameManager.changeDirection(direction: "down")
                }
            }
        }
    }
    
    // MARK: - initializeGameView
    
    public func initializeGameView() {
        
        let width = 600
        let height = 900
        let rect = CGRect(x: -width / 2, y: (-height / 2 + width / 3) - 30, width: width, height: height)
        gameBackGround = SKShapeNode(rect: rect, cornerRadius: 0)
        gameBackGround.fillColor = SKColor.systemTeal
        gameBackGround.isHidden = true
        self.addChild(gameBackGround)
        

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
        
        currentScoreLabel = SKLabelNode(fontNamed: "ArialRoundedMTBold")
        currentScoreLabel.position = CGPoint(x: 170, y: (frame.size.height / -2) + 325)
        currentScoreLabel.fontSize = 40
        currentScoreLabel.text = "Score: \(DataHandler.instance.currentScore)"
        currentScoreLabel.fontColor = SKColor.white
        self.addChild(currentScoreLabel)
    }

    // MARK: - createGameBoard
    
    private func createGameBoard(width: Int, height: Int) {
        
        let cellWidth: CGFloat = 30
        numberOfRows = 30
        numberOfColumns = 20
        var x = CGFloat(width / -2) + (cellWidth / 2)
        var y = CGFloat(height / 2 + width / 3) - 30 - (cellWidth / 2)
        //loop through rows and columns, create cells
        for i in 0...numberOfRows - 1 {
            for j in 0...numberOfColumns - 1 {
                let cellNode = SKShapeNode(rectOf: CGSize(width: cellWidth, height: cellWidth))
                cellNode.strokeColor = SKColor.systemTeal
                cellNode.zPosition = 2
                cellNode.position = CGPoint(x: x, y: y)
                //add to array of cells -- then add to game board
                gameArray.append((node: cellNode, x: i, y: j))
                gameBackGround.addChild(cellNode)
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
        self.gameBackGround.isHidden = false
        self.gameBackGround.run(SKAction.scale(to: 1, duration: 0.4))
        self.gameManager.initGame()
    }
    
    // MARK: - getButton
    
    private func getButton(name: String, position: CGPoint, corner1: CGPoint, corner2: CGPoint, corner3: CGPoint) -> SKShapeNode {
        
        let button = SKShapeNode()
        button.name = name
        button.position = position
        button.fillColor = SKColor.systemOrange
        let path = CGMutablePath()
        path.addLines(between: [corner1, corner2, corner3])
        button.path = path
        return button
    }
    
    // MARK: - getNumberOfColumns
    
    public func getNumberOfColumns() -> Int {
        return numberOfColumns
    }
    
    // MARK: - getNumberOfRows
    
    public func getNumberOfRows() -> Int {
        return numberOfRows
    }
}
