//
//  MarkerStruct.swift
//  vigilesMobile
//
//  Created by Valeria Spanò on 18/06/2019.
//  Copyright © 2019 Riccardo Mores. All rights reserved.
//

import Foundation
import MapKit

class MyAnnotation : MKPointAnnotation {
    var customPropertyAddress: String?
    var customPropertyCodeID: Int?
    var customPropertyDescription : String?
    var customPropertyID: String? = nil
    var customPropertyImg: String?
    var customPropertyStreetNum : String? = nil
}
