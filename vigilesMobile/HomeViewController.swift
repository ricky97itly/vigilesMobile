//
//  HomeViewController.swift
//  vigilesMobile
//
//  Created by Riccardo Mores on 08/03/2019.
//  Copyright © 2019 Riccardo Mores. All rights reserved.

import Alamofire
import CoreLocation
import MapKit
import Kingfisher
import Lightbox
import SwiftyJSON
import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var chatBtn: NSLayoutConstraint!
    @IBOutlet weak var findUserLocation: UIButton!
    @IBOutlet weak var infoAddress: UILabel!
    @IBOutlet weak var infoID: UILabel!
    @IBOutlet weak var infoImg: UIImageView!
    @IBOutlet weak var infoDescription: UILabel!
    @IBOutlet weak var infoTitle: UILabel!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var mapView: MKMapView!
    let annotation = MKPointAnnotation() //?
    let locationManager = CLLocationManager()
    
    //    Zoom iniziale su posizione utente
    let regionRadius: CLLocationDistance = 1000
    
    var annotations = [MyAnnotation]()
    var infoIMG = [UIImageView]()
    var previousLocation: CLLocation?
    var reports = [Reports]()
//    var selectedReports = Reports?.self
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationServices()
        setUpMarkers()
        UI()
    }
    
    func UI() {
        self.infoView.layer.cornerRadius = 15
        self.infoView.layer.shadowColor = UIColor.black.cgColor
        self.infoView.layer.shadowOffset = CGSize.zero
        self.infoView.layer.shadowOpacity = 0.3
        self.infoView.layer.shadowRadius = 5
    }
    
    func setUpMarkers() {
        ReportsModel().fetchEvents(complete: {
            (reports) in self.reports = reports
            //  Viene gestita l'esecuzione di più elementi di lavoro
            let queue = DispatchQueue.main
            queue.async(execute: {
                for report in reports {
                    //  Se uno di questi parametri manca il codice non va e passa a quello     successivo  (?)
                    print("for ", report.street_number as? Int)
                    if let title = report.title, let address = report.address {
                        print("if let ", report.address)
                        // Geo Code per convertire in Lat e Long
                        let geoCoder = CLGeocoder()
                        let addressString = "\(address) \(report.street_number), Milano"
                        geoCoder.geocodeAddressString(addressString, completionHandler: { (placemarks, error) in
                            if let error = error {
                                print(error, "Questo è l'errore")
                            }
                            else {
                                let placemark = placemarks?.first
                                let lat = placemark?.location?.coordinate.latitude
                                let lon = placemark?.location?.coordinate.longitude
                                let annotation = MyAnnotation()
                                annotation.coordinate.latitude = lat!
                                annotation.coordinate.longitude = lon!
                                annotation.customPropertyAddress = addressString
                                annotation.customPropertyID = "\(report.id!)"
                                annotation.customPropertyImg = report.media
                                annotation.customPropertyDescription = report.description
                                //                                if annotation.customPropertyStreetNum != nil {
                                //                                    annotation.customPropertyStreetNum = "\(report.street_number!)"
                                //                                    print(annotation.customPropertyStreetNum)
                                //                                }
                                annotation.title = title
                                self.mapView.addAnnotation(annotation)
                                self.mapView.showAnnotations(self.mapView.annotations, animated: true)
                            }
                        })
                    }
                }
            })
        })
    }
    
    //    Al click sul marker compaiono le info
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        //        Do Some sort of fancy animation here
        bottomConstraint.constant = 10
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
        if let annotation = view.annotation {
            fillView(annotation: annotation as! MyAnnotation)
        }
    }

    func fillView(annotation: MyAnnotation) {
        self.infoAddress.text = annotation.customPropertyAddress//! + String(annotation.customPropertyStreetNum!)
        self.infoDescription.text = annotation.customPropertyDescription
        self.infoID.text = annotation.customPropertyID
        
//        let imgUrl = URL(string: annotation.customPropertyImg!)
//        self.infoIMG.kf.setImage(with: imgUrl)
        
        self.infoTitle.text = annotation.title ?? ""
    }
    
    //    Chiude le info del marker
    @IBAction func dismissView(_ sender: Any) {
        bottomConstraint.constant = -220
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    //    Button Info per ricevere un aiuto su cosa fare
    @IBAction func onPressed(_ sender: Any) {
        Alert.showAlert(on: self, with: "Ciao!", message: "Premi su un marker per vedere più informazioni.")
    }
    
    //   Zoom su utente
    func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
            mapView.setRegion(region, animated: true)
        }
    }
    
    //    Trovo l'utente
    func startTackingUserLocation() {
        mapView.showsUserLocation = true
        //        Centro l'utente
        centerViewOnUserLocation()
        //        Aggiorno posizione in movimento
        locationManager.startUpdatingLocation()
        previousLocation = getCenterLocation(for: mapView)
    }
    
    //    Ottengo lat e long utente
    func getCenterLocation(for mapView: MKMapView) -> CLLocation {
        let latitude = mapView.centerCoordinate.latitude
        let longitude = mapView.centerCoordinate.longitude
        
        return CLLocation(latitude: latitude, longitude: longitude)
    }
    
    //    Al click sul button viene centrata la posizione dell'utente
    @IBAction func centerMapOnUserButtonClicked() {
        mapView.setUserTrackingMode(MKUserTrackingMode.follow, animated: true)
    }
    
    //    Migliora la localizzazione
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    //  Controllo dei servizi di localizzazione, se non vanno esce alert
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
        //            Per modifiche future, è funzione di Swift 5
        @unknown default:
            print("modifica")
        }
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

    @objc func didTapImageView() {
        let image = infoImg.image
        if infoImg.image == nil {
            return
        }
        
        let lightboxImage = LightboxImage(image: image!, text: reports.description )
        LightboxConfig.InfoLabel.textAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)]
        
        // Create an instance of LightboxController.
        let controller = LightboxController(images: [lightboxImage])
        
        // Set delegates.
        //        controller.pageDelegate = self
        //        controller.dismissalDelegate = self
        
        // Use dynamic background.
        controller.dynamicBackground = true
        
        // Present your controller.
        present(controller, animated: true, completion: nil)
    }
}
