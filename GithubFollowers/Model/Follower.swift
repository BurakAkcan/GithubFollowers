//
//  Follower.swift
//  GithubFollowers
//
//  Created by Burak AKCAN on 20.08.2022.
//


import Foundation

// MARK: - Follower
struct Follower: Codable,Hashable {
    let login: String
    let avatarURL: String
    

    enum CodingKeys: String, CodingKey {
        case login
        case avatarURL = "avatar_url"
        
    }
}

typealias Followers = [Follower]
