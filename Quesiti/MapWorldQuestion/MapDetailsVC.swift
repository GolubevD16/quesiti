//
//  DetailsVC.swift
//  googlMapTutuorial2
//
//  Created by Muskan on 12/17/17.
//  Copyright © 2017 akhil. All rights reserved.
//

import UIKit

class DetailsVC: UIViewController {
    
    var passedData = Question(title: "Какая погода ?", userID: "bjhksdf23", latitude: 24.865, longitude: 67.0011, radius: 1000, image: UIImage(systemName: "people1"), name: "Name")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        setupViews()
    }
    
    
    func setupViews() {
        self.view.addSubview(myScrollView)
        myScrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive=true
        myScrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive=true
        myScrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive=true
        myScrollView.heightAnchor.constraint(equalToConstant: 800).isActive=true
        //        myScrollView.contentSize.height = 800
        
        myScrollView.addSubview(containerView)
        containerView.centerXAnchor.constraint(equalTo: myScrollView.centerXAnchor).isActive=true
        containerView.topAnchor.constraint(equalTo: myScrollView.topAnchor).isActive=true
        containerView.widthAnchor.constraint(equalTo: myScrollView.widthAnchor).isActive=true
        containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive=true
        
        containerView.addSubview(imgView)
        imgView.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive=true
        imgView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive=true
        imgView.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive=true
        imgView.heightAnchor.constraint(equalToConstant: 200).isActive=true
        imgView.image = passedData.image
        
        containerView.addSubview(lblTitle)
        lblTitle.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 15).isActive=true
        lblTitle.topAnchor.constraint(equalTo: imgView.bottomAnchor).isActive=true
        lblTitle.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -15).isActive=true
        lblTitle.heightAnchor.constraint(equalToConstant: 50).isActive=true
        lblTitle.text = passedData.title
        
        view.addSubview(lblDescription)
        lblDescription.leftAnchor.constraint(equalTo: lblTitle.leftAnchor).isActive=true
        lblDescription.topAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: 10).isActive=true
        lblDescription.rightAnchor.constraint(equalTo: lblTitle.rightAnchor).isActive=true
        lblDescription.text = "Здесь будет список ответов"
        lblDescription.sizeToFit()
        
        view.addSubview(containerButton)
        containerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive=true
        containerButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -74).isActive=true
        containerButton.widthAnchor.constraint(equalToConstant: 72).isActive=true
        containerButton.heightAnchor.constraint(equalTo: containerButton.widthAnchor).isActive=true
        
        containerButton.addSubview(btnAnswerQuestion)
        btnAnswerQuestion.topAnchor.constraint(equalTo: containerButton.topAnchor).isActive=true
        btnAnswerQuestion.leftAnchor.constraint(equalTo: containerButton.leftAnchor).isActive=true
        btnAnswerQuestion.rightAnchor.constraint(equalTo: containerButton.rightAnchor).isActive=true
        btnAnswerQuestion.bottomAnchor.constraint(equalTo: containerButton.bottomAnchor).isActive=true
        
        containerButton.addSubview(titleButton)
        titleButton.centerYAnchor.constraint(equalTo: containerButton.centerYAnchor).isActive=true
        titleButton.leftAnchor.constraint(equalTo: containerButton.leftAnchor).isActive=true
        titleButton.rightAnchor.constraint(equalTo: containerButton.rightAnchor).isActive=true
    }
    
    let myScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints=false
        scrollView.showsVerticalScrollIndicator=false
        scrollView.showsHorizontalScrollIndicator=false
        return scrollView
    }()
    
    let containerView: UIView = {
        let v=UIView()
        v.translatesAutoresizingMaskIntoConstraints=false
        return v
    }()
    
    let imgView: UIImageView = {
        let v=UIImageView()
        v.image = UIImage(named: "people1")
        v.contentMode = .scaleAspectFill
        v.clipsToBounds=true
        v.translatesAutoresizingMaskIntoConstraints=false
        return v
    }()
    
    let lblTitle: UILabel = {
        let lbl=UILabel()
        lbl.text = "Name"
        lbl.font=UIFont.systemFont(ofSize: 28)
        lbl.textColor = UIColor.black
        lbl.translatesAutoresizingMaskIntoConstraints=false
        return lbl
    }()
    
    let lblPrice: UILabel = {
        let lbl=UILabel()
        lbl.text = "Price"
        lbl.font=UIFont.boldSystemFont(ofSize: 24)
        lbl.textColor = UIColor(white: 0.5, alpha: 1)
        lbl.translatesAutoresizingMaskIntoConstraints=false
        return lbl
    }()
    
    let lblDescription: UILabel = {
        let lbl=UILabel()
        lbl.text = "Description"
        lbl.numberOfLines = 0
        lbl.font=UIFont.systemFont(ofSize: 20)
        lbl.textColor = UIColor.gray
        lbl.translatesAutoresizingMaskIntoConstraints=false
        return lbl
    }()
    
    let btnAnswerQuestion: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .clear
        //        let config = UIImage.SymbolConfiguration(textStyle: .)
        let config = UIImage.SymbolConfiguration(textStyle: .title1)
        btn.clipsToBounds=true
        btn.tintColor = UIColor.white
        let squarePath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 72, height: 72), byRoundingCorners:.allCorners, cornerRadii: CGSize(width: 20.0, height: 20.0))
        let squareLayer = CAShapeLayer()
//        squarePath.move(to: CGPoint(x: 39, y: 0))
//
//        squarePath.addLine(to: CGPoint(x: 79, y: 39))
//        squarePath.addLine(to: CGPoint(x: 39, y: 79))
//        squarePath.addLine(to: CGPoint(x: 0, y: 39))
//        squarePath.addLine(to: CGPoint(x: 39, y: 0))
        //        squarePath.addLine(to: CGPoint(x: 100, y: 0))
//        squarePath.close()
        squareLayer.path = squarePath.cgPath
//        squareLayer.transform = CATransform3DMakeRotation(CGFloat(45*Double.pi/180), 0, -49, 1)
        squareLayer.fillColor = ThemeColors.mainColor.cgColor
        btn.layer.addSublayer(squareLayer)
        btn.clipsToBounds=true
        
        btn.addTarget(self, action: #selector(btnAnswer(_:)), for: .touchUpInside)
        btn.transform = CGAffineTransform(rotationAngle: CGFloat.pi/4)
        btn.translatesAutoresizingMaskIntoConstraints=false
        return btn
    }()
    let titleButton: UILabel = {
        let lbl=UILabel()
        lbl.text = "Answer ?"
        lbl.numberOfLines = 0
        lbl.font=UIFont.systemFont(ofSize: 16)
        lbl.textAlignment = .center
        lbl.textColor = UIColor.white
        lbl.translatesAutoresizingMaskIntoConstraints=false
        return lbl
    }()
    
    let containerButton: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints=false
        return v
    }()
        
    @objc func btnAnswer(_ sender: Any){
        navigationController?.popViewController(animated: true)
    }
}
