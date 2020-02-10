//
//  CarMapViewModel.swift
//  MVVMRXSwift
//
//  Created by AmritPandey on 09/12/19.
//  Copyright © 2019 Wunder. All rights reserved.
//

import Foundation
import RxSwift
import CoreLocation
import MapKit

/// Alters value to zoom in/ zoom out, selected car over map
private let regionZoom = 1000.0

/// View model class for map view of all cars location
/// This class cannot be subclass
final class CarMapViewModel {
    /// Set this from car list view, this contains all cars
    var carList: [Car]!
    /// Set this from car list view, this contains only selected car
    var selectedCar: Car! {
        didSet {
            selectedLocation = CLLocationCoordinate2D(latitude: CLLocationDegrees(selectedCar.coordinates[1]), longitude: CLLocationDegrees(selectedCar.coordinates[0]))
        }
    }
    ///selected car location
    private var selectedLocation: CLLocationCoordinate2D!
    /// selected car region, Region to zoom
    var selectedRegion: PublishSubject<MKCoordinateRegion> = PublishSubject()
    /// contains all annotations for cars
    var pinAnnotations: PublishSubject<[MKPointAnnotation]> = PublishSubject()
    /// selected car index
    var index: PublishSubject<Int> = PublishSubject()
    
    /// Return CarMap model array
    private func getCarMap() -> [CarMap] {
        var carMaps = [CarMap]()
        for car in carList {
            // Coordinate's array contain longitude at index 0, latitude at index 1
            let locatin = CLLocationCoordinate2D(latitude: CLLocationDegrees(car.coordinates[1]), longitude: CLLocationDegrees(car.coordinates[0]))
            let carMap = CarMap(coordinate: locatin, name: car.name)
            carMaps.append(carMap)
        }
        return carMaps
    }
    
    /// Deliver pin annotations array, selected region and index to highlight selected car over map
    /// drop all cars over map, selected car's pin is selected by default
    func makePinAnnotations() {
        var annotations = [MKPointAnnotation]()
        let carLocations = getCarMap()
        var i = 0
        for carLocation in carLocations {
            let annotation = MKPointAnnotation()
            if carLocation.coordinate == selectedLocation, carLocation.name == selectedCar.name {
                let region = MKCoordinateRegion(center: carLocation.coordinate, latitudinalMeters: regionZoom, longitudinalMeters: regionZoom)
                selectedRegion.onNext(region)
                index.onNext(i)
                annotation.title = carLocation.name
            }
            else {
                annotation.subtitle = carLocation.name
            }
            annotation.coordinate = carLocation.coordinate
            annotations.append(annotation)
            i += 1
        }
        pinAnnotations.onNext(annotations)
    }
    
}
