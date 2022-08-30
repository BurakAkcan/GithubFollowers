//
//  FavoriteCell.swift
//  GithubFollowers
//
//  Created by Burak AKCAN on 30.08.2022.
//

import UIKit

class FavoriteCell: UITableViewCell {
    static let reuseId = "favoriteCell"
    
    let avatarImageView = GFAvatarImageView(frame: .zero)
    let nameLabel = GFTitleLabel(textAlign: .left, fontSize: 26)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(favorite:Follower){
        avatarImageView.downloadImage(from: favorite.avatarURL)
        nameLabel.text = favorite.login
    }
    
    private func configure(){
        addSubview(avatarImageView)
        addSubview(nameLabel)
        
        accessoryType = .disclosureIndicator
        let padding:CGFloat = 12
        
        NSLayoutConstraint.activate([
            avatarImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            avatarImageView.heightAnchor.constraint(equalToConstant: 60),
            avatarImageView.widthAnchor.constraint(equalToConstant: 60),
            
            nameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 24),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            nameLabel.heightAnchor.constraint(equalToConstant: 40)
            
        ])
    }
    
    

}
