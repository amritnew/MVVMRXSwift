//
//  ViewController.swift
//  MVVMRXSwift
//
//  Created by AmritPandey on 09/12/19.
//  Copyright © 2019 Wunder. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CarListView: UIViewController {
    
    /// View Outlets
    @IBOutlet weak var carTblView: UITableView!
    
    /// private variables
    private let listViewModel = CarListViewModel()
    private let disposeBag = DisposeBag() // Memory management
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        bindData()
        listViewModel.getCarList()
        self.title = "Cars"
    }
    
    // MARK: - Private Functions
    
    /// bind data from view model to view components
    private func bindData() {
        // For showing loader view
        listViewModel.loading
            .bind(to: self.rx.isAnimate).disposed(by: disposeBag)
        
        // For showing data to table view
        listViewModel
            .cars
            .observeOn(MainScheduler.instance)
            .bind(to: carTblView.rx.items(cellIdentifier: kCellIdentifier, cellType: CarListCell.self) ) { (row, list, cell) in
                cell.car = list
            }.disposed(by: disposeBag)
           
        // For selecting an item from table view
        carTblView.rx.itemSelected
            .subscribe(onNext: { (indexpath) in
                
                if  let carMapVc = self.storyboard?.instantiateViewController(identifier: kCarMapViewIdentifier) as? CarMapView, let cell = self.carTblView.cellForRow(at: indexpath) as? CarListCell {
                    carMapVc.mapViewModel.selectedCar = cell.car
                    carMapVc.mapViewModel.carList = self.listViewModel.carsList
                    self.navigationController?.pushViewController(carMapVc, animated: true)
                }
            }).disposed(by: disposeBag)
        
        // For showing any error while fetching data from server
        listViewModel.error
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: {(error) in
                let alertController = UIAlertController(title: kErrorTitle, message: error.rawValue, preferredStyle: .alert)
                let action = UIAlertAction(title: kOkayTitle, style: .cancel, handler: nil)
                alertController.addAction(action)
                self.present(alertController, animated: true, completion: nil)
            }).disposed(by: disposeBag)
    }

}


