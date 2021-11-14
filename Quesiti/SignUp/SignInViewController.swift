//
//  DimaSignUpViewController.swift
//  Quesiti
//
//  Created by Дмитрий Голубев on 29.10.2021.
//

import UIKit
import Firebase

class SignInViewController: UIViewController {

    var signInView: SignInView!
    private var email: String = ""
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
            theTextFieldPassword.isSecureTextEntry = true
            theTextFieldPassword.addTarget(self, action: #selector(changePassword(_:)), for: .editingChanged)
        }
        signInView.signInButtom.addTarget(self, action: #selector(clickSignInButtom(_:)), for: .touchUpInside)
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
    
    private func showAlert(){
        let alert = UIAlertController(title: "Error", message: "Set all text fields", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @objc func changeLogin(_ textField: UITextField){
        guard let text = textField.text else { return }
        email = text
    }
    
    @objc func changePassword(_ textField: UITextField){
        guard let text = textField.text else { return }
        password = text
    }
    @objc func clickSignInButtom(_ textField: UITextField){
        print("Вы ввели", email, password)
        Auth.auth().signIn(withEmail: email.lowercased(), password: password) { result, error in
            if error == nil{
                let tabBarVC = TabBarViewController()
                tabBarVC.modalPresentationStyle = .fullScreen
                self.present(tabBarVC, animated: true, completion: nil)
                
            }
        }
    }
}
