//
//  GFBodyLabel.swift
//  GithubFollowers
//
//  Created by Burak AKCAN on 19.08.2022.
//

import UIKit

class GFBodyLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   convenience init(textAlign:NSTextAlignment){
        self.init(frame: .zero)
        self.textAlignment = textAlign
        
        
    }
    
    private func configure(){
        textColor = .secondaryLabel //Gray
        font = UIFont.preferredFont(forTextStyle: .body)
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.75
        lineBreakMode = .byWordWrapping
        translatesAutoresizingMaskIntoConstraints = false
        
        
    }
}
