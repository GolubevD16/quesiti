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
    let topColor = UIColor(red: 20/255, green: 10/255, blue: 255/255, alpha: 1).cgColor
    let bottomColor = UIColor(red: 200/255, green: 80/255, blue: 255/255, alpha: 1).cgColor
    gradient.colors = [topColor, bottomColor]
    gradient.locations = [0, 1]
    return gradient
}

}
