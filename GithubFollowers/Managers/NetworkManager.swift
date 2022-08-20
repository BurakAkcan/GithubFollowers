//
//  NetworkManager.swift
//  GithubFollowers
//
//  Created by Burak AKCAN on 20.08.2022.
//

import Foundation


class NetworkManager{
    static let shared = NetworkManager()
    let baseUrlString = "https://api.github.com/users/"
    
    private init(){}
    
    func getFollower(for username:String,page:Int,completion:@escaping (Followers?,AppError?)->Void){
        let endpoint = baseUrlString + "\(username)/followers?per_page=100&page=\(page)"
        guard let url = URL(string: endpoint) else{
            completion(nil,.invalidUserName)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(nil, .unAbleToComplete)
            }
            
            guard let response = response as? HTTPURLResponse,
            response.statusCode  == 200
            else { completion(nil,.invalidResponse)
                return
                }
            guard let data = data else {
                completion(nil, .invalidData)
                return
            }
            do {
                let decoder = JSONDecoder()
                let followers = try decoder.decode(Followers.self, from: data)
                completion(followers,nil)
            } catch  {
                completion(nil,.errorDecoding   )
            }
            

            }
        task.resume()
    }
    
}

