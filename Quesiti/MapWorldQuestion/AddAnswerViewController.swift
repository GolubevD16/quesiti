//
//  AddAnswerViewController.swift
//  Quesiti
//
//  Created by Даниил Ярмоленко on 05.12.2021.
//

import UIKit
import Firebase
class AddAnswerViewController: UIViewController, SwiftyTextViewDelegate{
    var date = Date.timeIntervalBetween1970AndReferenceDate
    var textQuestion = ""
    var questionID = ""
    var userQuestionID = ""
    var answerCount = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        // Do any additional setup after loading the view.
    }
    func setupViews() {
        
        textView.font = .systemFont(ofSize: 20)
        textView.textContainer.lineFragmentPadding = 10.0
        textView.layer.cornerRadius = 20
        textView.layer.borderWidth = 0.5
        textView.layer.borderColor = UIColor.black.cgColor
        textView.enablesReturnKeyAutomatically = true
        textView.placeholder = "Please input answer"
        textView.minNumberOfWords = 0
        textView.maxNumberOfWords = 64
        textView.showTextCountView = true
        textView.swiftyDelegate = self
   
        [btncClose, textView, anonimLabel, btnAnonim, btnAsk].forEach{
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            btncClose.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            btncClose.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            btncClose.widthAnchor.constraint(equalToConstant: 50),
            btncClose.heightAnchor.constraint(equalTo: btncClose.widthAnchor),
            
            anonimLabel.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 50),
            anonimLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            anonimLabel.heightAnchor.constraint(equalToConstant: 44),
            anonimLabel.widthAnchor.constraint(equalToConstant: 100),
            
            btnAnonim.topAnchor.constraint(equalTo: anonimLabel.topAnchor),
            btnAnonim.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40),
            btnAnonim.heightAnchor.constraint(equalToConstant: 40),
            btnAnonim.widthAnchor.constraint(equalTo: btnAnonim.heightAnchor),
            
            btnAsk.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            btnAsk.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            btnAsk.widthAnchor.constraint(equalToConstant: 150),
            btnAsk.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
    func textViewDidChange(_ textView: UITextView) {

    }
    func textViewDidEndEditing(_ textView: UITextView) {

    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
       guard text.rangeOfCharacter(from: CharacterSet.newlines) == nil else {
            textView.resignFirstResponder() // uncomment this to close the keyboard when return key is pressed
           return false
       }

       return true
   }
    var textView: SwiftyTextView = SwiftyTextView.init(frame: CGRect.init(x: 20, y: 80, width: 350, height: 300))
//
    let btncClose: UIButton = {
        let btn=UIButton()
        btn.backgroundColor = UIColor.clear
        let config = UIImage.SymbolConfiguration(textStyle: .title1)
        
        
        btn.setImage(UIImage(systemName: "xmark", withConfiguration: config), for: .normal)
        btn.imageView?.tintColor = ThemeColors.mainColor
        btn.layer.cornerRadius = 25
        btn.clipsToBounds=true
        //        btn.tintColor = UIColor.gray
        btn.imageView?.tintColor = ThemeColors.secondaryColor
        btn.addTarget(self, action: #selector(btnClose(_:)), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints=false
        return btn
    }()
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
    //Текст анонимный вопрос
    let anonimLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Anonim"
        lbl.font = .systemFont(ofSize: 24)
        lbl.translatesAutoresizingMaskIntoConstraints=false
        return lbl
    }()
    private var anonimState:Bool = false // состояние аноним
    //Кнопка анонимный вопрос
    let btnAnonim: UIButton = {
        let btn = UIButton()
        
        let config = UIImage.SymbolConfiguration(pointSize: 40)
        btn.setImage(UIImage(systemName: "chevron.down.circle", withConfiguration: config), for: .normal)
        btn.backgroundColor = .clear
        btn.tintColor = .black
        btn.layer.opacity = 0.25
        btn.translatesAutoresizingMaskIntoConstraints=false
        btn.addTarget(self, action: #selector(anonimStateAction(_:)), for: .touchUpInside)
        return btn
    }()
    
    @objc func anonimStateAction(_ sender: UIButton!){
        let config = UIImage.SymbolConfiguration(pointSize: 40)
        
        if !anonimState {
            btnAnonim.setImage(UIImage(systemName: "chevron.down.circle.fill", withConfiguration: config), for: .normal)
            btnAnonim.tintColor = ThemeColors.mainColor
            btnAnonim.layer.opacity = 1
            anonimState = true
        }
        else {
            
            btnAnonim.setImage(UIImage(systemName: "chevron.down.circle", withConfiguration: config), for: .normal)
            btnAnonim.tintColor = .black
            btnAnonim.layer.opacity = 0.25
            anonimState = false
        }
    }
    
//    @objc func questionChange(_ textField: UITextField){
//                guard var text = textField.text else { return }
//                textQuestion = text
//    }
    @objc func btnClose(_ sender: Any){
        self.dismiss(animated: true, completion: nil)
    }
    @objc func btnAsk(_ sender: Any){
        textQuestion = textView.text
        Database.database().addAnswerToQuestion(withId: questionID, text: textQuestion, anonimState: anonimState) { (err) in
            if err != nil {
                return
            }
        }
        let value = ["answerCount": (answerCount+1)]
        Database.database().reference().child("questions").child(userQuestionID).child(questionID).updateChildValues(value)
        Database.database().addQuestionUserAnswer(idQuestion: questionID){ (err) in
                if err != nil {
                    return
                }
            }
        NotificationCenter.default.post(name: Notification.Name("countAnswerPlus"), object: nil)
        NotificationCenter.default.post(name: Notification.Name("refreshQuestion"), object: nil)
        NotificationCenter.default.post(name: Notification.Name("showPartyMarkers"), object: nil)
        self.presentingViewController?.dismiss(animated: true, completion: nil)
        }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
