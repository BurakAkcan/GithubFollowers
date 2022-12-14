//
//  GFEmptyStateView.swift
//  GithubFollowers
//
//  Created by Burak AKCAN on 24.08.2022.
//

import UIKit

class GFEmptyStateView: UIView {

    let messageLabel = GFTitleLabel(textAlign: .center, fontSize: 28)
    let logoImageView = UIImageView()
    
    var view:UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   convenience init(message:String,view:UIView){
        self.init(frame: .zero )
        messageLabel.text = message
        self.view = view
        
    }
    
    private func configure(){
        addSubview(messageLabel)
        addSubview(logoImageView)
        messageLabel.numberOfLines = 3
        messageLabel.textColor = .secondaryLabel
        logoImageView.image = UIImage(named: "empty-state-logo")!
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.contentMode = .scaleAspectFit
        
//        let height = view.frame.size.height
//        let width = view.frame.size.width
        
        NSLayoutConstraint.activate([
            messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -150),
            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            messageLabel.heightAnchor.constraint(equalToConstant: 200),
            
            //multiplier alınan view ın kaç katı size ında olsun
            logoImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            logoImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1.3),
            logoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 180),
            logoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 340)
             
          
        ])
    }
}
