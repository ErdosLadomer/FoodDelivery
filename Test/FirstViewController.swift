//
//  FirstViewController.swift
//  Test
//
//  Created by Mobile Developer on 1/8/17.
//  Copyright © 2017 Mobile Developer. All rights reserved.
//

import UIKit
import CoreLocation

class FirstViewController: UIViewController, CLLocationManagerDelegate  {
    
    var locationManager : CLLocationManager = CLLocationManager()
    
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var areaLabel: UILabel!
    @IBOutlet weak var postLabel: UILabel!
    @IBOutlet weak var localLabel: UILabel!
    @IBOutlet weak var geocodeView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        locationManager.distanceFilter = 50
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestLocation()
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        locationManager.startUpdatingLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func OkButtonClicked(_ sender: AnyObject) {
        geocodeView.isHidden = true
    }
    func displayLocationInfo(placemark: CLPlacemark) {
        geocodeView.isHidden = false
        countryLabel.text = placemark.country
        areaLabel.text = placemark.administrativeArea
        postLabel.text = placemark.postalCode
        localLabel.text = placemark.locality
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: {(placemarks, error) -> Void in
            
            if error != nil {
                print("Reverse geocoder failed with error")
                return
            }
            
            if (placemarks?.count)! > 0 {
                let pm = (placemarks?[0])! as CLPlacemark
                self.displayLocationInfo(placemark: pm)
            }
            else {
                print("Problem with the data received from geocoder")
            }
        })
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error")
    }
}
