//
//  SomeExtansion.swift
//  Quesiti
//
//  Created by Даниил Ярмоленко on 24.10.2021.
//

import UIKit

extension UIViewController {

func setupGradientLayer() -> CAGradientLayer {
    let gradient = CAGradientLayer()
    let topColor = UIColor(red: 48/255, green: 177/255, blue: 206/255, alpha: 1).cgColor
    let bottomColor = UIColor(red: 49/255, green: 141/255, blue: 178/255, alpha: 1).cgColor
    gradient.colors = [topColor, bottomColor]
    gradient.locations = [0, 1]
    return gradient
}
}
extension UIButton
{
    func applyGradient(colors: [CGColor])
    {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}

