//
//  ViewController.swift
//  MapsPaises
//
//  Created by KMMX on 27/10/20.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapa: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapa.delegate=self
        
        let london = Capital(title: "Londres", coordinate: CLLocationCoordinate2D(latitude: 51.50722, longitude: -0.1275), info: "Juegos olimpicos 2012 :)")
        let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: "La ciudad de la luz :V")
        let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "Capital de noruega")
        
        //mapa.addAnnotation(london)
        mapa.addAnnotations([london,paris,oslo])
        
        let appleHQ = CLLocation(latitude: 37.334722, longitude: -122.00888)
        
        let regionRadius: CLLocationDistance = 1000.0
        
        let region = MKCoordinateRegion(center: appleHQ.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapa.setRegion(region, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard annotation is Capital else { return nil }
        
        let identifier = "Capital"
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
        }else{
            annotationView?.annotation = annotation
        }
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let capital = view.annotation as? Capital else { return }
        let placeName = capital.title
        let placeInfo = capital.info
        let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title:"OK", style: .default))
        present(ac, animated: true)
        
    }


}

