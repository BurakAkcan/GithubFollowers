//
//  GFSeconaryTitleLabel.swift
//  GithubFollowers
//
//  Created by Burak AKCAN on 27.08.2022.
//

import UIKit

class GFSeconaryTitleLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   convenience init(fontSize:CGFloat){
        self.init(frame: .zero)
        self.font = UIFont.systemFont(ofSize: fontSize,weight: .medium)
        
    }
    func configure(){
        textColor = .secondaryLabel
        lineBreakMode = .byWordWrapping
        minimumScaleFactor = 0.9
        translatesAutoresizingMaskIntoConstraints = false
        adjustsFontSizeToFitWidth = true
        lineBreakMode = .byTruncatingTail //... 
    }
    
}
