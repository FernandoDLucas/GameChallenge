//
//  SurrenderView.swift
//  GameChallenge
//
//  Created by Cecilia Soares on 16/04/21.
//

import UIKit

class SurrenderView: UIView {

    lazy var blur: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .prominent)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return blurEffectView
    }()
    let modal: UIView = {
        let modalView = UIView()
        modalView.backgroundColor = .systemGray5
        modalView.layer.cornerRadius = 40
        modalView.translatesAutoresizingMaskIntoConstraints = false
        return modalView
    }()
    lazy var modalImage: UIImageView = {
        let modal = UIImageView()
        modal.translatesAutoresizingMaskIntoConstraints = false
        modal.image = UIImage(named: "bgEndGame")
        return modal
    
    }()
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont(name: "xilosa", size: 28)
        button.setTitle("Voltar", for: .normal)
        button.setTitleColor(.textAction, for: .normal)
        button.setImage(UIImage(named: "bgButtonBack"), for: .normal)
//        button.layer.cornerRadius = 16
//        button.layer.masksToBounds = false
        return button
    }()
    override init(frame: CGRect) {
        super.init(frame: .zero)
        addSubview(blur)
        addSubview(modalImage)
    }
    
    
//    MARK: Setup
    func setupModal(){
        NSLayoutConstraint.activate([
            modalImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            modalImage.centerYAnchor.constraint(equalTo: centerYAnchor)
        
        ])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
