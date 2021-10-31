//
//  DimaSignUpViewController.swift
//  Quesiti
//
//  Created by Дмитрий Голубев on 29.10.2021.
//

import UIKit

class SignInViewController: UIViewController {

    var signInView: SignInView!
    private var login: String = ""
    private var password: String = ""

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
        if let theTextFieldLogin = signInView.stack.viewWithTag(1) as? UITextField{
            theTextFieldLogin.addTarget(self, action: #selector(changeLogin(_:)), for: .editingChanged)
        }
        if let theTextFieldPassword = signInView.stack.viewWithTag(2) as? UITextField{
            theTextFieldPassword.addTarget(self, action: #selector(changePassword(_:)), for: .editingChanged)
        }
        signInView.signInButtom.addTarget(self, action: #selector(signIn(_:)), for: .touchUpInside)
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
    
    @objc func changeLogin(_ textField: UITextField){
        guard let text = textField.text else { return }
        login = text
    }
    
    @objc func changePassword(_ textField: UITextField){
        guard let text = textField.text else { return }
        password = text
    }
    @objc func signIn(_ textField: UITextField){
        print("Вы ввели", login, password)
    }
    
}
