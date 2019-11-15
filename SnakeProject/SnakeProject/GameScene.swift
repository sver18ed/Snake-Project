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
    
    override func didMove(to view: SKView) {
        //2
        game = GameManager(scene: self)
        initializeGameView()
    }
    
//    override func update(_ currentTime: TimeInterval) {
//        game.update(time: currentTime)
//    }
    
    //3
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = self.nodes(at: location)
            for node in touchedNode {
                if node.name == "play_button" {
                    startGame()
                }
            }
        }
        startGame()
    }
    
    //3
    private func initializeGameView() {
        //4
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
        let bottomCorner = CGPoint(x: 0, y: (frame.size.height / -2) + 20)
        self.gameBG.isHidden = false
        self.gameBG.run(SKAction.scale(to: 1, duration: 0.4))
        self.game.initGame()
    }
}
