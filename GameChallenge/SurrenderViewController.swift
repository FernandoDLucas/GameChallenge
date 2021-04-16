//
//  SurrenderViewController.swift
//  GameChallenge
//
//  Created by Cecilia Soares on 09/04/21.
//

import UIKit
import SpriteKit
class SurrenderViewController: UIViewController {
    let surrenderView = SurrenderView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view = surrenderView
        
        
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }

}



//if let view = self.view as! SKView? {
//    // Load the SKScene from 'GameScene.sks'
//    let scene = SurrenderScene(size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
//
//    // Set the scale mode to scale to fit the window
//    scene.scaleMode = .aspectFit
//    //scene.size = view.frame.size
//
//    // Present the scene
//    view.presentScene(scene)
//    view.ignoresSiblingOrder = true
//
//    view.showsNodeCount = true
//}
