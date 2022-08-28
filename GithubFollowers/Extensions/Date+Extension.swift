//
//  Date+Extension.swift
//  GithubFollowers
//
//  Created by Burak AKCAN on 29.08.2022.
//

import Foundation

extension Date{
    func converToCustomDateFormat()->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
       // dateFormatter.locale = Locale(identifier: "tr_TR")
        return dateFormatter.string(from: self)
    }
}
