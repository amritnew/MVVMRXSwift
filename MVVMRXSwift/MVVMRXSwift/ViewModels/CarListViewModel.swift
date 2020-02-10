//
//  CarListViewModel.swift
//  MVVMRXSwift
//
//  Created by AmritPandey on 09/12/19.
//  Copyright © 2019 Wunder. All rights reserved.
//

import Foundation
import RxSwift

/// View model class for list view of all cars location
/// This class cannot be subclass
final class CarListViewModel {
    
    /// Private varaible for API interaction
    private let apiServices:APIServiceProtocol = APIService.shared
    
    /// deliver fetched cars array to list view
    let cars: PublishSubject<[Car]> = PublishSubject()
    /// for showing loader while cars data are fetched from server
    let loading: PublishSubject<Bool> = PublishSubject()
    /// used to show any error encounter in fertching cars data
    let error: PublishSubject<ErrorType> = PublishSubject()
    
    /// Model class array, Contains information about all cars
    var carsList: [Car]!
    
    /// Fetch car data 
    func getCarList() {
        self.loading.onNext(true)
        apiServices.getData(success: { (carsData) in
            
            self.carsList = try! JSONDecoder().decode(Array<Car>.self, from: carsData)
            
            self.cars.onNext(self.carsList)
            self.loading.onNext(false)
        }) { (code, error) in
            self.error.onNext(error)
            self.loading.onNext(false)
        }
    }
}
