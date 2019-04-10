//
//  HomeViewController.swift
//  vigilesMobile
//
//  Created by Riccardo Mores on 08/03/2019.
//  Copyright © 2019 Riccardo Mores. All rights reserved.


import UIKit
import MapKit
import CoreLocation

class HomeViewController: UIViewController {
     
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var findUserLocation: UIButton!
    @IBOutlet weak var chatBtn: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var infoImg: UIImageView!
    let locationManager = CLLocationManager()
    let regionRadius: CLLocationDistance = 1000
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
        self.infoView.layer.cornerRadius = 15
        self.infoView.layer.shadowColor = UIColor.black.cgColor
        self.infoView.layer.shadowOpacity = 0.3
        self.infoView.layer.shadowOffset = CGSize.zero
        self.infoView.layer.shadowRadius = 5
//     ombra viene messa nella cache, evita rallentamenti nell'app così non si devono ricreare    sempre
        self.infoView.layer.shouldRasterize = true
//        MKUserTrackingBarButtonItem *findUserLocation = [[MKUserTrackingBarButtonItem alloc] initWithMapView:self.map];
//        self.navigationItem.rightBarButtonItem = findUserLocation;
    }
    
//    Button info, al click appare view
    @IBAction func onPressed(_ sender: Any) {
        bottomConstraint.constant = 10
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
//    Button dentro la view, al click si chiude
    @IBAction func dismissView(_ sender: Any) {
        bottomConstraint.constant = -220
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
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
            let alert = UIAlertController(title: "Attenzione", message: "Devi consentire a Vigiles di seguire la tua posizione.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            startTackingUserLocation()
        case .denied:
            let alert = UIAlertController(title: "Attenzione", message: "Devi consentire a Vigiles di seguire la tua posizione.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            let alert = UIAlertController(title: "Attenzione", message: "Potrebbe essere attivo il controllo parentale, disabilitalo per avere accesso alle funzioni di Vigiles", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            break
        case .authorizedAlways:
            break
//            Per modifiche future, è funzione di Swift 5 (AGGIORNATE)
        @unknown default:
            print("modifica")
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
                let alert = UIAlertController(title: "Attenzione", message: "Non è possibile stabilire dove è posizionato il puntatore.", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
            
            guard let placemark = placemarks?.first else {
                let alert = UIAlertController(title: "Attenzione", message: "Non è possibile stabilire dove è posizionato il puntatore.", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
            
//            Il primo è per nome via, il secondo per numero civico
            let streetName = placemark.thoroughfare ?? ""
            let streetNumber = placemark.subThoroughfare ?? ""
            
//            Per velocizzare esecuzione, esegue azioni in parallelo
            DispatchQueue.main.async {
                self.addressLabel.text = "\(streetName) \(streetNumber)"
            }
        }
    }
}
