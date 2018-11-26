//
//  ViewController.swift
//  iCycle
//
//  Created by Răzvan-Gabriel Geangu on 26/11/2018.
//  Copyright © 2018 Răzvan-Gabriel Geangu. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.requestWhenInUseAuthorization()
        manager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        manager.startUpdatingLocation()
        manager.pausesLocationUpdatesAutomatically = false
        return manager
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        initMap()
        
        RGApi.shared.getStationsFeed { (stations, lastUpdate) in
            guard let stations = stations else { return }
            
            self.mapView.addAnnotations(stations)
        }
    }

    func initMap() {
        
        // Set the delegate
        mapView.delegate = self
        
        // Show the location of the user on the screen
        mapView.showsUserLocation = true
        
        if let userLocation = locationManager.location?.coordinate {
            let region = MKCoordinateRegion(center: userLocation, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            mapView.setRegion(region, animated: true)
        }
    }
}

extension ViewController: MKMapViewDelegate {
    
}
