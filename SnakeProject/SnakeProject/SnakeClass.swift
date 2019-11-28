//
//  SnakeClass.swift
//  SnakeProject
//
//  Created by Andreas Persson on 2019-11-28.
//  Copyright © 2019 Erik Sveningsson. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class SnakeClass: SKScene {
    
    var snakeFrames :[SKTexture]?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        self.backgroundColor = UIColor.white
        var frames:[SKTexture] = []
        
        let snakeAtlas = SKTextureAtlas(named: "Assets")
        for index in 1 ... 8{
            let textureName = "orm_\(index)"
            let texture = snakeAtlas.textureNamed(textureName)
            frames.append(texture)
        }
        self.snakeFrames = frames
    }
    
    func moveSnake(){
        let texture = self.snakeFrames![0]
        let snake = SKSpriteNode(texture: texture)
        
        snake.size = CGSize(width: 140, height: 80)
        
        let randomSnakeYPosition = GKRandomDistribution(lowestValue: 50, highestValue: (Int(self.frame.size.width)))
        let yPosition = CGFloat(randomSnakeYPosition.nextInt())
        let rightToLeft = arc4random() % 2 == 0
        let xPosition = rightToLeft ? self.frame.size
            .width + snake.size.width / 2 : -snake.size.width / 2
        snake.position = CGPoint(x: xPosition, y: yPosition)
        if rightToLeft{
            snake.xScale = -1
        }
        
        self.addChild(snake)
        snake.run(SKAction.repeatForever(SKAction.animate(with: self.snakeFrames!, timePerFrame: 0.5, resize: false, restore: true)))
        var rangeToCover = self.frame.size.width + snake.size.width
        if rightToLeft{
            rangeToCover *= -1
        }
        
        let time = TimeInterval(abs(rangeToCover/140))
        let moveAction = SKAction.moveBy(x: rangeToCover, y: 0, duration: time)
        let removeAction = SKAction.run{
            snake.removeAllActions()
            snake.removeFromParent()
        }
        let allAction = SKAction.sequence([moveAction, removeAction])
        
        snake.run(allAction)
        
    }
    
}
