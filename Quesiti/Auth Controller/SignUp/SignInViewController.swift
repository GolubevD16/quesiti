//
//  DimaSignUpViewController.swift
//  Quesiti
//
//  Created by Дмитрий Голубев on 29.10.2021.
//

import UIKit

class SignInViewController: UIViewController {

    var signInView: SignInView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayoutProfileView()
    }
    
    override func loadView() {
        super.loadView()
        setupSignIn()
    }
    
    
    private func setupSignIn(){
        signInView = SignInView(frame: self.view.frame)
        view.addSubview(signInView)
    }
    
    private func setupLayoutProfileView() {
        signInView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            signInView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            signInView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            signInView.topAnchor.constraint(equalTo: view.topAnchor),
            signInView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
         ])
    }

}
