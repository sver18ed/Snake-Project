//
//  GameScene.swift
//  SnakeProject
//
//  Created by Erik Sveningsson on 2019-11-15.
//  Copyright © 2019 Erik Sveningsson. All rights reserved.
//

import SpriteKit
import GameplayKit

//struct Button {
//    var name: String
//    var zPosition: Int
//    var position: CGPoint
//    var fillColor: SKColor
//    var topCorner: CGPoint
//    var bottomCorner: CGPoint
//    var middle: CGPoint
//    var path: CGMutablePath
//
//    init(name: String, zPosition: Int, position: CGPoint, fillColor: SKColor, topCorner: CGPoint, bottomCorner: CGPoint, middle: CGPoint, path: CGMutablePath) {
//
//        self.name = name
//        self.zPosition = zPosition
//
//    }
//}

class GameScene: SKScene {
    
    //1
    var game: GameManager!
    var playerPositions: [(Int, Int)] = []
    var gameBG: SKShapeNode!
    var gameArray: [(node: SKShapeNode, x: Int, y: Int)] = []
    
    var leftButton: SKShapeNode!
    var upButton: SKShapeNode!
    var rightButton: SKShapeNode!
    var downButton: SKShapeNode!
    
    
    override func didMove(to view: SKView) {
        //2
        game = GameManager(scene: self)
        initializeGameView()
        startGame()
        
    }
    
     override func update(_ currentTime: TimeInterval) {
        game.update(time: currentTime)
    }
    
    //3
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
    
    //3
    public func initializeGameView() {
        //5
        let width = 600
        let height = 900
        let rect = CGRect(x: -width / 2, y: -height / 2 + width / 3, width: width, height: height)
        gameBG = SKShapeNode(rect: rect, cornerRadius: 0.02)
        gameBG.fillColor = SKColor.white
        gameBG.zPosition = 2
        gameBG.isHidden = true
        self.addChild(gameBG)
        //6
        createGameBoard(width: width, height: height)
        
        //Create left, up, right & down buttons
        
        leftButton = getButton(name: "leftButton", zPosition: 3, position: CGPoint(x: -120, y: (frame.size.height / -3)), fillColor: SKColor.blue, topCorner: CGPoint(x: 40, y: 40), bottomCorner: CGPoint(x: 40, y: -40), middle: CGPoint(x: -40, y: 0))
        self.addChild(leftButton)
        
        upButton = getButton(name: "upButton", zPosition: 3, position: CGPoint(x: 0, y: (frame.size.height / -3) + 120), fillColor: SKColor.blue, topCorner: CGPoint(x: 0, y: 40), bottomCorner: CGPoint(x: 40, y: -40), middle: CGPoint(x: -40, y: -40))
        self.addChild(upButton)
        
        rightButton = getButton(name: "rightButton", zPosition: 3, position: CGPoint(x: 120, y: (frame.size.height / -3)), fillColor: SKColor.blue, topCorner: CGPoint(x: -40, y: 40), bottomCorner: CGPoint(x: -40, y: -40), middle: CGPoint(x: 40, y: 0))
        self.addChild(rightButton)
        
        downButton = getButton(name: "downButton", zPosition: 3, position: CGPoint(x: 0, y: (frame.size.height / -3) - 120), fillColor: SKColor.blue, topCorner: CGPoint(x: 0, y: -40), bottomCorner: CGPoint(x: 40, y: 40), middle: CGPoint(x: -40, y: 40))
        self.addChild(downButton)
    }

    private func createGameBoard(width: Int, height: Int) {
        let cellWidth: CGFloat = 30
        let numRows = 30
        let numCols = 20
        var x = CGFloat(width / -2) + (cellWidth / 2)
        var y = CGFloat(height / 2 + width / 3) - (cellWidth / 2)
        //loop through rows and columns, create cells
        for i in 0...numRows - 1 {
            for j in 0...numCols - 1 {
                let cellNode = SKShapeNode(rectOf: CGSize(width: cellWidth, height: cellWidth))
                cellNode.strokeColor = SKColor.white
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
    
    private func getButton(name: String, zPosition: CGFloat, position: CGPoint, fillColor: SKColor, topCorner: CGPoint, bottomCorner: CGPoint, middle: CGPoint) -> SKShapeNode {
        let button = SKShapeNode()
        button.name = name
        button.zPosition = zPosition
        button.position = position
        button.fillColor = fillColor
        let topCorner = topCorner
        let bottomCorner = bottomCorner
        let middle = middle
        let path = CGMutablePath()
        path.addLine(to: topCorner)
        path.addLines(between: [topCorner, bottomCorner, middle])
        button.path = path
        
        return button
    }
    
}
