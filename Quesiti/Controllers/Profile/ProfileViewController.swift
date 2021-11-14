//
//  ProfileViewController.swift
//  Quesiti
//
//  Created by Даниил Ярмоленко on 29.10.2021.
//

import UIKit

class ProfileViewController: UIViewController {
    var presenter: ProfileViewPresenter!
    
    var firstName: String = ""
    var secondName: String = ""
    var email: String = ""
    var phoneNumber: String = ""
    var city: String = ""
    var aboutYou: String = ""
    
    public let alex = ["firstName": "Scott", "secondName": "McCall", "email" : "alex@mail.ru", "phoneNumber": "", "city": "Beacon Hills", "aboutYou": "Teen Wolf"]
    
    lazy var profileView: ProfileView = {
        let profileView = ProfileView()
        
        return profileView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(profileView)
        navigationController?.navigationBar.isHidden = true
        
        setupLayoutProfileView()
        setupProfileView()
        registerForKeyboardNotification()
    }
    
    deinit{
        removeForKeyboardNotification()
    }
    
    private func setupProfileView(){
        if let theTextFieldFirstName = profileView.stackView.viewWithTag(1) as? UITextField{
            theTextFieldFirstName.text = alex["firstName"]
            firstName = alex["firstName"] ?? ""
            theTextFieldFirstName.addTarget(self, action: #selector(changeFirstName(_:)), for: .editingChanged)
        }
        if let theTextFieldSecondName = profileView.stackView.viewWithTag(2) as? UITextField{
            theTextFieldSecondName.text = alex["secondName"]
            secondName = alex["secondName"] ?? ""
            theTextFieldSecondName.addTarget(self, action: #selector(changeSecondName(_:)), for: .editingChanged)
        }
        if let theTextFieldEmail = profileView.stackView.viewWithTag(3) as? UITextField{
            theTextFieldEmail.text = alex["email"]
            email = alex["email"] ?? ""
            theTextFieldEmail.addTarget(self, action: #selector(changeEmail(_:)), for: .editingChanged)
        }
        if let theTextFieldPhoneNumber = profileView.stackView.viewWithTag(4) as? UITextField{
            theTextFieldPhoneNumber.text = alex["phoneNumber"]
            phoneNumber = alex["phoneNumber"] ?? ""
            theTextFieldPhoneNumber.addTarget(self, action: #selector(changePhoneNumber(_:)), for: .editingChanged)
        }
        
        if let theTextFieldCity = profileView.stackView.viewWithTag(5) as? UITextField{
            theTextFieldCity.text = alex["city"]
            city = alex["city"] ?? ""
            theTextFieldCity.addTarget(self, action: #selector(changeCity(_:)), for: .editingChanged)
        }
        
        if let theTextFieldAboutYou = profileView.stackView.viewWithTag(6) as? UITextField{
            theTextFieldAboutYou.text = alex["aboutYou"]
            aboutYou = alex["aboutYou"] ?? ""
            theTextFieldAboutYou.addTarget(self, action: #selector(changeAboutYou(_:)), for: .editingChanged)
        }
        
        profileView.changeInfoButton.addTarget(self, action: #selector(changeInfo(_:)), for: .touchUpInside)
    }
    
    private func setupLayoutProfileView(){
        profileView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileView.topAnchor.constraint(equalTo: view.topAnchor),
            profileView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
         ])
    }
    
    @objc func changeFirstName(_ textField: UITextField){
        guard let text = textField.text else { return }
        firstName = text
    }
    
    @objc func changeSecondName(_ textField: UITextField){
        guard let text = textField.text else { return }
        secondName = text
    }
    
    @objc func changeEmail(_ textField: UITextField){
        guard let text = textField.text else { return }
        email = text
    }
    
    @objc func changePhoneNumber(_ textField: UITextField){
        guard let text = textField.text else { return }
        phoneNumber = text
    }
    
    @objc func changeCity(_ textField: UITextField){
        guard let text = textField.text else { return }
        city = text
    }
    
    @objc func changeAboutYou(_ textField: UITextField){
        guard let text = textField.text else { return }
        aboutYou = text
    }
    
    @objc func changeInfo(_ sender: Any) {
        let alert = UIAlertController(title: "Типа полетело на сервер:", message: "\(firstName) \n \(secondName) \n \(email) \n \(phoneNumber) \n \(city) \n \(aboutYou)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func registerForKeyboardNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func removeForKeyboardNotification(){
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        let scrolSize = self.profileView.changeInfoButton.frame.maxY + keyboardSize.height - self.view.bounds.maxY + 8 + self.view.safeAreaInsets.top
        profileView.scrollView.contentSize = CGSize(width: profileView.bounds.width, height: profileView.bounds.height + scrolSize)
        profileView.scrollView.contentOffset = CGPoint(x: 0, y: scrolSize)
        profileView.scrollView.isScrollEnabled = true
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        profileView.scrollView.contentSize = CGSize(width: profileView.bounds.width, height: profileView.bounds.height - keyboardSize.height)
        profileView.scrollView.isScrollEnabled = false
    }
}
