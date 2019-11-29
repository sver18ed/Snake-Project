//
//  SnakeProjectTests.swift
//  SnakeProjectTests
//
//  Created by Erik Sveningsson on 2019-11-15.
//  Copyright © 2019 Erik Sveningsson. All rights reserved.
//

import XCTest
@testable import SnakeProject

class SnakeProjectTests: XCTestCase {

    // MARK: - changeDirection
    func testChangeDirection() {
        let gameScene = GameScene()
        let gameManager = GameManager(scene: gameScene)
        gameManager.changeDirection(direction: "up")
        XCTAssertEqual(gameManager.playerDirection, 2, "The direction was not changed correctly")
    }

}
