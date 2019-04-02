//
//  AddViewController.swift
//  vigilesMobile
//
//  Created by Riccardo Mores on 09/03/2019.
//  Copyright © 2019 Riccardo Mores. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import AddressBookUI

class AddViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var emergencyDescription: UITextField!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelAddress: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var mediaBtn: UIButton!
    @IBOutlet weak var tag: UITextField!
    @IBOutlet weak var locationBtn: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addBtn.layer.cornerRadius = 15
        self.addBtn.layer.borderWidth = 1
        self.addBtn.layer.borderColor = UIColor.white.cgColor
        self.addBtn.clipsToBounds = true
        self.mediaBtn.layer.cornerRadius = 15
        self.address.layer.cornerRadius = 15
        self.name.layer.cornerRadius = 15
        self.emergencyDescription.layer.cornerRadius = 15
        self.tag.layer.cornerRadius = 15
        self.address.delegate = self
        self.name.delegate = self
        self.emergencyDescription.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    // Nasconde tastiera quando premo fuori
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    // Nasconde tastiera quando premo invio
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        name.resignFirstResponder()
        address.resignFirstResponder()
        emergencyDescription.resignFirstResponder()
        return (true)
    }
    
    @IBAction func addEmergency() {
        print("Tap button")
    }
    
  

}

    extension AddViewController: CLLocationManagerDelegate, MKMapViewDelegate {

        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            let locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
            let locat = manager.location
            let geocoder: CLGeocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(locat!, completionHandler: {
                (placemarks, error) in
                if (error != nil) {
                    //geocoding failed
                } else {
                    let pm = placemarks! as [CLPlacemark]
                    
                    if pm.count > 0 {
                        let pm = placemarks![0]
                        let streetNumber = pm.subThoroughfare ?? ""
                        let streetName = pm.thoroughfare ?? ""
                        let locality =  pm.locality ?? ""
                        self.address.text = "\(streetName) \(streetNumber)"
                        print(streetNumber)
                        manager.stopUpdatingLocation()
                    }
                }
            })
            
        }
       
}
