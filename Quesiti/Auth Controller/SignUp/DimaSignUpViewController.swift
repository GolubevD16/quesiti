//
//  DimaSignUpViewController.swift
//  Quesiti
//
//  Created by Дмитрий Голубев on 29.10.2021.
//

import UIKit

class DimaSignUpViewController: UIViewController {

    var signUpView: DimaSignUp!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayoutProfileView()
    }
    
    override func loadView() {
        super.loadView()
        setupSignUp()
    }
    
    private func setupSignUp() {
        signUpView = DimaSignUp(frame: self.view.frame)
        signUpView.signInButtom.addTarget(self, action: #selector(clickButton(_:)), for: .touchUpInside)
        
        view.addSubview(signUpView)
        
    }
    
    private func setupLayoutProfileView() {
        signUpView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            signUpView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            signUpView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            signUpView.topAnchor.constraint(equalTo: view.topAnchor),
            signUpView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
         ])
    }
    
    @objc func clickButton(_ sender: Any) {
        let signInVC: SignInViewController = SignInViewController()
        //signInVC.modalPresentationStyle = .fullScreen
        present(signInVC, animated: true, completion: nil)
    }

}
