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
    var snakeFrames2 :[SKTexture]?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        self.backgroundColor = UIColor.white
        var frames:[SKTexture] = []
        var frames2:[SKTexture] = []
        
        
        let snakeAtlas = SKTextureAtlas(named: "Sprites")
        let pic1 = snakeAtlas.textureNamed("snakeH_1")
        frames.append(pic1)
        let pic2 = snakeAtlas.textureNamed("snakeH_2")
        frames.append(pic2)
        let pic3 = snakeAtlas.textureNamed("snakeU_1")
        frames2.append(pic3)
        let pic4 = snakeAtlas.textureNamed("snakeU_2")
        frames2.append(pic4)
    
        self.snakeFrames = frames
        self.snakeFrames2 = frames2
    }
    
    
    func moveSnakeHorizontal(){
        let texture = self.snakeFrames![0]
        let snake = SKSpriteNode(texture: texture)
        
        snake.size = CGSize(width: 400, height: 400)
        
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
        snake.run(SKAction.repeatForever(SKAction.animate(with: self.snakeFrames!, timePerFrame: 0.65, resize: false, restore: true)))
        var rangeToCover = self.frame.size.width + snake.size.width
        if rightToLeft{
            rangeToCover *= -1
        }
        
        let time = TimeInterval(abs(rangeToCover/100))
        let moveAction = SKAction.moveBy(x: rangeToCover, y: 0, duration: time)
        let removeAction = SKAction.run{
            snake.removeAllActions()
            snake.removeFromParent()
        }
        let allAction = SKAction.sequence([moveAction, removeAction])
        
        snake.run(allAction)
   
    }
    
    func moveSnakeVertical(){
        let texture = self.snakeFrames2![0]
        let snake = SKSpriteNode(texture: texture)
        
        snake.size = CGSize(width: 400, height: 400)
        
        let randomSnakeXPosition = GKRandomDistribution(lowestValue: 50, highestValue: (Int(self.frame.size.width)))
        let xPosition = CGFloat(randomSnakeXPosition.nextInt())
        let rightToLeft = arc4random() % 2 == 0
        let yPosition = rightToLeft ? self.frame.size
            .height + snake.size.height / 2 : -snake.size.height / 2
        snake.position = CGPoint(x: xPosition, y: yPosition)
        if rightToLeft{
            snake.yScale = -1
        }
        
        self.addChild(snake)
        snake.run(SKAction.repeatForever(SKAction.animate(with: self.snakeFrames2!, timePerFrame: 0.65, resize: false, restore: true)))
        var rangeToCover = self.frame.size.height + snake.size.height
        if rightToLeft{
            rangeToCover *= -1
        }
        
        let time = TimeInterval(abs(rangeToCover/100))
        let moveAction = SKAction.moveBy(x: 0, y: rangeToCover, duration: time)
        let removeAction = SKAction.run{
            snake.removeAllActions()
            snake.removeFromParent()
        }
        let allAction = SKAction.sequence([moveAction, removeAction])
        
        snake.run(allAction)
        
    }
    
}