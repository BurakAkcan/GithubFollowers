//
//  GFDataLoadingViewController.swift
//  GithubFollowers
//
//  Created by Burak AKCAN on 31.08.2022.
//

import UIKit

class GFDataLoadingViewController: UIViewController {
    var containerView : UIView!
    
    func showLoadingView(){
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0
        
        UIView.animate(withDuration: 0.2) {
            self.containerView.alpha = 0.8
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
            self.containerView.removeFromSuperview()
            self.containerView = nil
        }
 }
    func showEmtpyStateView(with message:String,in view:UIView){
        let emptyStateView = GFEmptyStateView(message: message,view:view)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }

   
}
