//
//  HomePageView.swift
//  Quesiti
//
//  Created by Даниил Ярмоленко on 29.10.2021.
//

import UIKit

let user = [1: "avatar", 2: "Alex" ,3: "Moscow"]

class HomePageView: UIView {
    
    lazy var avatarView: UIImageView = {
        avatarView = UIImageView()
        avatarView.image = UIImage(named: user[1] ?? "")
        avatarView.clipsToBounds = true
        avatarView.layer.cornerRadius = 20
        avatarView.contentMode = .scaleToFill
        avatarView.translatesAutoresizingMaskIntoConstraints = false
        
        return avatarView
    }()
    
    lazy var nameLabel: UILabel = {
        nameLabel = UILabel()
        nameLabel.text = user[2] ?? ""
        nameLabel.textColor = .lightGray
        nameLabel.font = UIFont.systemFont(ofSize: 20)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return nameLabel
    }()
    
    lazy var cityLabel: UILabel = {
        cityLabel = UILabel()
        cityLabel.text = user[3] ?? ""
        cityLabel.textColor = .lightGray
        cityLabel.font = UIFont.systemFont(ofSize: 14)
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return cityLabel
    }()
    
//    lazy var lineView: UIView = {
//        lineView = UIView()
//        lineView.backgroundColor = .systemBlue
//        lineView.translatesAutoresizingMaskIntoConstraints = false
        
//        return lineView
//    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.addSubview(avatarView)
        self.addSubview(nameLabel)
        self.addSubview(cityLabel)
//        self.addSubview(lineView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        setupLayout()
    }
    
    private func setupLayout(){
        NSLayoutConstraint.activate([
            avatarView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            avatarView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16),
            avatarView.heightAnchor.constraint(equalToConstant: 150),
            avatarView.widthAnchor.constraint(equalToConstant: 150),
            
            nameLabel.topAnchor.constraint(equalTo: avatarView.bottomAnchor, constant: 8),
            nameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            cityLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            cityLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
//            lineView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
//            lineView.heightAnchor.constraint(equalToConstant: 1),
//            lineView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
//            lineView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
        ])
    }
}
