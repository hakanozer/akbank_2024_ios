//
//  LocationViewController.swift
//  Product
//
//  Created by HAKAN ÖZER on 1.03.2024.
//

import UIKit
import MapKit

class LocationViewController: UIViewController, MKMapViewDelegate {
    
    
    @IBOutlet weak var boxView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDetail: UILabel!
    @IBOutlet weak var lblLat: UILabel!
    @IBOutlet weak var lblLong: UILabel!
    
    @IBOutlet weak var mapView: MKMapView!
    let arr:[Dictionary<String, Any>] = [
        ["title": "İşletme-1", "detail": "İşletme-1 Detail", "lat": 41.0091956, "long": 28.9598693],
        ["title": "İşletme-2", "detail": "İşletme-2 Detail", "lat": 41.0081593, "long": 28.9666499],
        ["title": "İşletme-3", "detail": "İşletme-3 Detail", "lat": 41.0056332, "long": 28.9655341]
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.delegate = self
        
        //let st = UIStoryboard(name: "App", bundle: nil)
        //st.instantiateViewController(withIdentifier: "login")
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        parseLocation()
        
        let lat = arr[1]["lat"] as! CLLocationDegrees
        let long = arr[1]["long"] as! CLLocationDegrees
        mapzoom(lat: lat, long: long)
    }
    
    func parseLocation() {
        for item in arr {
            let pin = MKPointAnnotation()
            pin.coordinate.latitude = item["lat"] as! CLLocationDegrees
            pin.coordinate.longitude = item["long"] as! CLLocationDegrees
            pin.title = item["title"] as? String
            pin.subtitle = item["detail"] as? String
            self.mapView.addAnnotation(pin)
        }
    }
    
    
    func mapzoom(lat: CLLocationDegrees, long: CLLocationDegrees) {
        let latDelta: CLLocationDegrees = 0.02
        let longDelta: CLLocationDegrees = 0.02
        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: longDelta)
        let center = CLLocationCoordinate2D(latitude: lat, longitude: long)
        let region = MKCoordinateRegion(center: center, span: span)
        self.mapView.setRegion(region, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let lat = view.annotation?.coordinate.latitude
        let long = view.annotation?.coordinate.longitude
        mapzoom(lat: lat!, long: long!)
        
        lblTitle.text = (view.annotation?.title)!
        lblDetail.text = (view.annotation?.subtitle)!
        lblLat.text = String(describing: lat!)
        lblLong.text = String(describing: long!)
        
        animateBox()
    }
    
    
    func animateBox() {
        boxView.alpha = 0
        let x = boxView.frame.origin.x
        let w = boxView.bounds.width
        let h = boxView.bounds.height
        boxView.frame = CGRect(x: x, y: -100, width: w, height: h)
        UIView.animate(withDuration: 0.4) {
            self.boxView.frame = CGRect(x: x, y: 120, width: w, height: h)
            self.boxView.alpha = 1
        }
    }

}
