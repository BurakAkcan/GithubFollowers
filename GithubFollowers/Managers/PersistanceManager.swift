//
//  PersistanceManager.swift
//  GithubFollowers
//
//  Created by Burak AKCAN on 29.08.2022.
//

import Foundation

enum PersistanceActonType{
    case add,remove
}

enum PersistanceManager{
    
    enum Keys{
        static let favorites = "favorites"
    }
    
    static func updateWith(favorite:Follower,actionType:PersistanceActonType,completion:@escaping (AppError?)->Void){
        retrieveFavorites { result in
            switch result{
            case .success(let favorites):
                var retrieveFavorites = favorites //temp favorite list because favorite is immutable
                
                switch actionType {
                case .add:
                    guard !retrieveFavorites.contains(favorite) else{
                        #warning("Bug fix remove All")
                        completion(.alreadyFavoriteError) //Zaten böyle bir favori var
                        return
                    }
                    retrieveFavorites.append(favorite)
                case .remove:
                    retrieveFavorites.removeAll { $0.login == favorite.login}
                }
                completion(save(favorites: retrieveFavorites))
                //completion AppError dönderir zaten bizim save metodumuzda Apperror döndereceği için completion içine save metodu yazarız ekstra error döndermemize gerek kalmaz 
                
                case .failure(let error):
                  completion(error)
            }
        }
    }
    
    static func removeAll(){
        defaults.removeObject(forKey: Keys.favorites)
    }
    
    static private let defaults = UserDefaults.standard
    
    static func retrieveFavorites(completed:@escaping (Result<Followers,AppError>)->()){
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else{
            completed(.success([]))
            return}
        //Decoding
        let decoder = JSONDecoder()
        do {
            let favorites = try decoder.decode(Followers.self, from: favoritesData)
            completed(.success(favorites))
            
        } catch  {
            completed(.failure(.errorDecoding))
        }
    }
    static func save(favorites:Followers)->AppError?{
        let encoder = JSONEncoder()
        do{
         let savedData = try encoder.encode(favorites)
            defaults.set(savedData, forKey: Keys.favorites)
            return nil
            
         }catch  {
             return .unAbleToComplete
         }
       
    }
    
}


//var people:[Person] = []
//
//func saveUserDef(){
//    let encoder = JSONEncoder()
//    if let savedData = try? encoder.encode(people){
//        let defaults = UserDefaults.standard
//        defaults.set(savedData, forKey: "myList")
//    }else{
//        print("error")
//    }
//}
////reading USer Defaults
//
//let myDefaults = UserDefaults.standard
//
//if let myList = myDefaults.object(forKey:"myList") as? Data {
//    let decoder = JSONDecoder()
//    do{
//        activites = try decoder.decode([Aktivities].self, from: myList)
//    }catch{
//        print(error.localizedDescription)
//    }
//}
