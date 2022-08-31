//
//  GFUserInfoHeaderVC.swift
//  GithubFollowers
//
//  Created by Burak AKCAN on 27.08.2022.
//

import UIKit

class GFUserInfoHeaderVC: UIViewController {
    
    let avatarImageView = GFAvatarImageView(frame: .zero)
    let usernameLabel = GFTitleLabel(textAlign: .left, fontSize: 34)
    let nameLabel = GFSeconaryTitleLabel(fontSize: 18)
    let iconImageView = UIImageView()
    let locationLabel = GFSeconaryTitleLabel(fontSize: 18)
    let bioLabel = GFBodyLabel(textAlign: .left)
    
    var user:User!
    
    init(user:User){
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubview()
        configure()
        layoutUI()

    }
    
    func configure(){
       
        downloadAvatarImage()
        usernameLabel.text      = user.login
        nameLabel.text          = user.name ?? "Not Available"
        locationLabel.text      = user.location ?? "No location"
        bioLabel.text           = user.bio ?? "No bio available"
        bioLabel.numberOfLines  = 3
        iconImageView.image     = UIImage(systemName: "mappin.and.ellipse")
        iconImageView.tintColor = .secondaryLabel
        
        
    }
    
    func downloadAvatarImage(){
        NetworkManager.shared.downloadImage(from: user.avatarURL) { [weak self](image) in
            DispatchQueue.main.async {
                self?.avatarImageView.image = image
            }
        }
    }
    
    func addSubview(){
        view.addSubview(avatarImageView)
        view.addSubview(nameLabel)
        view.addSubview(bioLabel)
        view.addSubview(usernameLabel)
        view.addSubview(iconImageView)
        view.addSubview(locationLabel)
    }
    #warning("nameLabel centeryAnchor dön")
    func layoutUI(){
        let padding:CGFloat = 20
        let textImagePadding:CGFloat = 12
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            avatarImageView.heightAnchor.constraint(equalToConstant: 90),
            avatarImageView.widthAnchor.constraint(equalToConstant: 90),
            
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            usernameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 38),
            
            
            nameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor,constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor,constant: textImagePadding),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            iconImageView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
            iconImageView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            iconImageView.heightAnchor.constraint(equalToConstant: 20),
            iconImageView.widthAnchor.constraint(equalToConstant: 20),
            
            locationLabel.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 5),
            locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            locationLabel.heightAnchor.constraint(equalToConstant: 20),
            
            bioLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: textImagePadding),
            bioLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
            bioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            bioLabel.heightAnchor.constraint(equalToConstant: 60)
  ])
    }
    
}
