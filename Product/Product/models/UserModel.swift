//
//  UserModel.swift
//  Product
//
//  Created by HAKAN ÖZER on 28.02.2024.
//

import Foundation

struct UserModel: Codable {
    let id: Int
    let username, email, firstName, lastName: String
    let gender: String
    let image: String
    let token: String
}
