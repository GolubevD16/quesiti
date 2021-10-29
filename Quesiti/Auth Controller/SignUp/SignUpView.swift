//
//  SignUpView.swift
//  Quesiti
//
//  Created by Даниил Ярмоленко on 29.10.2021.
//

import UIKit
import SkyFloatingLabelTextField

class SignUpView: UIView {

    var controller: SignUpViewController!
    var nameTextField = SkyFloatingLabelTextField()
    var surnameTextField = SkyFloatingLabelTextField()
    
    
    var emailTextField = SkyFloatingLabelTextField()
    var passwordTextField = SkyFloatingLabelTextField()
    var confirmPassword = SkyFloatingLabelTextField()
    var signUpLabel = UILabel()
    
    // ---------------------------------------------------------------------------------------------------------------------------------------------------- //
    
    init(_ controller: SignUpViewController) {
        super.init(frame: .zero)
        self.controller = controller
        setupRegisterView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupRegisterView() {
        controller.view.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false
        let width = controller.view.frame.width
        let height = controller.view.frame.height
        let constraints = [
            heightAnchor.constraint(equalToConstant: CGFloat(height)),
            widthAnchor.constraint(equalToConstant: width),
            topAnchor.constraint(equalTo: controller.view.topAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        backgroundColor = .white
        setupSignUpLabel()
        setupNameTextField()
//        setupSurnameTextField()
        setupEmailTextField()
        setupPasswordTextField()
        setupConfirmPasswordTextField()
        
    }
    func setupSignUpLabel(){
        let signUpLabel = UILabel()
        addSubview(signUpLabel)
        let labelString = "Sign up"
               let textColor: UIColor = .black
               let underLineColor: UIColor = .cyan
        let underLineStyle = NSUnderlineStyle.single.rawValue

        let labelAtributes:[NSAttributedString.Key : Any]  = [
            NSAttributedString.Key.foregroundColor: textColor,
            NSAttributedString.Key.underlineStyle: underLineStyle,
            NSAttributedString.Key.underlineColor: underLineColor
               ]

               let underlineAttributedString = NSAttributedString(string: labelString,
                                                                  attributes: labelAtributes)

        signUpLabel.attributedText = underlineAttributedString
        signUpLabel.translatesAutoresizingMaskIntoConstraints = false
        signUpLabel.textAlignment = .center
        signUpLabel.font = UIFont.boldSystemFont(ofSize: 10)
        let constraints = [
            signUpLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            signUpLabel.topAnchor.constraint(equalTo: topAnchor, constant: 50)
        ]
        NSLayoutConstraint.activate(constraints)
//        signUpLabel.alpha = 0
    }
    
    func setupNameTextField(){
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.placeholder = "Name"
        nameTextField.title = "First name"
        nameTextField.font = UIFont.systemFont(ofSize: 10)
//        nameTextField.delegate = controller
        nameTextField.selectedLineColor = .cyan
        nameTextField.lineColor = .systemGray5
        nameTextField.textContentType = .oneTimeCode
        addSubview(nameTextField)
        let constraints = [
            nameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            nameTextField.topAnchor.constraint(equalTo: topAnchor, constant: 100),
            nameTextField.widthAnchor.constraint(equalToConstant: controller.view.frame.width - 60),
            nameTextField.heightAnchor.constraint(equalToConstant: 50)
            ]
    
        NSLayoutConstraint.activate(constraints)
    }

    func setupEmailTextField() {
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.placeholder = "Email"
        emailTextField.title = "Email"
        emailTextField.font = UIFont.systemFont(ofSize: 10)
        emailTextField.selectedLineColor = .blue
        emailTextField.selectedLineColor = .cyan
        emailTextField.lineColor = .systemGray5
        emailTextField.autocapitalizationType = .none
        emailTextField.autocorrectionType = .no
        emailTextField.textContentType = .oneTimeCode
        addSubview(emailTextField)
        let constraints = [
            emailTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            emailTextField.widthAnchor.constraint(equalToConstant: controller.view.frame.width - 60),
            emailTextField.heightAnchor.constraint(equalToConstant: 50)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func setupPasswordTextField() {
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.placeholder = "Password"
        passwordTextField.title = "Password"
        passwordTextField.selectedLineColor = .cyan
        passwordTextField.font = UIFont.systemFont(ofSize: 10)
//        passwordTextField.delegate = controller
        passwordTextField.selectedLineColor = .blue
        passwordTextField.lineColor = .systemGray5
        passwordTextField.autocorrectionType = .no
        passwordTextField.isSecureTextEntry = true
        passwordTextField.textContentType = .oneTimeCode
        addSubview(passwordTextField)
        let constraints = [
            passwordTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.widthAnchor.constraint(equalToConstant: controller.view.frame.width - 60),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    func setupConfirmPasswordTextField() {
        confirmPassword.translatesAutoresizingMaskIntoConstraints = false
        confirmPassword.placeholder = "Confirm password"
        confirmPassword.title = "Confirm"
        confirmPassword.selectedLineColor = .cyan
        confirmPassword.font = UIFont.systemFont(ofSize: 10)
//        confirmPassword.delegate = controller
        confirmPassword.selectedLineColor = .blue
        confirmPassword.lineColor = .systemGray5
        confirmPassword.autocorrectionType = .no
        confirmPassword.isSecureTextEntry = true
        confirmPassword.textContentType = .oneTimeCode
        addSubview(confirmPassword)
        let constraints = [
            confirmPassword.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            confirmPassword.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            confirmPassword.widthAnchor.constraint(equalToConstant: controller.view.frame.width - 60),
            confirmPassword.heightAnchor.constraint(equalToConstant: 50)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
