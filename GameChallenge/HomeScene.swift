//
//  HomeScene.swift
//  GameChallenge
//
//  Created by Cecilia Soares on 06/04/21.
//

import UIKit
import GameplayKit
import GameKit

class HomeScene: SKScene {
    var playButton = SKSpriteNode()
    let playButtonTex = SKTexture(imageNamed: "BgPlay")
    let playText = SKLabelNode(fontNamed: "xilosa")
    
    override func didMove(to view: SKView) {
        
        NotificationCenter.default.addObserver(
          self,
          selector: #selector(presentGame(_:)),
          name: .presentGame,
          object: nil
        )
    
        NotificationCenter.default.addObserver(
          self,
          selector: #selector(authenticationChanged(_:)),
          name: .authenticationChanged,
          object: nil
        )
    
        let background = SKSpriteNode(imageNamed: "bgHome")
        background.position = CGPoint(x: size.width/2, y: size.height/2)
        background.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        background.zPosition = -1
        addChild(background)

        playButton = SKSpriteNode(texture: playButtonTex)
        playButton.position = CGPoint(x: size.width/2, y: size.height/2)
        playButton.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        playButton.zPosition = 1
        
        playText.text = "JOGAR"
        playText.fontSize = 28
        playText.zPosition = 2
        playText.verticalAlignmentMode = .center
        playText.horizontalAlignmentMode = .center
        playText.fontColor = SKColor.textAction
        playButton.isHidden = !GameCenterHelper.helper.isAuthenticated
        playText.isHidden = !GameCenterHelper.helper.isAuthenticated
        self.addChild(playButton)
        playButton.addChild(playText)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let pos = touch.location(in: self)
            let node = self.atPoint(pos)
            
            if node == playButton || node == playText {
                if view != nil {
                    GameCenterHelper.helper.presentMatchmaker()
                }
            }
        }
    }
    
    @objc func presentGame(_ notification: Notification) {
        guard let match = notification.object as? GKTurnBasedMatch else {
          return
        }
        loadModel(match: match)
    }
    
    @objc func authenticationChanged(_ notification: Notification) {
        if GameCenterHelper.helper.isAuthenticated {
            playButton.isHidden = false
            playText.isHidden = false
        }
    }
    
     func loadModel(match: GKTurnBasedMatch) {
      match.loadMatchData { data, _ in
        let model: GameModel
        
        if let data = data {
            
          do {
            model = try JSONDecoder().decode(GameModel.self, from: data)
            
          } catch {
            model = GameModel()
          }
        } else {
          model = GameModel()
        }
        
        GameCenterHelper.helper.currentMatch = match
        let transition: SKTransition
        transition = SKTransition.fade(withDuration: 1)
        let scene: SKScene = GameScene(size: self.size, model: model)
        self.view?.presentScene(scene, transition: transition)
      }
    }
}
