//
//  UIViewController+Extension.swift
//  GithubFollowers
//
//  Created by Burak AKCAN on 19.08.2022.
//

import UIKit

extension UIViewController{
   func presentGFAlertOnMainThread(title:String,message:String,buttonTitle:String){
       DispatchQueue.main.async {
           let alertVc = GFAlertVCViewController(title: title, message: message, buttonTitle: buttonTitle)
           alertVc.modalPresentationStyle = .overFullScreen
           alertVc.modalTransitionStyle = .crossDissolve
           self.present(alertVc, animated: true, completion: nil)
       }
    }
}

