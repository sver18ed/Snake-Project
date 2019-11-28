//
//  HighScoreJson.swift
//  SnakeProject
//
//  Created by Håkan Thorleifsson on 2019-11-27.
//  Copyright © 2019 Erik Sveningsson. All rights reserved.
//

import UIKit

class HighScores: Codable{
    let highScore: [HighScoreData]
    
    init(highScore:[HighScoreData]){
        self.highScore = highScore
    }
}

class HighScoreData: Codable {
    let name: String
    let points: String
    
    init(name: String, points: String){
        self.name = name
        self.points = points
    }

}

struct theHighScoreDict: Codable{
    var highScore: [UserData]
}

struct UserData: Codable{
    var name: String
    var points: String
}

func updateUserData(){
    
    //add existing json object + new user data to update the api
    
    let userData = theHighScoreDict.init(highScore: [UserData(name: "Håkan", points: "123"), UserData(name: "Erik", points: "467"), UserData(name: "Andreas", points: "789")])
  
    
    guard let url = URL(string: "https://api.myjson.com/bins/1eiflu") else { return }
    var request = URLRequest(url: url)
    request.httpMethod = "PUT"
    request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
    guard let httpBody = try? JSONEncoder().encode(userData) else {return}
    
    request.httpBody = httpBody

    let session = URLSession.shared
    session.dataTask(with: request) { (data, response, error) in
        //if let response = response {
            //response
        //}

       /* if let data = data {
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
            } catch {
                print(error)
            }
        }*/
    }.resume()
}


