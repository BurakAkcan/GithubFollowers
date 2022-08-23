//
//  UIViewController+Extension.swift
//  GithubFollowers
//
//  Created by Burak AKCAN on 19.08.2022.
//

import UIKit
fileprivate var containerView:UIView!

extension UIViewController{
   func presentGFAlertOnMainThread(title:String,message:String,buttonTitle:String){
       DispatchQueue.main.async {
           let alertVc = GFAlertVCViewController(title: title, message: message, buttonTitle: buttonTitle)
           alertVc.modalPresentationStyle = .overFullScreen
           alertVc.modalTransitionStyle = .crossDissolve
           self.present(alertVc, animated: true, completion: nil)
       }
    }
    
    func showLoadingView(){
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0
        
        UIView.animate(withDuration: 0.2) {
            containerView.alpha = 0.8
        }
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
          ])
        activityIndicator.startAnimating()
    }
    
    func dismissLoading(){
        //oluşturulan view direkt kaldırıldı ve memory leak oluşturmaması için nil atadık
        
        DispatchQueue.main.async {
            containerView.removeFromSuperview()
            containerView = nil
        }
        
      
    }
}

