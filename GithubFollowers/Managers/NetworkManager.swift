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
    
    func getFollower(for username:String,page:Int,completion:@escaping (Followers?,String?)->Void){
        let endpoint = baseUrlString + "\(username)/followers?per_page=100&page=\(page)"
        guard let url = URL(string: endpoint) else{
            completion(nil, "This username created an invalid request.")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
               completion(nil, "Unable to complete your request.")
            }
            
            guard let response = response as? HTTPURLResponse,
            response.statusCode  == 200
            else { completion(nil, "Invalid response from server ")
                return
                }
            guard let data = data else {
                completion(nil, "The data received from server was invalid")
                return
            }
            do {
                let decoder = JSONDecoder()
                let followers = try decoder.decode(Followers.self, from: data)
                completion(followers,nil)
            } catch  {
                completion(nil, "The data received from server was invalid")
            }
            

            }
        task.resume()
    }
    
}

