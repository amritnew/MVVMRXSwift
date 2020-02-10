//
//  CarMapView.swift
//  MVVMRXSwift
//
//  Created by AmritPandey on 09/12/19.
//  Copyright © 2019 Wunder. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import RxSwift
import RxCocoa

/// Show selected car on map
class CarMapView: UIViewController {
    
    /// Car map viewmodel instance
    let mapViewModel = CarMapViewModel()
    
    /// Private variables
    private var annotations = PublishSubject<[MKPointAnnotation]>()
    private var zoomRegion = PublishSubject<MKCoordinateRegion>()
    private var selectedIndex = PublishSubject<Int>()
    private let disposeBag = DisposeBag() // Memory management
    
    /// View Outlets
    @IBOutlet weak var mapkit: MKMapView!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindData()
        mapViewModel.makePinAnnotations()
    }

    /// bind data from view model to view components
    private func bindData() {
        // Annotation for showing pin on map
        mapViewModel.pinAnnotations
            .observeOn(MainScheduler.instance)
            .bind(to: annotations)
            .disposed(by: disposeBag)
        
        // Selected region to zoom and center on map screen for showing selected car
        mapViewModel.selectedRegion
            .observeOn(MainScheduler.instance)
            .bind(to: zoomRegion)
            .disposed(by: disposeBag)
        
        //Index for selectecing pin on map
        mapViewModel.index
            .observeOn(MainScheduler.instance)
            .bind(to: selectedIndex)
            .disposed(by: disposeBag)
        
        // Merge annotations, zoomRegion and selectedIndex updated value
        // Map view related work are done here
        Observable.combineLatest(annotations, zoomRegion, selectedIndex) { [weak self]
            pins, region, index in
            // Use weak self, as class get deallocated when pop from navigation stack and we might caught accessing variable
            if let weakSelf = self {
                weakSelf.mapkit.addAnnotations(pins)
                weakSelf.mapkit.setRegion(region, animated: true)
                weakSelf.mapkit.selectAnnotation(pins[index], animated: true)
            }
            
            }.subscribe()
            .disposed(by: disposeBag)
    }
}
