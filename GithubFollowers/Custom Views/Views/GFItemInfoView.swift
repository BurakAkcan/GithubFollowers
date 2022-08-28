//
//  GFItemInfoView.swift
//  GithubFollowers
//
//  Created by Burak AKCAN on 28.08.2022.
//

import UIKit

enum ItemInfoType{
    case repos,gist,followers,following
}

//Sadece icon başlık ve sayı yazan kısmın viewını gerçekleştrdik

class GFItemInfoView: UIView {
    let symbolImageView = UIImageView()
    let titleLabel = GFTitleLabel(textAlign: .left, fontSize: 14)
    let countLabel = GFTitleLabel(textAlign: .center, fontSize: 14)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   private func configure(){
       addSubview(symbolImageView)
       addSubview(titleLabel)
       addSubview(countLabel)
       
       symbolImageView.translatesAutoresizingMaskIntoConstraints = false
       symbolImageView.contentMode = .scaleAspectFill
       symbolImageView.tintColor = .label
       
       NSLayoutConstraint.activate([
        symbolImageView.topAnchor.constraint(equalTo: self.topAnchor),
        symbolImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
        symbolImageView.heightAnchor.constraint(equalToConstant: 20),
        symbolImageView.widthAnchor.constraint(equalToConstant: 20),
        
        titleLabel.centerYAnchor.constraint(equalTo: symbolImageView.centerYAnchor),
        titleLabel.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor, constant: 12),
        titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        titleLabel.heightAnchor.constraint(equalToConstant: 18),
        
        countLabel.topAnchor.constraint(equalTo: symbolImageView.bottomAnchor,constant: 4),
        countLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
        countLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        countLabel.heightAnchor.constraint(equalToConstant: 18),
        
       ])
    }
    
    func set(itemInfoType:ItemInfoType,withCount count:Int){
        switch itemInfoType {
        case .repos:
            symbolImageView.image = UIImage(systemName: "folder")
            titleLabel.text = "Public Repos"
        case .gist:
            symbolImageView.image = UIImage(systemName: "text.alignleft")
            titleLabel.text = "Public Gist"
        case .followers:
            symbolImageView.image = UIImage(systemName: "person.2")
            titleLabel.text = "Followers"
        case .following:
            symbolImageView.image = UIImage(systemName: "heart")
            titleLabel.text = "Following"
        }
        countLabel.text = String(count)
    }
    
}
