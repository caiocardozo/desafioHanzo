//
//  CustomString.swift
//  Cardozo
//
//  Created by Caio Cardozo on 19/05/19.
//  Copyright © 2019 CaioCardozo. All rights reserved.
//

import UIKit

protocol Localizable {
    var localized: String { get }
}

protocol XIBLocalizable {
    var xibLocKey: String? { get set }
}

extension String: Localizable {
    /*
     Utilizado para pegar a localized da string na xib
     */
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
}


extension String {
    func isEmail() -> Bool{
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        // return true se o email for válido
        return emailTest.evaluate(with: self)
    }


func isValidEmail() -> Bool {
    if(self.isEmpty) {
        return false
    }
    
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    
    // return true if email for valid
    return emailTest.evaluate(with: self)
}
func isEmpty() -> Bool {
    return self.count == 0
}

}

extension Optional where Wrapped == String {
    func isNullOrEmpty() -> Bool {
        return self == nil || self?.count == 0
    }
}

