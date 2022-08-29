//
//  GFItemInfoVC.swift
//  GithubFollowers
//
//  Created by Burak AKCAN on 28.08.2022.
//

import UIKit

protocol UserInfoVCDelegate:AnyObject{
    func didTapGithubProfile(for user:User)
    func didTapGetFollowers(for user:User)
}

class GFItemInfoVC: UIViewController {
    
    let stackView = UIStackView()
    let itemInfoViewOne = GFItemInfoView()
    let itemInfoTwoView = GFItemInfoView()
    let actionButton = GFButton()
    
    var user:User!
    //GFItemInfoRepo sınıfının üst sınıfı burası o yüzden delaget değişkenimizi buraya yazıyoruz
   weak var delegate:UserInfoVCDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackground()
        layoutUI()
        cofigureStackView()
        configureActionButton()

    }
    
  
    
    init(user:User){
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   private func configureBackground(){
        view.layer.cornerRadius = 18
        view.backgroundColor = .secondarySystemBackground
    }
    
    private func cofigureStackView(){
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        stackView.addArrangedSubview(itemInfoViewOne)
        stackView.addArrangedSubview(itemInfoTwoView)
    }
    
    private func configureActionButton(){
        actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
    }
    @objc func actionButtonTapped(){
        
    }
    
    private func layoutUI(){
        view.addSubview(stackView)
        view.addSubview(actionButton)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        let padding:CGFloat = 20
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            
            actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44),
            
            
            
        ])
    }
}
