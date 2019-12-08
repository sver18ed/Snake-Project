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

class SnakeAnimation: SKScene {
    
    var horizontalSnakeImages :[SKTexture]?
    var verticalSnakeIamges :[SKTexture]?
    var snakeSize: Int = 400
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - InitImage
    
    override init(size: CGSize) {
        super.init(size: size)
        self.backgroundColor = UIColor.white
        var horizontalFrames:[SKTexture] = []
        var verticalFrames:[SKTexture] = []
        
        let snakeAtlas = SKTextureAtlas(named: "Sprites")
        let pic1 = snakeAtlas.textureNamed("snakeH_1")
        horizontalFrames.append(pic1)
        let pic2 = snakeAtlas.textureNamed("snakeH_2")
        horizontalFrames.append(pic2)
        let pic3 = snakeAtlas.textureNamed("snakeU_1")
        verticalFrames.append(pic3)
        let pic4 = snakeAtlas.textureNamed("snakeU_2")
        verticalFrames.append(pic4)
    
        self.horizontalSnakeImages = horizontalFrames
        self.verticalSnakeIamges = verticalFrames
    }
    
    // MARK: - moveSnakeHorizontal
    
    func moveSnakeHorizontal(){
        let texture = self.horizontalSnakeImages![0]
        let snake = SKSpriteNode(texture: texture)
        snake.size = CGSize(width: snakeSize, height: snakeSize)
        
        let generateRandomSnakeYPosition = GKRandomDistribution(lowestValue: 50, highestValue: (Int(self.frame.size.height)-50))
        let yPosition = CGFloat(generateRandomSnakeYPosition.nextInt())
        let determineStart = arc4random() % 2 == 0
        //select starting position depending on orientation
        let xPosition = determineStart ? self.frame.size
            .width + snake.size.width / 2 : -snake.size.width / 2
        snake.position = CGPoint(x: xPosition, y: yPosition)
        //reverse direction of image
        if determineStart{
            snake.xScale = -1
        }
        
        self.addChild(snake)
        snake.run(SKAction.repeatForever(SKAction.animate(with: self.horizontalSnakeImages!, timePerFrame: 0.65, resize: false, restore: true)))
        var rangeToCover = self.frame.size.width + snake.size.width
        //reversing direction
        if determineStart{
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
    
    // MARK: - moveSnakeVertical
    
    func moveSnakeVertical(){
        let texture = self.verticalSnakeIamges![0]
        let snake = SKSpriteNode(texture: texture)
        snake.size = CGSize(width: snakeSize, height: snakeSize)
        
        let generateRandomSnakeXPosition = GKRandomDistribution(lowestValue: 50, highestValue: (Int(self.frame.size.width)-50))
        let xPosition = CGFloat(generateRandomSnakeXPosition.nextInt())
        let determineStart = arc4random() % 2 == 0
        
        let yPosition = determineStart ? self.frame.size
            .height + snake.size.height / 2 : -snake.size.height / 2
        snake.position = CGPoint(x: xPosition, y: yPosition)
        //reverse direction of image
        if determineStart{
            snake.yScale = -1
        }
        
        self.addChild(snake)
        snake.run(SKAction.repeatForever(SKAction.animate(with: self.verticalSnakeIamges!, timePerFrame: 0.65, resize: false, restore: true)))
        var rangeToCover = self.frame.size.height + snake.size.height
        //reversing direction
        if determineStart{
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
