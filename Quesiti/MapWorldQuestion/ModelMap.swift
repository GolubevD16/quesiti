//
//  ModelMap.swift
//  MapDemo
//
//  Created by Даниил Ярмоленко on 08.11.2021.
//

import Foundation
import UIKit

struct Question {
    let questionID: String = UUID().uuidString
    let title: String
    let userID: String
    let latitude: Double
    let longitude: Double
    let radius: Int
    let image: UIImage!
    let name: String
}
