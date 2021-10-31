//
//  DimaSignUpViewController.swift
//  Quesiti
//
//  Created by Дмитрий Голубев on 29.10.2021.
//

import UIKit

class DimaSignUpViewController: UIViewController {

    var signUpView: DimaSignUp!
    var name: String = ""
    var email: String = ""
    var password: String = ""
    var confirmPassword: String = ""

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
        signUpView.signInButtom.addTarget(self, action: #selector(clickSignInButton(_:)), for: .touchUpInside)
        signUpView.signUpButtom.addTarget(self, action: #selector(clickSignUpButton(_:)), for: .touchUpInside)
        if let theTextFieldName = signUpView.stack.viewWithTag(1) as? UITextField{
            theTextFieldName.addTarget(self, action: #selector(changeName(_:)), for: .editingChanged)
        }
        if let theTextFieldEmail = signUpView.stack.viewWithTag(2) as? UITextField{
            theTextFieldEmail.addTarget(self, action: #selector(changeEmail(_:)), for: .editingChanged)
        }
        if let theTextFieldPassword = signUpView.stack.viewWithTag(3) as? UITextField{
            theTextFieldPassword.addTarget(self, action: #selector(changePassword(_:)), for: .editingChanged)
        }
        
        if let theTextFieldConfirmPassword = signUpView.stack.viewWithTag(4) as? UITextField{
            theTextFieldConfirmPassword.addTarget(self, action: #selector(changeConfirmPassword(_:)), for: .editingChanged)
        }
        
        
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
    
    @objc func clickSignInButton(_ sender: Any) {
        let signInVC: SignInViewController = SignInViewController()
        present(signInVC, animated: true, completion: nil)
    }
    
    @objc func changeName(_ textField: UITextField){
        guard let text = textField.text else { return }
        name = text
    }
    
    @objc func changeEmail(_ textField: UITextField){
        guard let text = textField.text else { return }
        email = text
    }
    
    @objc func changePassword(_ textField: UITextField){
        guard let text = textField.text else { return }
        password = text
    }
    
    @objc func changeConfirmPassword(_ textField: UITextField){
        guard let text = textField.text else { return }
        confirmPassword = text
    }
    
    @objc func clickSignUpButton(_ sender: Any) {
        print("Вы ввели" , name, email, password, confirmPassword)
    }
    
}
