//
//  LocationViewController.swift
//  OPSO
//
//  Created by Anil Pervaiz on 6/27/19.
//  Copyright © 2019 OPSO. All rights reserved.
//

import UIKit
import MapKit

final class locationAnnotation: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(coordinate: CLLocationCoordinate2D, title: String?, subtitle: String? ) {
        
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        
        super.init()
    }
    
    var region: MKCoordinateRegion{
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        
        return MKCoordinateRegion(center: coordinate, span: span)
    }
}

class LocationViewController: UIViewController {
    
    @IBOutlet var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
         self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor(named: "PrimaryColor")
        
        
        mapView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        
        let opsoCoordinates = CLLocationCoordinate2D(latitude: 25.1724765, longitude: 55.2425049)
        let opsoAnnotation = locationAnnotation(coordinate: opsoCoordinates, title: "OPSO Dubai", subtitle:"Modern Greek Food" )
        
        mapView.addAnnotation(opsoAnnotation)
        mapView.setRegion(opsoAnnotation.region, animated: true)
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often wan t to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
extension LocationViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let locationAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier) as?
            MKMarkerAnnotationView {
            locationAnnotationView.animatesWhenAdded = true
            locationAnnotationView.titleVisibility = .adaptive
            locationAnnotationView.subtitleVisibility = .adaptive
            
            return locationAnnotationView
            
        }
        
        return nil
    }
}
