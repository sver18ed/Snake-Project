//
//  SnakeProjectTests.swift
//  SnakeProjectTests
//
//  Created by Erik Sveningsson on 2019-11-15.
//  Copyright © 2019 Erik Sveningsson. All rights reserved.
//

import XCTest
import SpriteKit
@testable import SnakeProject

class SnakeProjectTests: XCTestCase {

    // MARK: - changeDirection
    func testChangeDirection() {
        let gameScene = GameScene()
        let gameManager = GameManager(scene: gameScene)
        gameManager.changeDirection(direction: "up")
        XCTAssertEqual(gameManager.playerDirection, 2, "The direction was not changed correctly")
    }

    // MARK: - checkForPictures
    func testCheckForPictures(){
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

        XCTAssertEqual(frames.count , 2, "The Picture assets for Horizontal weren't found, the proper pictures are missing.")
        XCTAssertEqual(frames2.count, 2, "The Picture assets for Vertical weren't found, the proper pictures are missing.")
    }

    // MARK: - testNamefield
    func testNameField(){
        let object = HighscoresViewController()
        object.setName = "bob"
        XCTAssertEqual(object.setName,"bob", "Bob wasn't found")
    }
}
