//
//  UIHelpers.swift
//  GithubFollowers
//
//  Created by Burak AKCAN on 22.08.2022.
//

import Foundation
import UIKit

struct UIHelpers {
    static func createThreeColumnFlowLayout(in view:UIView)->UICollectionViewFlowLayout{
        let width = view.bounds.width
        let padding:CGFloat = 12
        let minimumItemSpace:CGFloat = 10
        let availableWidth = width - (padding * 2) - (minimumItemSpace * 2)
        let itemWidth = availableWidth / 3
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
    
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth  , height: itemWidth + 40)
        
      
        
        
        
        return flowLayout
    }
}
