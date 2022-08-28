//
//  GFFollowerItemVC.swift
//  GithubFollowers
//
//  Created by Burak AKCAN on 28.08.2022.
//

import UIKit

class GFFollowerItemVC:GFItemInfoVC{
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
   
    private func configureItems(){
        itemInfoViewOne.set(itemInfoType: .following, withCount: user.following)
        itemInfoTwoView.set(itemInfoType: .followers, withCount: user.followers)
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }
}
