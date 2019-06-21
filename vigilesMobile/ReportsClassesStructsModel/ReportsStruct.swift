//
//  ReportsStruct.swift
//  vigilesMobile
//
//  Created by vigiles_admin on 08/03/2019.
//  Copyright © 2019 Vigiles. All rights reserved.
//

import Foundation

class Data: Codable {
    var success: Reports
    static var report: Data?
}

// Struct copia il suo valore quando viene assegnato a qualcos'altro. Class no
struct Reports: Codable {
    static var report: AnyObject?
    let id: Int?
    let user_id = MyUserData.user?.success.id as Int?
    let code_id = 1
    let zone_id = 1
    let title: String?
    let address: String?
    let street_number: Int?
    let latitude: Double?
    let longitude: Double?
    let description: String?
    let media: String?
    let tags: String?
}

// Gestiamo i dati facendo riferimento alla struct precedente. In questo caso usiamo una classe per evitare rallentamenti gestendo ora la quantità di dati presente nel json
class ReportsData: Codable {
//    var success: Reports
//    static var report: ReportsData?
    var data: [Reports]?
    init(data: [Reports]) {
        self.data = data
    }
}
