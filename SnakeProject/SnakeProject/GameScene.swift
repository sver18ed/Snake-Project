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
    
    var currentScore: SKLabelNode!
    var playerPositions: [(Int, Int)] = []
    var gameBG: SKShapeNode!
    var gameArray: [(node: SKShapeNode, x: Int, y: Int)] = []
    var scorePos: CGPoint?
    var leftButton: SKShapeNode!
    var rightButton: SKShapeNode!
    var upButton: SKShapeNode!
    var downButton: SKShapeNode!
    
    
    override func didMove(to view: SKView) {
        game = GameManager(scene: self)
        initializeGameView()
        startGame()
        
        let swipeRight: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeR))
        swipeRight.direction = .right
        view.addGestureRecognizer(swipeRight)
        
        let swipeLeft: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeL))
        swipeLeft.direction = .left
        view.addGestureRecognizer(swipeLeft)
        
        let swipeUp: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeU))
        swipeUp.direction = .up
        view.addGestureRecognizer(swipeUp)
        
        let swipeDown: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeD))
        swipeDown.direction = .down
        view.addGestureRecognizer(swipeDown)
    
    }
    
    @objc func swipeR() {
        game.swipe(ID: 3)
    }
    
    @objc func swipeL() {
        game.swipe(ID: 1)
    }
    
    @objc func swipeU() {
        game.swipe(ID: 2)
    }
    
    @objc func swipeD() {
        game.swipe(ID: 4)
    }
    
    override func update(_ currentTime: TimeInterval) {
        game.update(time: currentTime)
        
        
    }
    
    private func startGame() {
        print("Start Game")
        self.game.initGame()
        
    }
    
    private func initializeGameView() {
        currentScore = SKLabelNode(fontNamed: "ArialRoundedMTBold")
        currentScore.zPosition = 1
        currentScore.position = CGPoint(x: 0, y: (frame.size.height / -2) + 60)
        currentScore.fontSize = 40
        currentScore.text = "Score: 0"
        currentScore.fontColor = SKColor.white
        self.addChild(currentScore)
        
        // make turn right button in game
        rightButton = SKShapeNode()
        rightButton.name = "right_button"
        rightButton.zPosition = 3
        rightButton.position = CGPoint(x: 150, y: (frame.size.height / -2) + 200)
        rightButton.fillColor = SKColor.green
        let topCorner = CGPoint(x: -50, y: 50)
        let bottomCorner = CGPoint(x: -50, y: -50)
        let middle = CGPoint(x: 50, y: 0)
        let path = CGMutablePath()
        path.addLine(to: topCorner)
        path.addLines(between: [topCorner, bottomCorner, middle])
        rightButton.path = path
        self.addChild(rightButton)
        
        // make turn left button in game
        leftButton = SKShapeNode()
        leftButton.name = "left_button"
        leftButton.zPosition = 3
        leftButton.position = CGPoint(x: -50, y: (frame.size.height / -2) + 200)
        leftButton.fillColor = SKColor.green
        let leftTopCorner = CGPoint(x: -50, y: 50)
        let leftBottomCorner = CGPoint(x: -50, y: -50)
        let leftMiddle = CGPoint(x: -150, y: 0)
        let leftPath = CGMutablePath()
        leftPath.addLine(to: leftTopCorner)
        leftPath.addLines(between: [leftTopCorner, leftBottomCorner, leftMiddle])
        leftButton.path = leftPath
        self.addChild(leftButton)
        
        let width = frame.size.width - 200
        let height = frame.size.height - 510
        let rect = CGRect(x: -width / 2, y: -height / 2, width: width, height: height)
        gameBG = SKShapeNode (rect: rect, cornerRadius: 0.02)
        gameBG.fillColor = SKColor.darkGray
        gameBG.zPosition = 2
        gameBG.isHidden = false
        self.addChild(gameBG)
        
        createGameBoard(width: Int(width), height: Int(height))
        
    }
    
    private func createGameBoard( width: Int, height: Int) {
        let cellWidth: CGFloat = 27.5
        let numRows = 30
        let numCols = 20
        var x = CGFloat(width / -2) + (cellWidth / 2)
        var y = CGFloat(height / 2) - (cellWidth / 2)
        
        for i in 0...numRows - 1 {
            for j in 0...numCols - 1 {
                let cellNode = SKShapeNode(rectOf: CGSize(width: cellWidth, height: cellWidth))
                cellNode.strokeColor = SKColor.black
                cellNode.zPosition = 2
                cellNode.position = CGPoint(x: x, y: y)
                
                gameArray.append((node: cellNode, x: i, y: j))
                gameBG.addChild(cellNode)
                x += cellWidth
                
            }
            x = CGFloat(width / -2) + (cellWidth / 2)
            y -= cellWidth
        }
        
    }

    
    
    
   
}
