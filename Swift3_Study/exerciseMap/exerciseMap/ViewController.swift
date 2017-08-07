//
//  ViewController.swift
//  exerciseMap
//
//  Created by woowabrothers on 2017. 8. 7..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation

class ViewController: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var currentLocationButton: UIButton!
    var mapView: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentLocationButton.addTarget(self, action: #selector(moveToCurrentSearch), for: .touchUpInside)
    }
    
    func moveToCurrentSearch() {
        print("눌림")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func loadView() {
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withLatitude: 37.5106336, longitude: 127.11220, zoom: 16.0)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.isMyLocationEnabled = true
        view = mapView
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 37.5106336, longitude: 127.112208)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let mylocation = mapView.myLocation {
            print("User's location: \(mylocation)")
            let lat = mylocation.coordinate.latitude
            let long = mylocation.coordinate.longitude
            print(lat,long)
            let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 14.0)
            mapView.camera = camera
            mapView.animate(to: camera)
        } else {
            print("User's location is unknown")
        }
    }
}

