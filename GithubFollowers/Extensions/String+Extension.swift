//
//  String+Extension.swift
//  GithubFollowers
//
//  Created by Burak AKCAN on 19.08.2022.
//

import Foundation

extension String {
    var isValidEmail:Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: self)
        }
    
    var isPasswordValid:Bool{
        let passwordFormat = "(?=[^a-z]*[a-z])(?=[^0-9]*[0-9])[a-zA-Z0-9!@#$%^&*]{8,}"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordFormat)
        return passwordPredicate.evaluate(with: self)
    }
    
    func convertToDate()->Date?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier:"tr_TR")
        dateFormatter.timeZone = .current
        

        return dateFormatter.date(from: self)
    }
    
}
