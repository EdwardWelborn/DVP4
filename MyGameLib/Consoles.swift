//
//  Consoles.swift
//  MyGameLib
//
//  Created by Roy Welborn on 1/17/21.
//

import Foundation

class Consoles
{
    var consoleName : String
    var serialNumber : String?
    var datePurchased : Date?
    
    init(consoleName : String, serialNumber : String, datePurchased : Date)
    {
        self.consoleName = consoleName
        self.serialNumber = serialNumber
        self.datePurchased = datePurchased
    }
}
