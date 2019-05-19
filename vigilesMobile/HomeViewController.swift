//
//  HomeViewController.swift
//  vigilesMobile
//
//  Created by Riccardo Mores on 08/03/2019.
//  Copyright © 2019 Riccardo Mores. All rights reserved.


import UIKit
import MapKit
import CoreLocation
import Alamofire

class HomeViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var findUserLocation: UIButton!
    @IBOutlet weak var chatBtn: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var infoImg: UIImageView!
    let locationManager = CLLocationManager()
    //    Zoom iniziale su posizione utente
    let regionRadius: CLLocationDistance = 1000
    let annotation = MKPointAnnotation()
    let ied = MKPointAnnotation()
    var previousLocation: CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationServices()
        //        Creazione marker
        ied.title = "IED"
        ied.subtitle = "Dove studiamo"
        ied.coordinate = CLLocationCoordinate2D(latitude: 45.461035, longitude: 9.210483)
        mapView.addAnnotation(ied)
        UI()
    }
    
    func UI() {
        self.infoView.layer.cornerRadius = 15
        self.infoView.layer.shadowColor = UIColor.black.cgColor
        self.infoView.layer.shadowOpacity = 0.3
        self.infoView.layer.shadowOffset = CGSize.zero
        self.infoView.layer.shadowRadius = 5
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
    
    //    Per migliore localizzazione
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
        }
        else {
            Alert.showAlert(on: self, with: "Attenzione", message: "Devi consentire a Vigiles di seguire la tua posizione")
        }
    }
    
    //    Switch per controllare ogni singolo caso di autorizzazione localizzazione
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        //            Solo se mentre app è in uso
        case .authorizedWhenInUse:
            startTackingUserLocation()
        //            Rifiutato
        case .denied:
            Alert.showAlert(on: self, with: "Attenzione", message: "Devi consentire a Vigiles di seguire la tua posizione")
            break
        //            Non presente una scelta
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        //            Se controllo parentale attivo
        case .restricted:
            Alert.showAlert(on: self, with: "Attenzione", message: "Potrebbe essere attivo il controllo parentale, disabilitalo per avere accesso alle funzioni di Vigiles")
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
                Alert.showAlert(on: self, with: "Attenzione", message: "Non è possibile stabilire dove è posizionato il puntatore")
                return
            }
            
            guard let placemark = placemarks?.first
                else {
                    Alert.showAlert(on: self, with: "Attenzione", message: "Non è possibile stabilire dove è posizionato il puntatore")
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
