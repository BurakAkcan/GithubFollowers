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
    var login: String
    var name:String?
    var avatarURL: String
    var location:String?
    var bio:String?
    var publicRepos:Int
    var publicGist:Int
    var htmlUrl:String
    var following:Int
    var followers:Int
    var createdAt:String
    

  


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
