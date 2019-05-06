//
//  UserStruct.swift
//  vigilesMobile
//
//  Created by alessandro palumbo on 05/05/2019.
//  Copyright © 2019 Vigiles bitch. All rights reserved.
//

import Foundation
struct User: Codable {
    static var user: AnyObject?
    let id: Int?
    let name: String?
    let surname: String?
    let email: String?
    let address: String?
    let street_number: Int?
    let avatar: String?
    let is_admin: Bool?
}

class UserData: Codable {
    var data: [User]?
    
    init(data: [User]) {
        self.data = data
    }
}
