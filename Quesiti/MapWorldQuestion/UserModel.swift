//
//  UserModel.swift
//  MapDemo
//
//  Created by Даниил Ярмоленко on 08.11.2021.
//

import Foundation

struct User {
    let userID: String = UUID().uuidString
    let name: String
    let Surname: String
    let imageUrl: URL?
}
