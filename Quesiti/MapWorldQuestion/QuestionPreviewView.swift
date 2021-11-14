//
//  RestaurantPreviewView.swift
//  googlMapTutuorial2
//
//  Created by Muskan on 12/17/17.
//  Copyright © 2017 akhil. All rights reserved.
//

import Foundation
import UIKit

class QuestionPreviewView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor=UIColor.clear
        self.clipsToBounds=true
        self.layer.masksToBounds=true
        self.layer.cornerRadius = 10
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
        imgView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive=true
        imgView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive=true
        imgView.heightAnchor.constraint(equalToConstant: 60).isActive=true
        imgView.widthAnchor.constraint(equalTo: imgView.heightAnchor).isActive=true
        
        containerView.addSubview(lblName)
        lblName.leftAnchor.constraint(equalTo: imgView.rightAnchor, constant: 5).isActive=true
        lblName.topAnchor.constraint(equalTo: imgView.topAnchor).isActive=true
        lblName.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: 0).isActive=true
        lblName.heightAnchor.constraint(equalToConstant: 30).isActive=true
        
        containerView.addSubview(lblTitle)
        lblTitle.leftAnchor.constraint(equalTo: imgView.rightAnchor, constant: 5).isActive=true
        lblTitle.topAnchor.constraint(equalTo: lblName.bottomAnchor, constant: 5).isActive=true
        lblTitle.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: 0).isActive=true
        lblTitle.heightAnchor.constraint(equalTo: lblName.heightAnchor).isActive=true
       
        
    }
    
    let containerView: UIView = {
        let v=UIView()
        v.layer.borderColor = UIColor.systemBlue.cgColor
        v.layer.borderWidth = 1
        v.backgroundColor = .white
        v.layer.cornerRadius = 10
        v.translatesAutoresizingMaskIntoConstraints=false
        return v
    }()
    
    let imgView: UIImageView = {
        let v=UIImageView()
        v.image = UIImage(named: "people1")
        v.layer.cornerRadius = 30
        v.clipsToBounds = true
        v.translatesAutoresizingMaskIntoConstraints=false
        return v
    }()
    
    let lblTitle: UILabel = {
        let lbl=UILabel()
        lbl.text = "Name"
        lbl.font=UIFont.systemFont(ofSize: 20)
        lbl.textColor = UIColor.black
        lbl.textAlignment = .left
        lbl.translatesAutoresizingMaskIntoConstraints=false
        return lbl
    }()
    
    let lblName: UILabel = {
        let lbl=UILabel()
        lbl.text = "Name"
        lbl.font=UIFont.boldSystemFont(ofSize: 16)
        lbl.textColor = UIColor.black
        lbl.textAlignment = .left
        lbl.translatesAutoresizingMaskIntoConstraints=false
        return lbl
    }()
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
