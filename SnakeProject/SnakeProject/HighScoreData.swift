//
//  HighScoreJson.swift
//  SnakeProject
//
//  Created by Håkan Thorleifsson on 2019-11-27.
//  Copyright © 2019 Erik Sveningsson. All rights reserved.
//

import UIKit

class HighScoreData: Codable {
    
    let name: String
    let points: Int
    
    init(name: String, points: Int){
        self.name = name
        self.points = points
    }
    
//    required init?(coder: NSCoder) {
//        self.name = coder.decodeObject(forKey: "name") as? String ?? ""
//        self.points = coder.decodeObject(forKey: "points") as? Int ?? 0
//    }
//    func encode(with coder: NSCoder) {
//        coder.encode(name, forKey: "name")
//        coder.encode(points, forKey: "points")
//    }
}
