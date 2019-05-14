//
//  ReportsStruct.swift
//  vigilesMobile
//
//  Created by Riccardo Mores on 01/05/2019.
//  Copyright © 2019 Riccardo Mores. All rights reserved.
//

import Foundation

// Struct copia il suo valore quando viene assegnato a qualcos'altro. Class no
struct Reports: Codable {
    static var report: AnyObject?
    let title: String?
    let id: Int?
    let address: String?
    let street_number: Int?
    let description: String?
    let media: String?
    let tags: String?
}

// Gestiamo i dati facendo riferimento alla struct precedente. In questo caso usiamo una classe per evitare rallentamenti gestendo ora la quantità di dati presente nel json
class ReportsData: Codable {
    var data: [Reports]?
    init(data: [Reports]) {
        self.data = data
    }
}


