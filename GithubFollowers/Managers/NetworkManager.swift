//
//  NetworkManager.swift
//  GithubFollowers
//
//  Created by Burak AKCAN on 20.08.2022.
//

import Foundation
import UIKit


class NetworkManager{
    static let shared = NetworkManager()
   private let baseUrlString = "https://api.github.com/users/"
    let cache = NSCache<NSString,UIImage>()
    
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
    
    func getUser(for userName:String,completion:@escaping(Result<User,UserError>)->Void){
        let endpoint = baseUrlString + "\(userName)"
        guard let url = URL(string: endpoint) else{
            completion(.failure(.urlError))
            return
            }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.urlError))
            }
            guard let response = response as? HTTPURLResponse,
                  response.statusCode == 200 else{
                completion(.failure(.invalidUserResponse))
                return}
            guard let data = data else {
                completion(.failure(.invaliUserData))
                return
            }
            do {
                let decoder = JSONDecoder()
                let user = try decoder.decode(User.self, from: data)
                completion(.success(user))
            } catch  {
                completion(.failure(.errorDecodingUser))
            }
        }
        task.resume()
     }
    
    func downloadImage(from urlString:String,completion:@escaping(UIImage?)->Void){
        //Convert string to NSString
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey){
            completion(image)
            return
        }
        
        guard let url = URL(string: urlString) else {return}
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self,
                  error == nil,
                  let response = response as? HTTPURLResponse,
                  response.statusCode == 200,
                  let data = data,
                  let image = UIImage(data: data) else{completion(nil)
                  return
            }
                
                  
    
            self.cache.setObject(image, forKey: cacheKey)
            completion(image)
        }
        task.resume()
    }
    
}

