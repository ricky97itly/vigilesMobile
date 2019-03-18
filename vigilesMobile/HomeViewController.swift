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
import GoogleMaps
import GooglePlaces

class HomeViewController: UIViewController, CLLocationManagerDelegate {
     @IBOutlet var homeSwipe: UISwipeGestureRecognizer!
     @IBOutlet weak var mapView: MKMapView!
     let manager = CLLocationManager()
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        let span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let region: MKCoordinateRegion = MKCoordinateRegion(center: myLocation, span: span)
        mapView.setRegion(region, animated: true)
        print("Altitude is: " ,location.altitude)
        print("Speed is: " ,location.speed)
        self.mapView.showsUserLocation = true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        

        // Do any additional setup after loading the view.
    }
    
    
//    @IBAction func homeSwipe(sender:UISwipeGestureRecognizer) {
//        if sender.direction == UISwipeGestureRecognizer.Direction.right {
//            self.tabBarController?.selectedIndex = 2
//        }
//    }
   
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
