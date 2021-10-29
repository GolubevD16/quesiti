//
//  SignInView.swift
//  Quesiti
//
//  Created by Дмитрий Голубев on 29.10.2021.
//

import UIKit

class SignInView: UIView {
    
    lazy var logoImage: UIImageView = {
        logoImage = UIImageView(image: UIImage(named: "Logo"))
        
        return logoImage
    }()

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupImage()
        setupLayout()
        
    }
    
    private func setupLayout() {
        
        //let navBarHeight = CGFloat(self.safeAreaInsets.top)
        NSLayoutConstraint.activate([
            logoImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            logoImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
        ])
        
    }
    
    
    private func setupImage() {
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        logoImage.clipsToBounds = true
        logoImage.layer.cornerRadius = 5
        
        self.addSubview(logoImage)
    }

}
