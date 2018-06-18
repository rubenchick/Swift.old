//
//  MapViewController.swift
//  Test UIKit. Online shop.
//
//  Created by Anton Rubenchik on 18.06.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//

import UIKit
import MapKit
final class PointAnnatation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    init(coordinate: CLLocationCoordinate2D,title: String?) {
        self.coordinate = coordinate
        self.title = title
        super.init()
    }
    
    var region: MKCoordinateRegion{
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        return MKCoordinateRegion(center: coordinate, span: span)
    }
}

var pointArrat = [(55.753144,37.619171),(55.748198,37.622532),(55.761391,37.609016)]
class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        createAnnotation()
        let pointCoordinates = CLLocationCoordinate2D(latitude: pointArrat[0].0, longitude: pointArrat[0].1)
        let pointAnnatation = PointAnnatation(coordinate: pointCoordinates, title: "McDonald's")
        mapView.setRegion(pointAnnatation.region, animated: true)
        
    }
    
    func createAnnotation(){

        for item in pointArrat {
            let pointCoordinates = CLLocationCoordinate2D(latitude: item.0, longitude: item.1)
            let pointAnnatation = PointAnnatation(coordinate: pointCoordinates, title: "McDonald's")
            mapView.addAnnotation(pointAnnatation)
        }
    }

}
extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let pointAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier) as? MKMarkerAnnotationView {
            pointAnnotationView.animatesWhenAdded = true
            pointAnnotationView.titleVisibility = .adaptive
            return pointAnnotationView
        }
        return nil
    }
    
}





















