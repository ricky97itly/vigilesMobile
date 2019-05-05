//
//  UserStruct.swift
//  vigilesMobile
//
//  Created by alessandro palumbo on 05/05/2019.
//  Copyright © 2019 Vigiles bitch. All rights reserved.
//

import Foundation
struct User: Codable {
    let id: Int?
    let name: String?
    let surname: String?
    let email: String?
    let address: String?
    let street_number: Int?
    let avatar: String?
    let is_admin: Bool?
    let token_type: String?
    let expires_in: Int?
    let remember_token: String?
    let refresh_token: String?
    
    init (id: Int, name: String, surname: String, email: String, address: String, street_number: Int, avatar: String, is_admin: Bool, token_type: String, expires_in:Int, remember_token: String, refresh_token: String) {
        self.id = id
        self.name = name
        self.surname = surname
        self.email = email
        self.address = address
        self.street_number = street_number
        self.avatar = avatar
        self.is_admin = is_admin
        self.token_type = token_type
        self.expires_in = expires_in
        self.remember_token = remember_token
        self.refresh_token = refresh_token
    }
}

class UserData: Codable {
    var data: [User]?
    
    init(data: [User]) {
        self.data = data
    }
}
