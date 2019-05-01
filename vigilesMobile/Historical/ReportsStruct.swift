//
//  ReportsStruct.swift
//  vigilesMobile
//
//  Created by Riccardo Mores on 01/05/2019.
//  Copyright © 2019 Riccardo Mores. All rights reserved.
//

import Foundation

struct Reports: Codable {
    let title: String
    let id: String
    let address: String
    let street_number: String
    let description: String
    let media: [URL]
}

