//
//  FormUtilities.swift
//  WelbornEdward_FridgePal
//
//  Created by Roy Welborn on 12/4/20.
//

import Foundation

class FormUtilities
{
    static func isPasswordValid(_ password : String) -> Bool {
        
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
}
