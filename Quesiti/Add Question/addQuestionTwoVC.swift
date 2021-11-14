//
//  addQuestionTwoVC.swift
//  Quesiti
//
//  Created by Даниил Ярмоленко on 13.11.2021.
//

import UIKit

class addQuestionTwoVC:  UIViewController {
        
//    var passedData = Question(title: "Какая погода", userID: "bjhksdf23", latitude: 24.865, longitude: 67.0011, radius: 1000, image: UIImage(systemName: "people1"))
    var passedData = AskQuestion(title: "Какая погода", userID: "bjhksdf23", latitude: 24.865, longitude: 67.0011, adress: "Moscow", radius: 1000, image: UIImage(systemName: "people1"))
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupViews()
    }
    
    
    func setupViews() {
        self.view.addSubview(containerView)
        containerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive=true
        containerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive=true
        containerView.widthAnchor.constraint(equalToConstant: view.frame.width - 40).isActive=true
        containerView.heightAnchor.constraint(equalToConstant: view.frame.height/2.5).isActive=true
        
        self.view.addSubview(btnBack)
        btnBack.topAnchor.constraint(equalTo: view.topAnchor, constant: 35).isActive=true
        btnBack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive=true
        btnBack.widthAnchor.constraint(equalToConstant: 50).isActive=true
        btnBack.heightAnchor.constraint(equalTo: btnBack.widthAnchor).isActive=true
        
        self.view.addSubview(btnAsk)
        btnAsk.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive=true
        btnAsk.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive=true
        btnAsk.widthAnchor.constraint(equalToConstant: 150).isActive=true
        btnAsk.heightAnchor.constraint(equalToConstant: 50).isActive=true
//        myScrollView.contentSize.height = 800
//
//        myScrollView.addSubview(containerView)
//        containerView.centerXAnchor.constraint(equalTo: myScrollView.centerXAnchor).isActive=true
//        containerView.topAnchor.constraint(equalTo: myScrollView.topAnchor).isActive=true
//        containerView.widthAnchor.constraint(equalTo: myScrollView.widthAnchor).isActive=true
//        containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive=true
//
//        containerView.addSubview(imgView)
//        imgView.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive=true
//        imgView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive=true
//        imgView.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive=true
//        imgView.heightAnchor.constraint(equalToConstant: 200).isActive=true
//        imgView.image = passedData.image
//
//        containerView.addSubview(lblTitle)
//        lblTitle.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 15).isActive=true
//        lblTitle.topAnchor.constraint(equalTo: imgView.bottomAnchor).isActive=true
//        lblTitle.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -15).isActive=true
//        lblTitle.heightAnchor.constraint(equalToConstant: 50).isActive=true
//        lblTitle.text = passedData.title
//
//        containerView.addSubview(lblDescription)
//        lblDescription.leftAnchor.constraint(equalTo: lblTitle.leftAnchor).isActive=true
//        lblDescription.topAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: 10).isActive=true
//        lblDescription.rightAnchor.constraint(equalTo: lblTitle.rightAnchor).isActive=true
//        lblDescription.text = "\"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Lorem ipsum dolor sit amet, consectetur adipiscing elit.\""
//        lblDescription.sizeToFit()
    }
//
    let myScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints=false
        scrollView.showsVerticalScrollIndicator=false
        scrollView.showsHorizontalScrollIndicator=false
        return scrollView
    }()
//
    let containerView: UIView = {
        let v=UIView()
        v.backgroundColor = .white
        v.layer.cornerRadius = 10
        v.layer.shadowColor = UIColor.black.cgColor
        v.layer.shadowOpacity = 1
        v.layer.shadowOffset = .zero
        v.layer.shadowRadius = 10
        v.translatesAutoresizingMaskIntoConstraints=false
        return v
    }()
    let labelAdress: UILabel = {
        let lbl = UILabel()
        lbl.text = ""
        return lbl
    }()
    let labelRadius: UILabel = {
        let lbl = UILabel()
        lbl.text = ""
        return lbl
    }()
//
//    let imgView: UIImageView = {
//        let v=UIImageView()
//        v.image = UIImage(named: "people1")
//        v.contentMode = .scaleAspectFill
//        v.clipsToBounds=true
//        v.translatesAutoresizingMaskIntoConstraints=false
//        return v
//    }()
//
//    let lblTitle: UILabel = {
//        let lbl=UILabel()
//        lbl.text = "Name"
//        lbl.font=UIFont.systemFont(ofSize: 28)
//        lbl.textColor = UIColor.black
//        lbl.translatesAutoresizingMaskIntoConstraints=false
//        return lbl
//    }()
//
//    let lblPrice: UILabel = {
//        let lbl=UILabel()
//        lbl.text = "Price"
//        lbl.font=UIFont.boldSystemFont(ofSize: 24)
//        lbl.textColor = UIColor(white: 0.5, alpha: 1)
//        lbl.translatesAutoresizingMaskIntoConstraints=false
//        return lbl
//    }()
//
//    let lblDescription: UILabel = {
//        let lbl=UILabel()
//        lbl.text = "Description"
//        lbl.numberOfLines = 0
//        lbl.font=UIFont.systemFont(ofSize: 20)
//        lbl.textColor = UIColor.gray
//        lbl.translatesAutoresizingMaskIntoConstraints=false
//        return lbl
//    }()
    let btnBack: UIButton = {
        let btn=UIButton()
        btn.backgroundColor = UIColor.clear
        let config = UIImage.SymbolConfiguration(textStyle: .title1)
        btn.setImage(UIImage(systemName: "chevron.left", withConfiguration: config), for: .normal)
        btn.layer.cornerRadius = 25
        btn.clipsToBounds=true
//        btn.tintColor = UIColor.gray
        btn.imageView?.tintColor=UIColor.blue
        btn.addTarget(self, action: #selector(btnBackAction(_:)), for: .touchUpInside)
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
    
    @objc func btnBackAction(_ sender: Any){
        self.transitionOutVc(duration: 0.5, type: .fromLeft)
    }
    
    @objc func btnAsk(_ sender: Any){
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
