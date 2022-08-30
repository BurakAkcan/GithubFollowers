//
//  SearchVC.swift
//  GithubFollowers
//
//  Created by Burak AKCAN on 18.08.2022.
//

import UIKit

class SearchVC: UIViewController {
    let logoImage = UIImageView()
    let usernameTextField = GFTextField()
    let callActionButton = GFButton(backgroundColor: .systemGreen, title: "Get Followers")
    let customAlert = GFAlertVCViewController(title: "Error", message: "Please enter an username 🙃", buttonTitle: "Ok")
    var logoImageViewTopConstraint:NSLayoutConstraint!
    
    var isUserNameEntered:Bool{
        return !(usernameTextField.text!.isEmpty)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground //for dark andlight mode
        
        //hideKeyboard
        let gesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gesture)
        
        
        configureLogoImageView()
        configureTextField()
        configureActionButton()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setToolbarHidden(true, animated: true)
        usernameTextField.text = ""
        
    }
    
    
    //MARK: - Setup View
    
    
    func configureLogoImageView(){
        view.addSubview(logoImage)
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        if let logoImageName = UIImage(named: "gh-logo"){
            logoImage.image = logoImageName
        }
        let topConsraitConstant:CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 20 : 80
        
        logoImageViewTopConstraint = logoImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topConsraitConstant)
        logoImageViewTopConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            logoImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 80),
            logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImage.heightAnchor.constraint(equalToConstant: 200),
            logoImage.widthAnchor.constraint(equalToConstant: 200)
            
        ])
  }
    func configureTextField(){
        view.addSubview(usernameTextField)
        usernameTextField.delegate = self
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 48),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50)
            
            
        ])
    }
    
    func configureActionButton(){
        view.addSubview(callActionButton)
        callActionButton.addTarget(self, action: #selector(pushFollowerListVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            callActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -60),
            callActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            callActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            callActionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    //MARK: -Navigation
    
   @objc func pushFollowerListVC(){
       guard isUserNameEntered else{
          presentGFAlertOnMainThread(title: "Empty Username", message: "Please enter an username 😎.", buttonTitle: "Ok")
         return
           }
       usernameTextField.resignFirstResponder()
       let followersVC = FollowersVC()
       followersVC.username = usernameTextField.text
       followersVC.title = usernameTextField.text
       navigationController?.pushViewController(followersVC, animated: true)
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        usernameTextField.resignFirstResponder()
//    }
    @objc func hideKeyboard(){
        view.endEditing(true)
    }

  
}


extension SearchVC:UITextFieldDelegate{
    //How to do Tap press button
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
         pushFollowerListVC()//Same work button go to followersVC
        return true
    }
}
