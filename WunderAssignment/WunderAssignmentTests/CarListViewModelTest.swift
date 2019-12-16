//
//  CarListViewModelTest.swift
//  WunderAssignmentTests
//
//  Created by AmritPandey on 16/12/19.
//  Copyright © 2019 Wunder. All rights reserved.
//

import XCTest
import RxSwift
@testable import WunderAssignment

/// Mocking APIServices
private class MockAPIServices: APIServiceProtocol {
    
    /// singleton instance
    static let shared = MockAPIServices()
    
    func getData(success: @escaping SuccessResponse, failure: @escaping FailureClosure) {
        do {
            guard let path = Bundle.main.path(forResource: "Location", ofType: "txt") else {
                failure(0, ErrorType.unknownError)
                return
            }
            let jsonData = try Data.init(contentsOf: URL(fileURLWithPath: path))
            success(jsonData)
        }
        catch {
            failure(0, ErrorType.unknownError)
        }
    }
}


class CarListViewModelTest: XCTestCase {

    var apiService: APIServiceProtocol!
    var viewModel: CarListViewModel!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        apiService = MockAPIServices.shared
        viewModel = CarListViewModel()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        apiService = nil
    }
    
    // MARK: - Test Cases

    func testGetCarList() {
        let disposebag = DisposeBag()
        
        viewModel.getCarList()
        let expectationCarList = expectation(description: "Get car list")
        viewModel.cars.subscribe(onNext: { (cars) in
            
            XCTAssertTrue(cars.count > 0)
            expectationCarList.fulfill()
            }).disposed(by: disposebag)
        
        waitForExpectations(timeout: 10.0, handler: nil)
        
    }
}
