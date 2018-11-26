//
//  Station.swift
//  iCycle
//
//  Created by Răzvan-Gabriel Geangu on 26/11/2018.
//  Copyright © 2018 Răzvan-Gabriel Geangu. All rights reserved.
//

import Foundation
import MapKit

enum StationAttributes: String {
    case id = "id"
    case name = "name"
    case terminalName = "terminalName"
    case lat = "lat"
    case long = "long"
    case installed = "installed"
    case locked = "locked"
    case installDate = "installDate"
    case removalDate = "removalDate"
    case temporary = "temporary"
    case nbBikes = "nbBikes"
    case nbEmptyDocks = "nbEmptyDocks"
    case nbDocks = "nbDocks"
}

class Station: NSObject, MKAnnotation {
    var lat: Double?
    var long: Double?
    var name: String?
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: lat ?? 0, longitude: long ?? 0)
    }
}
