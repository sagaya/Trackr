//
//  locateViewController.swift
//  Pods
//
//  Created by sagaya Abdulhafeez on 29/06/2016.
//
//

import UIKit
import MapKit
import CoreLocation

class locateViewController: UIViewController,MKMapViewDelegate {

    @IBOutlet weak var adress1: UILabel!
    @IBOutlet weak var map: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
                
        map.delegate = self

        
        //THE COORDINATES CANNOT BE SET AUTOMATICALLY BECAUSE WILL NOT ALLOW CAN ONLY BE USED IN A PARTICULAR RANGE SO I HARDCODED THE COORDINATES
        var location = CLLocationCoordinate2DMake(6.523769, 3.376966)
        var annotation = MKPointAnnotation()
        var span = MKCoordinateSpanMake(0.02, 0.02)
        var region = MKCoordinateRegion(center: location, span: span)
        
        
        annotation.coordinate = location
        annotation.title = "Package"
        annotation.subtitle = "Pakage name"
        map.addAnnotation(annotation)
        map.setRegion(region, animated: true)
    }
    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        
        let annotationReuseId = "Place"
        var anView = mapView.dequeueReusableAnnotationViewWithIdentifier(annotationReuseId)
        if anView == nil {
            anView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationReuseId)
        } else {
            anView!.annotation = annotation
        }

        
        anView!.image = UIImage(named: "delivery.png")
        
        anView!.backgroundColor = UIColor.clearColor()
        anView!.canShowCallout = false
        return anView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
