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
import Photos
import UserNotifications
import Alamofire

class AddViewController: UIViewController, MKMapViewDelegate, UITextFieldDelegate, UITextViewDelegate {
    
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var street_number: UITextField!
    @IBOutlet weak var emergencyDescription: UITextView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelAddress: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var locationBtn: UIButton!
    @IBOutlet weak var mediaBtn: UIButton!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var tag: UITextField!
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UI()
        // Do any additional setup after loading the view.
    }
    
    func UI() {
        self.addBtn.layer.borderColor = UIColor.white.cgColor
        self.addBtn.layer.borderWidth = 2.5
        self.addBtn.clipsToBounds = true
        self.address.delegate = self
        self.emergencyDescription.delegate = self
        self.emergencyDescription.layer.cornerRadius = 10
        self.locationManager.delegate = self
        self.name.delegate = self
        self.name.layer.cornerRadius = 15
        self.tag.layer.cornerRadius = 15
        self.street_number.layer.cornerRadius = 15
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
        let params:[String:AnyObject] = ["user_id": MyUserData.user?.success.id as AnyObject as AnyObject, "code_id": 1 as AnyObject, "zone_id": 1 as AnyObject, "title" : "\(name.text!)" as AnyObject, "address": "\(address.text!)" as AnyObject , "street_number": "\(street_number.text!)" as AnyObject, "description" : "\(emergencyDescription.text!)" as AnyObject, "tags": "\(tag.text!)" as AnyObject, "media": "img.png" as AnyObject ]
        let url = URL(string: "http://vigilesweb.test/api/report")!
        Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default).validate().responseJSON { response in
            
            print(response)
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)")
                
                guard response.error == nil
                    else {
                        Alert.showAlert(on: self, with: "Attenzione", message: "Non è possibile aggiungere la segnalazione, riprova più tardi")
                        print(response.error!)
                        return
                }
                
                guard (response.value as? [String:Any]) != nil
                    else {
                        if let error = response.error {
                            print("ERRORE: \(error)")
                        }
                        return
                }
        
                    do {
                        let jsonDecoder = JSONDecoder()
                        let postData = try jsonDecoder.decode(Reports.self, from: response.data!)
                        Reports.report = postData as AnyObject
                        print(postData, "BOH")
                    }
                    catch {
                        print("JSONSerialization error:", error)
                    }
                }
            }
        }
    }

extension AddViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        let locat = manager.location
        let geocoder: CLGeocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(locat!, completionHandler: {
            (placemarks, error) in
            if (error != nil) {
                print("PERCHÉ NON VAI")
            }
            else {
                let pm = placemarks! as [CLPlacemark]
                if pm.count > 0 {
                    let pm = placemarks![0]
                    let streetNumber = pm.subThoroughfare ?? ""
                    let streetName = pm.thoroughfare ?? ""
                    //                        let locality =  pm.locality ?? ""
                    self.address.text = "\(streetName)"
                    self.street_number.text = "\(streetNumber)"
                    print(streetName, streetNumber)
                    manager.stopUpdatingLocation()
                }
            }
        })
    }
    
    @IBAction func userPosition(_ sender:Any) {
        locationManager.startUpdatingLocation()
        print("VAI")
    }
}

extension AddViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //    Alert che verranno mostrati all'utente, action consente di effettuare un'azione
    func displayUploadImageDialog(btnSelected: UIButton) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        //        Messaggio per evitare imprevisti con foto poco belle
        let alert = UIAlertController(title: "Aggiunta Media", message: "La foto da te scelta sarà visualizzabile agli altri utenti", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Fotocamera", style: .default, handler: {(action: UIAlertAction) in
            self.getImage(fromSourceType: .camera)
        }))
        alert.addAction(UIAlertAction(title: "Libreria", style: .default, handler: {(action: UIAlertAction) in
            self.getImage(fromSourceType: .photoLibrary)
        }))
        alert.addAction(UIAlertAction(title: "Annulla", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        //        Per verificare su quale dispositivo si sta lavorando
        if UI_USER_INTERFACE_IDIOM() == .phone {
            //                Per effettuare più operazioni insieme
            OperationQueue.main.addOperation({() -> Void in
                picker.sourceType = .photoLibrary
                self.present(picker, animated: true) {() -> Void in }
            })
        }
        else {
            picker.sourceType = .photoLibrary
            self.present(picker, animated: true) {() -> Void in }
        }
    }
    
    func getImage(fromSourceType sourceType: UIImagePickerController.SourceType) {
        
        //Check is source type available
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = sourceType
            self.present(imagePickerController, animated: true, completion: nil)
        }
    }
    
    //    Verifica permessi
    func checkPermission() {
        let authStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        switch authStatus {
        case .authorized:
            self.displayUploadImageDialog(btnSelected: self.mediaBtn)
        case .denied:
            Alert.showAlert(on: self, with: "Attenzione", message: "Devi permettere a Vigiles di accedere alla libreria fotografica per aggiungere una foto")
        default:
            break
        }
    }
    
    //    Controllo libreria
    func checkLibrary() {
        let photos = PHPhotoLibrary.authorizationStatus()
        if photos == .authorized {
            switch photos {
            case .authorized:
                self.displayUploadImageDialog(btnSelected: self.mediaBtn)
            case .denied:
                Alert.showAlert(on: self, with: "Attenzione", message: "Non è stato possibile accedere alla libreria")
            default:
                break
            }
        }
    }
    
    @IBAction func addMedia(_ sender: UIButton) {
        let photos = PHPhotoLibrary.authorizationStatus()
        if photos == .notDetermined {
            PHPhotoLibrary.requestAuthorization({status in
                if status == .authorized{
                    print("VAI")
                } else {
                    print("NON VAI")
                }
            })
        }
        checkLibrary()
        checkPermission()
    }
}
