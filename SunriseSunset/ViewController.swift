//
//  ViewController.swift
//  SunriseSunset
//
//  Created by Roman Bezpalov on 28.09.18.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    
    @IBOutlet weak var curentLocation: UILabel!
    
    @IBOutlet weak var reallLocation: UILabel!
    
    @IBOutlet weak var sunriseLable: UILabel!
    @IBOutlet weak var sunsetLable: UILabel!
  
    let locationManeger = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManeger.delegate = self
        locationManeger.requestWhenInUseAuthorization()
       
        
        
        


    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationManeger.requestLocation()
    }


}

extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let lat = locations.last?.coordinate.latitude,let long = locations.last?.coordinate.longitude {
            
            let latitude = Float(lat)
            let longtitude = Float(long)
            
            self.reallLocation.text = "\(latitude),\(longtitude)"
            
            ApiManager.shared.getInfo(lat: latitude, lng: longtitude, completion: { model in
                guard let strongModel = model else { return } // перевірка на nil
                self.sunriseLable.text = strongModel.sunRise
                self.sunsetLable.text = strongModel.sunSet
            })
        } else {
        
            print("No coordinates")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
       print(error)
    }
    
//    func lookUpCurrentLocation(completionHandler: @escaping (CLPlacemark?) -> Void ) {
//        if let lastLocation = self.locationManeger.location {
//            let geocoder = CLGeocoder()
//            geocoder.reverseGeocodeLocation(lastLocation, completionHandler: { (placemarks,error)  in
//                if error == nil {
//                    let firstLocation = placemarks?[0]
//                    completionHandler(firstLocation)
//                } else {
//                    completionHandler(nil)
//                }
//            })
//
//        } else {
//            completionHandler(nil)
//        }
//    }
}

