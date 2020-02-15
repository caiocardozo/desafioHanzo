//
//  CustomUIView.swift
//  IOS-Base
//
//  Created by Caio Cardozo on 22/05/19.
//  Copyright © 2019 CaioCardozo. All rights reserved.
//

import UIKit

@IBDesignable class CustomUIView: UIView {
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet{
            self.layer.borderWidth = borderWidth
        }
    }
    
    
    @IBInspectable var borderColor: UIColor = .clear {
        didSet{
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet{
            self.layer.cornerRadius = cornerRadius
        }
    }
    
   
    
    @IBInspectable var addDropShadow:Bool = false{
        didSet{
            if addDropShadow{
                self.layer.shadowColor   = UIColor.black.cgColor
                self.layer.shadowOffset  = CGSize(width: 0.0, height: 0.0)
                self.layer.shadowRadius  = 5
                self.layer.shadowOpacity = 0.5
            }
            else{
                self.layer.shadowColor   = UIColor.clear.cgColor
                self.layer.shadowOffset  = CGSize(width: 0.0, height: 0.0)
                self.layer.shadowRadius  = 0
                self.layer.shadowOpacity = 0.0
            }
        }
    }
    
}
