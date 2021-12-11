//
//  addQuestionTwoVC.swift
//  Quesiti
//
//  Created by Даниил Ярмоленко on 13.11.2021.
//

import UIKit
import SwiftUI
import Firebase

class addQuestionTwoVC:  UIViewController, SwiftyTextViewDelegate{
    
    //для отправки на сервер
    var questionTitle = ""
    var questionText = ""
    var questionUser: User?
    var questionLatitude: Double = 0
    var questionLongitude: Double = 0
    var questionAdress = ""
    var questionRadius: Int = 0
    var imageString: String = ""
    var delegatText: SwiftyTextViewDelegate?
    var MVCont = MapViewController()
    //    var passedData = Question(title: "Какая погода", userID: "bjhksdf23", latitude: 24.865, longitude: 67.0011, radius: 1000, image: UIImage(systemName: "people1"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupViews()
    }
    
    
    func setupViews() {
        textViewSetUp()
        
        labelAdress.text = self.questionAdress
        labelRadius.text = "Radius = \(self.questionRadius) m"
        
        [textViewTitle, textViewText, btnBack, btnAsk, labelAdress, labelRadius].forEach{
            view.addSubview($0)
        }
//        containerView.addSubview(textfieldView)
        
        NSLayoutConstraint.activate([
//            containerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 130),
//            containerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
//            containerView.widthAnchor.constraint(equalToConstant: view.frame.width - 40),
//            containerView.heightAnchor.constraint(equalToConstant: view.frame.height/2.5),
//
//            textfieldView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 22),
//            textfieldView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -13),
//            textfieldView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor,constant: -22),
//            textfieldView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 13),
//
            btnBack.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
            btnBack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            btnBack.widthAnchor.constraint(equalToConstant: 36),
            btnBack.heightAnchor.constraint(equalTo: btnBack.widthAnchor),
            
            btnAsk.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            btnAsk.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            btnAsk.widthAnchor.constraint(equalToConstant: 150),
            btnAsk.heightAnchor.constraint(equalToConstant: 50),
            
            labelRadius.topAnchor.constraint(equalTo: textViewText.bottomAnchor, constant: 10),
            labelRadius.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            labelRadius.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            labelRadius.heightAnchor.constraint(equalToConstant: 20),
            
            labelAdress.topAnchor.constraint(equalTo: labelRadius.bottomAnchor, constant: 5),
            labelAdress.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            labelAdress.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            labelAdress.heightAnchor.constraint(equalToConstant: 50)
//
//            anonimLabel.topAnchor.constraint(equalTo: labelAdress.bottomAnchor, constant: 25),
//            anonimLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
//            anonimLabel.heightAnchor.constraint(equalToConstant: 44),
//            anonimLabel.widthAnchor.constraint(equalToConstant: 100),
//
//            btnAnonim.topAnchor.constraint(equalTo: anonimLabel.topAnchor),
//            btnAnonim.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40),
//            btnAnonim.heightAnchor.constraint(equalToConstant: 40),
//            btnAnonim.widthAnchor.constraint(equalTo: btnAnonim.heightAnchor)
        
        ])
        
    }
    //
    //Поле ввода текста
//    let textfieldView: UITextField = {
//        let textfield = UITextField()
//        textfield.placeholder="Write your question"
//        textfield.textAlignment = .left
//        textfield.contentVerticalAlignment = .top
//        textfield.font = .systemFont(ofSize: 25)
//        textfield.translatesAutoresizingMaskIntoConstraints = false
//        textfield.addTarget(self, action: #selector(questionChange(_:)), for: .editingChanged)
//        return textfield
//    }()
    func textViewSetUp(){
        
        textViewTitle.font = .systemFont(ofSize: 20)
        textViewTitle.textContainer.lineFragmentPadding = 10.0
        textViewTitle.textContainer.lineBreakMode = .byCharWrapping
        textViewTitle.layer.cornerRadius = 20
        textViewTitle.layer.borderWidth = 0.5
        textViewTitle.layer.borderColor = UIColor.black.cgColor
        textViewTitle.placeholder = "Please, input your answer"
        textViewTitle.showTextCountView = true
        textViewText.swiftyDelegate = delegatText
        textViewTitle.swiftyDelegate = self
        textViewTitle.minNumberOfWords = 0
        textViewTitle.maxNumberOfWords = 64
        
        textViewText.font = .systemFont(ofSize: 20)
        textViewText.textContainer.lineFragmentPadding = 10.0
        textViewText.layer.cornerRadius = 20
        textViewText.layer.borderWidth = 0.5
        textViewText.showTextCountView = false
        textViewText.layer.borderColor = UIColor.black.cgColor
        textViewText.placeholder = "Please, input your answer"
    }
    func textViewDidChange(_ textView: UITextView) {
        questionTitle = textViewTitle.text
        questionText = textViewText.text
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        questionText = textViewText.text
        questionTitle = textViewTitle.text
        questionText = textViewText.text
        
    }
     func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard text.rangeOfCharacter(from: CharacterSet.newlines) == nil else {
             textView.resignFirstResponder() // uncomment this to close the keyboard when return key is pressed
            return false
        }

        return true
    }
       
    
    var textViewTitle: SwiftyTextView = SwiftyTextView.init(frame: CGRect.init(x: 20, y: 120, width: 350, height: 100))
    var textViewText: SwiftyTextView = SwiftyTextView.init(frame: CGRect.init(x: 20, y: 240, width: 350, height: 300))
    // Контрейнер для эффектов
    let containerView: UIView = {
        let v=UIView()
        v.backgroundColor = .white
        v.layer.cornerRadius = 20
        v.layer.shadowColor = UIColor.black.cgColor
        v.layer.shadowOpacity = 0.5
        v.layer.shadowOffset = .zero
        v.layer.shadowRadius = 5
        v.translatesAutoresizingMaskIntoConstraints=false
        return v
    }()
    //Текст адреса
    let labelAdress: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.font = .systemFont(ofSize: 15)
        lbl.textColor = .systemGray
        lbl.textAlignment = .center
        lbl.text = "Ошибка загрузки"
        lbl.translatesAutoresizingMaskIntoConstraints=false
        return lbl
    }()
    
    //Текст радиуса
    let labelRadius: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 18)
        lbl.textColor = .black
        lbl.textAlignment = .center
        lbl.text = "Ошибка загрузки"
        lbl.translatesAutoresizingMaskIntoConstraints=false
        return lbl
    }()
    
    //Кнопка возвращения назад
    let btnBack: UIButton = {
        let btn=UIButton()
        btn.backgroundColor = ThemeColors.graySimple
        btn.layer.shadowColor = UIColor.black.cgColor
        //        btn.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        btn.layer.shadowOffset = .zero
        btn.layer.masksToBounds = false
        btn.layer.shadowRadius = 20
        btn.layer.shadowOpacity = 1
        let config = UIImage.SymbolConfiguration(pointSize: 20)
        btn.setImage(UIImage(systemName: "chevron.left", withConfiguration: config), for: .normal)
        btn.layer.cornerRadius = 20
        btn.clipsToBounds=true
        btn.imageView?.tintColor=UIColor.black
        btn.addTarget(self, action: #selector(btnBackAction(_:)), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints=false
        return btn
    }()
    //Кнопка задавания вопроса
    let btnAsk: UIButton = {
        let btn=UIButton()
        btn.backgroundColor = UIColor.systemBlue
        btn.setTitle("Ask",
                     for: .normal)
        btn.setTitleColor(.white,
                          for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        btn.layer.cornerRadius = 25
        btn.clipsToBounds=true
        //        btn.tintColor = UIColor.gray
        btn.imageView?.tintColor=UIColor.blue
        btn.addTarget(self, action: #selector(btnAsk(_:)), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints=false
        return btn
    }()
//    private var anonimState:Bool = false // состояние аноним
//
//    //Текст анонимный вопрос
//    let anonimLabel: UILabel = {
//        let lbl = UILabel()
//        lbl.text = "Anonim"
//        lbl.font = .systemFont(ofSize: 24)
//        lbl.translatesAutoresizingMaskIntoConstraints=false
//        return lbl
//    }()
//    //Кнопка только для подписчиков
//
//    //Кнопка анонимный вопрос
//    let btnAnonim: UIButton = {
//        let btn = UIButton()
//
//        let config = UIImage.SymbolConfiguration(pointSize: 40)
//        btn.setImage(UIImage(systemName: "chevron.down.circle", withConfiguration: config), for: .normal)
//        btn.backgroundColor = .clear
//        btn.tintColor = .black
//        btn.layer.opacity = 0.25
//        btn.translatesAutoresizingMaskIntoConstraints=false
//        btn.addTarget(self, action: #selector(anonimStateAction(_:)), for: .touchUpInside)
//        return btn
//    }()
//
//
//    @objc func anonimStateAction(_ sender: UIButton!){
//        let config = UIImage.SymbolConfiguration(pointSize: 40)
//
//        if !anonimState {
//            btnAnonim.setImage(UIImage(systemName: "chevron.down.circle.fill", withConfiguration: config), for: .normal)
//            btnAnonim.tintColor = ThemeColors.mainColor
//            btnAnonim.layer.opacity = 1
//            anonimState = true
//        }
//        else {
//
//            btnAnonim.setImage(UIImage(systemName: "chevron.down.circle", withConfiguration: config), for: .normal)
//            btnAnonim.tintColor = .black
//            btnAnonim.layer.opacity = 0.25
//            anonimState = false
//        }
//    }
//
    @objc func btnBackAction(_ sender: Any){
        self.transitionOutVc(duration: 0.5, type: .fromLeft)
    }
    
    @objc func btnAsk(_ sender: Any){
        self.questionText = textViewText.text
        guard let uid = Auth.auth().currentUser?.uid else { return }
            Database.database().fetchUser(withUID: uid) { (user) in
                Database.database().addQuestion(titleQuestion: self.questionTitle, textQuestion: self.questionText, latitude: self.questionLatitude, longitude: self.questionLongitude, radius: self.questionRadius, adress: self.questionAdress, answerCount: 0){ (err) in
                    if err != nil {
                        return
                    }
                    }
            }
        NotificationCenter.default.post(name: Notification.Name("showPartyMarkers"), object: nil)
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        print("title \(self.questionTitle) text \(self.questionText)")
    }
}

//MARK: СДЕЛАТЬ НОРМАЛЬНОЕ ОТОБРАЖЕНИЕ ВРЕМЕНИ НА ВЫХОДНЫХ
