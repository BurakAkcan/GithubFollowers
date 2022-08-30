//
//  GFTextField.swift
//  GithubFollowers
//
//  Created by Burak AKCAN on 19.08.2022.
//

import UIKit

class GFTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 10
        layer.borderWidth = 2
       
        layer.borderColor = UIColor.systemGray4.cgColor
        // UIColor.label dark mode ve light mode özelliği içerir
        textColor = .label
        tintColor = .label
        textAlignment = .center
        font = UIFont.preferredFont(forTextStyle: .title2)
        adjustsFontSizeToFitWidth = true
        //Klavyedeki return tuşu go tuşu ile değiştirildi
        returnKeyType = .go
        minimumFontSize = 12
        
        backgroundColor = .tertiarySystemBackground
        autocorrectionType = .no
        clearButtonMode = .whileEditing//Yanda çıkn tümünü sil butonu 
        placeholder = "Enter a username"
    }

}
