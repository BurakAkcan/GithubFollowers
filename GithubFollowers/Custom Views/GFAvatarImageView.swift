//
//  GFAvatarImageView.swift
//  GithubFollowers
//
//  Created by Burak AKCAN on 21.08.2022.
//

import UIKit

class GFAvatarImageView: UIImageView {
    
    let cache = NetworkManager.shared.cache
    let placeHolderImage = UIImage(named: "ic_place_holder")!

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure(){
        layer.cornerRadius = 10
       
        clipsToBounds = true
        image = placeHolderImage
        translatesAutoresizingMaskIntoConstraints = false
        contentMode = .scaleAspectFit
            
        
    }
    
    func downloadImage(from urlString:String){
        //Convert string to NSString
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey){
            self.image = image.resizeImage(100, opaque: false)
            return
        }
        
        guard let url = URL(string: urlString) else {return}
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else{return}
             
            if error != nil {return}
            guard let response = response as? HTTPURLResponse,
            response.statusCode == 200 else {return}
            guard let data = data else {return}
            
            
            guard let image = UIImage(data: data) else{return}
            self.cache.setObject(image, forKey: cacheKey)
            
            DispatchQueue.main.async {
                self.image = image.resizeImage(100, opaque: false)
            }

        }
        task.resume()
    }
    

}
