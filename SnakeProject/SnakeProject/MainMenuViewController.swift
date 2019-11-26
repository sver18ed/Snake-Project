//
//  MainMenuViewController.swift
//  SnakeProject
//
//  Created by Erik Sveningsson on 2019-11-15.
//  Copyright © 2019 Erik Sveningsson. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {

    @IBOutlet weak var ormH: UIImageView!
    @IBOutlet weak var orm2H: UIImageView!
    @IBOutlet weak var ormN: UIImageView!
    @IBOutlet weak var orm2N: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        moveItHorizontal(ormH, 11)
        moveItHorizontal(orm2H, 13)
        moveItVertical(ormN, 12)
        moveItVertical(orm2N, 14)
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
