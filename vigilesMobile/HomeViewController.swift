//
//  HomeViewController.swift
//  vigilesMobile
//
//  Created by Riccardo Mores on 08/03/2019.
//  Copyright © 2019 Riccardo Mores. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
//import GoogleMaps
//import GooglePlaces


class HomeViewController: UIViewController, CLLocationManagerDelegate {
     

    @IBOutlet var changeView: UISwipeGestureRecognizer!
    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    let regionRadius: CLLocationDistance = 10
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocAuth()
        // Do any additional setup after loading the view.
    }
    var isInitiallyZoomedToUserLocation: Bool = false
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        if !isInitiallyZoomedToUserLocation {
            isInitiallyZoomedToUserLocation = true
            mapView.showAnnotations([userLocation], animated: true)
        }
    }
    
    func setupLocManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func centerViewOnUser() {
        if let location = locationManager.location?.coordinate {
//            Quanto zoom su posizione
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
             mapView.setRegion(region, animated: true)
        }
    }
    
    func checkLocServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocManager()
            checkLocAuth()
        }
        else {
//            Mostra un alert all'utente dicendo che deve abilitare la localizzazione
        }
    }
    
    func checkLocAuth() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            centerViewOnUser()
            locationManager.startUpdatingLocation()
        case .denied:
            break
        case .restricted:
//            Utente non può cambiare stato, magari in caso di controllo dei genitori
            break
        case .authorizedAlways:
            break
        case .notDetermined:
//            Non è né attiva né tolta
            locationManager.requestWhenInUseAuthorization()
        }
    }
}
