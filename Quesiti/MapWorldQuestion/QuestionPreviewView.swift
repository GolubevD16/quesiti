//
//  RestaurantPreviewView.swift
//  googlMapTutuorial2
//
//  Created by Muskan on 12/17/17.
//  Copyright © 2017 akhil. All rights reserved.
//

import Foundation
import UIKit
import Cosmos

class QuestionPreviewView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor=UIColor.clear
        self.clipsToBounds=true
        self.layer.masksToBounds=true
        self.layer.cornerRadius = 20
        self.layer.shadowRadius = 10
        self.layer.shadowColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0.25)
        setupViews()
    }
    
    func setData(title: String, img: UIImage, name: String) {
        lblTitle.text = title
        imgView.image = img
        lblName.text = name
    }
    
    func setupViews() {
        addSubview(containerView)
        containerView.leftAnchor.constraint(equalTo: leftAnchor).isActive=true
        containerView.topAnchor.constraint(equalTo: topAnchor).isActive=true
        containerView.rightAnchor.constraint(equalTo: rightAnchor).isActive=true
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive=true
        
        containerView.addSubview(imgView)
        imgView.leftAnchor.constraint(equalTo: leftAnchor, constant: 7).isActive=true
        imgView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 7).isActive=true
        imgView.heightAnchor.constraint(equalToConstant: 40).isActive=true
        imgView.widthAnchor.constraint(equalTo: imgView.heightAnchor).isActive=true
        
        containerView.addSubview(cointainerStars)
        cointainerStars.topAnchor.constraint(equalTo: imgView.bottomAnchor, constant: 2).isActive=true
        cointainerStars.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 4).isActive=true
        cointainerStars.heightAnchor.constraint(equalToConstant: 10).isActive=true
        cointainerStars.rightAnchor.constraint(equalTo: imgView.rightAnchor, constant: 2).isActive=true
        
        containerView.addSubview(lblName)
        lblName.leftAnchor.constraint(equalTo: imgView.rightAnchor, constant: 3).isActive=true
        lblName.topAnchor.constraint(equalTo: imgView.topAnchor, constant: 6).isActive=true
        lblName.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -65).isActive=true
        lblName.heightAnchor.constraint(equalToConstant: 8).isActive=true
        
        containerView.addSubview(timeLabel)
        timeLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -5).isActive=true
        timeLabel.topAnchor.constraint(equalTo: imgView.topAnchor, constant: 6).isActive=true
        timeLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 140).isActive=true
        timeLabel.bottomAnchor.constraint(equalTo: lblName.bottomAnchor).isActive=true
        
        containerView.addSubview(lblTitle)
        lblTitle.leftAnchor.constraint(equalTo: imgView.rightAnchor, constant: 5).isActive=true
        lblTitle.topAnchor.constraint(equalTo: lblName.bottomAnchor, constant: 0).isActive=true
        lblTitle.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -5).isActive=true
        lblTitle.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -14).isActive=true
        
        containerView.addSubview(likeButton)
        likeButton.leadingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -65).isActive=true
        likeButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -2).isActive=true
        likeButton.heightAnchor.constraint(equalToConstant: 10).isActive=true
        likeButton.widthAnchor.constraint(equalToConstant: 10).isActive=true
        
        containerView.addSubview(countOfLike)
        countOfLike.leadingAnchor.constraint(equalTo: likeButton.trailingAnchor, constant: 2).isActive=true
        countOfLike.widthAnchor.constraint(equalToConstant: 13).isActive=true
        countOfLike.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive=true
        countOfLike.heightAnchor.constraint(equalToConstant: 10).isActive=true
        
        containerView.addSubview(comView)
        comView.leadingAnchor.constraint(equalTo: countOfLike.trailingAnchor, constant: 4).isActive=true
        comView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -2).isActive=true
        comView.heightAnchor.constraint(equalToConstant: 10).isActive=true
        comView.widthAnchor.constraint(equalToConstant: 10).isActive=true
        
        containerView.addSubview(countOfComsView)
        countOfComsView.leadingAnchor.constraint(equalTo: comView.trailingAnchor, constant: 4).isActive=true
        countOfComsView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -2).isActive=true
        countOfComsView.bottomAnchor.constraint(equalTo: comView.bottomAnchor).isActive=true
        countOfComsView.heightAnchor.constraint(equalToConstant: 10).isActive=true
        
    }
    
    let containerView: UIView = {
        let v=UIView()
        v.layer.borderColor = UIColor.white.cgColor
        v.layer.borderWidth = 1
        v.backgroundColor = .white
        v.layer.cornerRadius = 20
        v.layer.shadowColor = UIColor.black.cgColor
        v.layer.shadowRadius = 1.5
        v.layer.shadowOffset = .init(width: 0.5, height: 0.5)
        v.layer.shadowOpacity = 0.8
        v.translatesAutoresizingMaskIntoConstraints=false
        return v
    }()
    
    let imgView: UIImageView = {
        let v=UIImageView()
        v.image = UIImage(named: "people1")
        v.layer.cornerRadius = 20
        v.clipsToBounds = true
        v.translatesAutoresizingMaskIntoConstraints=false
        return v
    }()
    
    let lblTitle: UILabel = {
        let lbl=UILabel()
        lbl.text = "Name"
        lbl.font=UIFont.systemFont(ofSize: 10)
        lbl.textColor = UIColor.black
        lbl.numberOfLines = 3
        lbl.textAlignment = .left
        lbl.translatesAutoresizingMaskIntoConstraints=false
        return lbl
    }()
    
    let lblName: UILabel = {
        let lbl=UILabel()
        lbl.text = "Name"
        lbl.font=UIFont.boldSystemFont(ofSize: 8)
        lbl.textColor = UIColor.systemGray
        lbl.textAlignment = .left
        lbl.translatesAutoresizingMaskIntoConstraints=false
        return lbl
    }()
    let timeLabel: UILabel = {
       let timeLbl = UILabel()
        timeLbl.text = "18/11 7:00 p.m"
        timeLbl.font=UIFont.systemFont(ofSize: 6)
        timeLbl.textAlignment = .left
        timeLbl.translatesAutoresizingMaskIntoConstraints=false
        return timeLbl
    }()
    lazy var likeButton: UIButton = {
        likeButton = UIButton()
        likeButton.setImage(UIImage(systemName: "hand.thumbsup"), for: .normal)
        likeButton.addTarget(self, action: #selector(like(_:)), for: .touchUpInside)
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        
        return likeButton
    }()
    
    private var isLike = false
    
    lazy var comView: UIImageView = {
        comView = UIImageView()
        comView.image = UIImage(systemName: "message")
        comView.translatesAutoresizingMaskIntoConstraints = false
        
        return comView
    }()
    
    lazy var countOfComsView: UILabel = {
        countOfComsView = UILabel()
        countOfComsView.text = "30"
        countOfComsView.textAlignment = .left
        countOfComsView.font = UIFont.systemFont(ofSize: 7)
        countOfComsView.textColor = .black
        countOfComsView.translatesAutoresizingMaskIntoConstraints = false
        
        return countOfComsView
    }()
    
    lazy var countOfLike: UILabel = {
        countOfLike = UILabel()
        countOfLike.text = "15"
        countOfLike.font = UIFont.systemFont(ofSize: 7)
        countOfLike.textColor = .black
        countOfLike.translatesAutoresizingMaskIntoConstraints = false
        
        return countOfLike
    }()
//    
    lazy var cointainerStars: UIView = {
        cointainerStars = UIView()
        
        var starsRating = CosmosView()
        starsRating.settings.starSize = 10.0
        starsRating.settings.starMargin = 0
        starsRating.rating = 4
        starsRating.settings.updateOnTouch = false
        starsRating.updateConstraints()
        cointainerStars.addSubview(starsRating)
        
        cointainerStars.translatesAutoresizingMaskIntoConstraints = false
        return cointainerStars
    }()
    
    
    @objc func like(_ textField: UITextField){
        if !isLike {
            likeButton.setImage(UIImage(systemName: "hand.thumbsup.fill"), for: .normal)
            isLike = true
        }
        else {
            likeButton.setImage(UIImage(systemName: "hand.thumbsup"), for: .normal)
            isLike = false
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
