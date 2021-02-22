//
//  ViewController.swift
//  Project22
//
//  Created by Marc on 22.02.21.
//

import UIKit
import CoreLocation

class ViewController: UIViewController,CLLocationManagerDelegate {
    @IBOutlet var distanceReading: UILabel!
    var locationManager: CLLocationManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()
        
        view.backgroundColor = .gray
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways{
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self){
                if CLLocationManager.isRangingAvailable(){
                    startScanning()
                     
                }
            }
        }
    }
    
    func startScanning(){
        let uuid = UUID(uuidString: "5A4BCFCE-174E-4BAC-a814-092E77F6B7E5")!
        let beaconRegionConstraint = CLBeaconIdentityConstraint(uuid: uuid, major: 123, minor: 456)
        locationManager?.startRangingBeacons(satisfying: beaconRegionConstraint)
        
    }
    
    func update(distance: CLProximity){
        UIView.animate(withDuration: 1) {
            switch distance{
            case .far:
                self.view.backgroundColor = .blue
                self.distanceReading.text = "FAR"
                
            case .near:
                self.view.backgroundColor = .orange
                self.distanceReading.text = "NEAR"
                
            case .immediate:
                self.view.backgroundColor = .red
                self.distanceReading.text = "RIGHT HERE"
    
            default:
                self.view.backgroundColor = .gray
                self.distanceReading.text = "UNKNOWN"
                
            }
        }
    }

    func locationManager(_ manager: CLLocationManager, didRange beacons: [CLBeacon], satisfying beaconConstraint: CLBeaconIdentityConstraint) {
        if let beacon = beacons.first {
            update(distance: beacon.proximity)
        }else{
            update(distance: .unknown)
        }
    }
}

