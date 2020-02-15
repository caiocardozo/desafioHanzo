//
//  UIButton.swift
//  IOS-Base
//
//  Created by Caio Cardozo on 19/05/19.
//  Copyright © 2019 CaioCardozo. All rights reserved.
//

import UIKit

//insert localizable in Xib
extension UIButton : XIBLocalizable {
        @IBInspectable var xibLocKey: String? {
            get { return nil }
            set(key) {
                setTitle(key?.localized, for: .normal)
            }
        }
    }
