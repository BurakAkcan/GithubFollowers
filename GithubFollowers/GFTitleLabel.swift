//
//  GFTitleLabel.swift
//  GithubFollowers
//
//  Created by Burak AKCAN on 19.08.2022.
//

import UIKit

class GFTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(textAlign:NSTextAlignment,fontSize:CGFloat){
        super.init(frame: .zero)
        self.textAlignment = textAlign
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
        configure()
    }
    
   private func configure(){
       textColor = .label
       adjustsFontSizeToFitWidth = true
       minimumScaleFactor = 0.9
       //Labelın texti sğmazsa ynına ... yazdırmak istersek lineBreakMode kullanırız
       lineBreakMode = .byTruncatingTail
       translatesAutoresizingMaskIntoConstraints = false
    }

}
