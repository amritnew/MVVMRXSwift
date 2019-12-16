//
//  TableViewCell.swift
//  WunderAssignment
//
//  Created by AmritPandey on 13/12/19.
//  Copyright © 2019 Wunder. All rights reserved.
//

import UIKit


/// Table view cell for car list table
class CarListCell: UITableViewCell {

    
    /// Cell outlets
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var vinLbl: UILabel!
    @IBOutlet weak var addrLbl: UILabel!
    @IBOutlet weak var inteLbl: UILabel!
    @IBOutlet weak var exteLbl: UILabel!
    @IBOutlet weak var engineLbl: UILabel!
    @IBOutlet weak var fuelLbl: UILabel!
    
    /// For showing car information on cell, values areset  to outlets by didSet observer
    public var car: Car! {
        didSet {
            nameLbl.text = car.name
            vinLbl.text = car.vin
            addrLbl.text = car.address
            inteLbl.text = car.interior
            exteLbl.text = car.exterior
            engineLbl.text = car.engineType
            fuelLbl.text = "\(car.fuel)"
        }
    }

}
