//
//  ModelAsk.swift
//  Quesiti
//
//  Created by Даниил Ярмоленко on 13.11.2021.
//

import Foundation
import UIKit

struct AskQuestion {
    let questionID: String = UUID().uuidString
    let title: String
    let userID: String
    let latitude: Double
    let longitude: Double
    let adress: String
    let radius: Int
    let image: UIImage!
}
