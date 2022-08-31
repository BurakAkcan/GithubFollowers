//
//  User.swift
//  GithubFollowers
//
//  Created by Burak AKCAN on 20.08.2022.
//

import Foundation
import UIKit


// MARK: - User
struct User: Codable {
    let login: String
    let avatarURL: String
    let name:String?
    var location:String?
    var bio:String?
    let publicRepos:Int
    let publicGist:Int
    let htmlUrl:String
    let following:Int
    let followers:Int
    let createdAt:String
    

  enum CodingKeys: String, CodingKey {
        
        case login
        case name
        case avatarURL = "avatar_url"
        case location
        case bio
        case publicRepos = "public_repos"
        case publicGist = "public_gists"
        case htmlUrl = "html_url"
        case following
        case followers
        case createdAt = "created_at"
        
   
    }
}
