//
//  ViewController2.swift
//  exerciseMap
//
//  Created by woowabrothers on 2017. 8. 7..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewController2: UIViewController {

    @IBOutlet weak var mapView: GMSMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        draw()
    }
}

extension ViewController2: GMSMapViewDelegate, CLLocationManagerDelegate {
    func draw() {
        let camera = GMSCameraPosition.camera(withLatitude: 37.5106336, longitude: 127.11220, zoom: 16.0)
        mapView.camera = camera
        mapView.animate(to: camera)
        mapView.isMyLocationEnabled = true
    }
}
