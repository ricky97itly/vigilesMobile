//
//  UserStruct.swift
//  vigilesMobile
//
//  Created by alessandro palumbo on 05/05/2019.
//  Copyright © 2019 Vigiles bitch. All rights reserved.
//

import Foundation

class MyUserData: Codable {
    var success: User
    static var user: MyUserData?
}

struct User: Codable {
    let id: Int?
    let name: String?
    let surname: String?
    let email: String?
    let address: String?
    let is_admin: Int?
    let street_number: Int?
    let avatar: String?
    let password: String?
    let confirm_password: String?
}
