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
    
    init(message:String,view:UIView){
        super.init(frame: .zero )
        messageLabel.text = message
        self.view = view
        configure()
    }
    
    private func configure(){
        addSubview(messageLabel)
        addSubview(logoImageView)
        messageLabel.numberOfLines = 3
        messageLabel.textColor = .secondaryLabel
        logoImageView.image = UIImage(named: "empty-state-logo")!
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        #warning("AspectFit değişebilir tasarıma göre")
        logoImageView.contentMode = .scaleAspectFit
        
        let height = view.frame.size.height
        let width = view.frame.size.width
        
        NSLayoutConstraint.activate([
            messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -(height*0.2)),
            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: width*0.02),
            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -(width*0.02)),
            messageLabel.heightAnchor.constraint(equalToConstant: 200),
            
            //multiplier alınan view ın kaç katı size ında olsun
            logoImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            logoImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1.3),
            logoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: width*0.4),
            logoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: height*0.4)
             
          
        ])
    }
}
