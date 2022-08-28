//
//  GFRepoItemVC.swift
//  GithubFollowers
//
//  Created by Burak AKCAN on 28.08.2022.
//

import UIKit

class GFRepoItemVC:GFItemInfoVC{
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
     
    private func configureItems(){
        itemInfoViewOne.set(itemInfoType: .repos, withCount: user.publicRepos)
        itemInfoTwoView.set(itemInfoType: .gist, withCount: user.publicGist)
        actionButton.set(backgroundColor: .systemPurple, title: "Github Profile")
    }
}


