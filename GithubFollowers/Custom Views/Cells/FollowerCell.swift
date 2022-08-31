//
//  FollowerCell.swift
//  GithubFollowers
//
//  Created by Burak AKCAN on 21.08.2022.
//

import UIKit

class FollowerCell: UICollectionViewCell {
    static let reuseID = "followerCell"
    
    //MARK: -Views
    let avaterImageView = GFAvatarImageView(frame: .zero)
    let usernameLabel = GFTitleLabel(textAlign: .center, fontSize: 16)
    
    let padding:CGFloat = 8
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(follower:Follower){
        usernameLabel.text = follower.login
        NetworkManager.shared.downloadImage(from: follower.avatarURL) { [weak self ](image) in
            DispatchQueue.main.async {
                self?.avaterImageView.image = image?.resizeImage(100, opaque: false)
            }
        }
        avaterImageView.contentMode = .scaleAspectFit
        avaterImageView.clipsToBounds = true
    }
    
    private func configure(){
        addSubview(avaterImageView)
        addSubview(usernameLabel)
        avaterImageView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        usernameLabel.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        avaterImageView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
       
        
        
        NSLayoutConstraint.activate([
            avaterImageView.topAnchor.constraint(equalTo:contentView.topAnchor, constant: padding),
            avaterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            avaterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            avaterImageView.heightAnchor.constraint(equalTo:avaterImageView.widthAnchor),
            
            
            
            usernameLabel.topAnchor.constraint(equalTo: avaterImageView.bottomAnchor, constant: 12),
            usernameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            usernameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 20)
            
            
        ])
       
        
    }
    
}

//contentView cell content
