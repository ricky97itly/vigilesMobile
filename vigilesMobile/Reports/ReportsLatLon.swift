//
//  ReportsLatLon.swift
//  vigilesMobile
//
//  Created by Riccardo Mores on 07/06/2019.
//  Copyright © 2019 Riccardo Mores. All rights reserved.
//

import Foundation
import Alamofire

func ReportsLatLong(latitude: Double, longitude: Double, completion: @escaping () -> Void) {
    let URL_CORDINATE = "http://vigilesweb.test/api/reports"
    
    let parameters:  [String: Any] = ["latitude": latitude,
                                     "longitude": longitude]
    
    Alamofire.request(URL_CORDINATE, method: .get, parameters: parameters).validate().response {
        (response) in
        
        completion()
    }
}
