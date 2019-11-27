//
//  MainMenuViewController.swift
//  SnakeProject
//
//  Created by Erik Sveningsson on 2019-11-15.
//  Copyright © 2019 Erik Sveningsson. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {
    @IBOutlet weak var ormH_1: UIImageView!
    @IBOutlet weak var ormH_2: UIImageView!
    @IBOutlet weak var ormN_1: UIImageView!
    @IBOutlet weak var ormN_2: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewDidAppear(true)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        moveItHorizontal(ormH_1, 11)
        moveItHorizontal(ormH_2, 13)
        moveItVertical(ormN_1, 12)
        moveItVertical(ormN_2, 14)
    }
    
    @IBAction func playbuttonClicked(_ sender: Any) {
    }
    
    @IBAction func highscoresbuttonClicked(_ sender: Any) {
    }
    
    func moveItHorizontal(_ imageView: UIImageView,_  speed:CGFloat){
        let speeds = speed
        let imagespeed = speeds / view.frame.size.width
        let averageSpeed = (view.frame.size.width - imageView.frame.origin.x) * imagespeed
        
        UIView.animate(withDuration: TimeInterval(averageSpeed), delay: 0.0, options: .curveEaseInOut, animations: {
            imageView.frame.origin.x = self.view.frame.size.width
        }, completion: { (_) in
            imageView.frame.origin.x = -imageView.frame.size.width
            self.moveItHorizontal(imageView, speeds)
        })
    }
    
    func moveItVertical(_ imageView: UIImageView,_  speed:CGFloat){
        let speeds = speed
        let imagespeed = speeds / view.frame.size.height
        let averageSpeed = (view.frame.size.height - imageView.frame.origin.y) * imagespeed
        
        UIView.animate(withDuration: TimeInterval(averageSpeed), delay: 0.0, options: .curveLinear, animations: {
            imageView.frame.origin.y = self.view.frame.size.height
        }, completion: { (_) in
            imageView.frame.origin.y = -imageView.frame.size.height
            self.moveItVertical(imageView, speeds)
        })
    }
    
    @IBAction func prepareForUnwind(segue:UIStoryboardSegue){}
    
  

}
