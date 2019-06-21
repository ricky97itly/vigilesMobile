//
//  MarkerStruct.swift
//  vigilesMobile
//
//  Created by vigiles_admin on 08/03/2019.
//  Copyright © 2019 Vigiles. All rights reserved.
//

import Foundation
import MapKit

class MyAnnotation : MKPointAnnotation {
    var customPropertyAddress: String?
    var customPropertyCodeID: Int?
    var customPropertyDescription : String?
    var customPropertyID: String? = nil
    var customPropertyImg: String?
    var customPropertyStreetNum : Int?
}
