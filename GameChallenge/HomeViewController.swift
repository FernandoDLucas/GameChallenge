//
//  HomeViewController.swift
//  GameChallenge
//
//  Created by Cecilia Soares on 06/04/21.
//

import UIKit
import SpriteKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            let scene = HomeScene(size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFit
            //scene.size = view.frame.size

            // Present the scene
            view.presentScene(scene)
            GameCenterHelper.helper.viewController = self
            view.ignoresSiblingOrder = true

            view.showsNodeCount = true
        }
        
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }


}
