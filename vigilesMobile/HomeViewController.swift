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

class HomeViewController: UIViewController{
     
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var findUserLocation: UIButton!
    @IBOutlet weak var chatBtn: NSLayoutConstraint!
    let locationManager = CLLocationManager()
    let regionRadius: CLLocationDistance = 20
    let annotation = MKPointAnnotation()
    let ied = MKPointAnnotation()
    
    var previousLocation: CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationServices()
        ied.title = "IED"
        ied.subtitle = "Dove studiamo"
        ied.coordinate = CLLocationCoordinate2D(latitude: 45.461035, longitude: 9.210483)
        mapView.addAnnotation(ied)
//        MKUserTrackingBarButtonItem *findUserLocation = [[MKUserTrackingBarButtonItem alloc] initWithMapView:self.map];
//        self.navigationItem.rightBarButtonItem = findUserLocation;
    }
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
//   Zoom su utente
    func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
            mapView.setRegion(region, animated: true)
        }
    }
    
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
        } else {
            // Mostra alert dicendo all'utente di abilitare (alert da mettere)
        }
    }
    
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            startTackingUserLocation()
        case .denied:
            // Mostra alert dicendo all'utente di abilitare (alert da mettere)
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            // Mostra alert dicendo cosa succede (controllo parentale)
            break
        case .authorizedAlways:
            break
        }
    }
    
//    Per trovare utente
    func startTackingUserLocation() {
        mapView.showsUserLocation = true
//        Centra utente
        centerViewOnUserLocation()
//        Aggiorna posizione in movimento
        locationManager.startUpdatingLocation()
        previousLocation = getCenterLocation(for: mapView)
    }
    
//    Ottengo lat e long utente
    func getCenterLocation(for mapView: MKMapView) -> CLLocation {
        let latitude = mapView.centerCoordinate.latitude
        let longitude = mapView.centerCoordinate.longitude
        
        return CLLocation(latitude: latitude, longitude: longitude)
    }
    
//    Al click sul button torna alla posizione dell'utente
    @IBAction func centerMapOnUserButtonClicked() {
        mapView.setUserTrackingMode(MKUserTrackingMode.follow, animated: true)
    }
    
}

extension HomeViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
}

extension HomeViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let center = getCenterLocation(for: mapView)
//        Per convertire latitudine e longitudine
        let geoCoder = CLGeocoder()
        
        guard let previousLocation = self.previousLocation else { return }
        
        guard center.distance(from: previousLocation) > 50 else { return }
        self.previousLocation = center
        
        geoCoder.reverseGeocodeLocation(center) { [weak self] (placemarks, error) in
            guard let self = self else { return }
            
            if let _ = error {
                //Alert per informare utente
                return
            }
            
            guard let placemark = placemarks?.first else {
                //Alert per informare utente
                return
            }
            
//            Il primo è per numero civico, il secondo per nome via
            let streetNumber = placemark.subThoroughfare ?? ""
            let streetName = placemark.thoroughfare ?? ""
            
//            Per velocizzare esecuzione, esegue azioni in parallelo
            DispatchQueue.main.async {
                self.addressLabel.text = "\(streetName) \(streetNumber)"
            }
        }
    }
}

