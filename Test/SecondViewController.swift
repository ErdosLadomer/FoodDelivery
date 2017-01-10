//
//  SecondViewController.swift
//  Test
//
//  Created by Mobile Developer on 1/8/17.
//  Copyright © 2017 Mobile Developer. All rights reserved.
//

import UIKit
import CoreLocation

class SecondViewController: UIViewController, CLLocationManagerDelegate {
    
    var locationManager : CLLocationManager = CLLocationManager()
    var updatedLocation: CLLocation?
    var locations: NSMutableArray?
    
    @IBOutlet weak var distanceLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        locationManager.distanceFilter = 50
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestLocation()
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        locationManager.startUpdatingLocation()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.receivedNotification(notification:)), name: NSNotification.Name(rawValue: "updatedlocation"), object: updatedLocation)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func saveLocationData(array: NSMutableArray) {
        let userDefault = UserDefaults.standard
        userDefault.set(array, forKey: "Sessions")
        userDefault.synchronize()
    }
    
    
    func receivedNotification(notification: Notification) {
        let alertController = UIAlertController(title: "Notification", message: "You travel the 50m", preferredStyle: .alert)
        let doneAction = UIAlertAction(title: "OK", style: .default) { (action) in
            
        }
        
        alertController.addAction(doneAction)
        let userDefault = UserDefaults.standard
        let data = userDefault.value(forKey: "Sessions")
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:MM  dd.MM.yyyy"
        let result = formatter.string(from: date)
        if let data = data {
            locations = NSMutableArray(array: data as! NSArray)
            
            locations?.add(result)
        } else {
            locations = NSMutableArray()
            locations?.add(result)
        }
        saveLocationData(array: locations!)
        self.present(alertController, animated: true, completion: nil)
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("update")
        let distanceInMeters = userLocation.distance(from: locations[0])
        let distance = Int(distanceInMeters)
        self.distanceLabel.text = String(distance)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "updatedlocation"), object: locations)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error")
    }

}
