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
    
    func getFollower(for username:String,page:Int,completion:@escaping (Result<Followers,AppError>)->Void){
        let endpoint = baseUrlString + "\(username)/followers?per_page=100&page=\(page)"
        guard let url = URL(string: endpoint) else{
            completion(.failure(.invalidUserName))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.unAbleToComplete))
            }
            
            guard let response = response as? HTTPURLResponse,
            response.statusCode  == 200
            else { completion(.failure(.invalidResponse))
                return
                }
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            do {
                let decoder = JSONDecoder()
                let followers = try decoder.decode(Followers.self, from: data)
                completion(.success(followers))
            } catch  {
                completion(.failure(.errorDecoding))
            }
            

            }
        task.resume()
    }
    
}

