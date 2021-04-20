//
//  Surrender.swift
//  GameChallenge
//
//  Created by Lidiane Gomes Barbosa on 25/03/21.
// swiftlint:disable unused_setter_value
import Foundation
import SpriteKit
protocol SurrenderDelegate: class {
    func surrenderTouch()
    
}
class Surrender: SKSpriteNode {
    weak var delegate: SurrenderDelegate?
    
    override var isUserInteractionEnabled: Bool {
        get {
            true

        }
        set {
            // ignore
        }
    }
   
    init(superView: SKView) {
        let texture = SKTexture(imageNamed: "surrender")
        super.init(texture: texture, color: .clear, size: SURRENDER_SIZE)
        self.position = CGPoint(x: superView.frame.width - (size.width / 2), y: superView.frame.height - (size.height / 2))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("render-se")
        self.delegate?.surrenderTouch()
            
    }
}
