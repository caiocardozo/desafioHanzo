//
//  CustomUIButton.swift
//  IOS-Base
//
//  Created by Caio Cardozo on 19/05/19.
//  Copyright © 2019 CaioCardozo. All rights reserved.
//

import UIKit

class CustomUIButton: UIButton {
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
    
    @IBInspectable var shadowOpacity: Float = 0 {
        didSet{
            self.layer.shadowOpacity = shadowOpacity
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat = 0 {
        didSet{
            self.layer.shadowRadius = shadowRadius
        }
    }
    
    
    @IBInspectable var shadowOffset: CGSize = CGSize(width: 0.0, height: 0.0) {
        didSet{
            self.layer.shadowOffset = shadowOffset
        }
    }
    
    @IBInspectable var masksToBounds: Bool = false {
        didSet{
            self.layer.masksToBounds = masksToBounds
        }
    }
    
    @IBInspectable var shadowColor: UIColor = .clear {
        didSet{
            self.layer.shadowColor = shadowColor.cgColor
        }
    }
    
    @IBInspectable var indicatorColor : UIColor = .white
    
    // MARK: - Loader
    // https://stackoverflow.com/questions/36539650/display-activity-indicator-inside-uibutton
    var originalButtonText: String?
    var activityIndicator: UIActivityIndicatorView!
    
    func showLoadingButton(show: Bool){
        if show {
            self.showLoading()
        } else {
            self.hideLoading()
        }
    }
    
    func showLoading() {
        originalButtonText = self.titleLabel?.text
        self.setTitle("", for: .normal)
        
        if (activityIndicator == nil) {
            activityIndicator = createActivityIndicator()
        }
        
        showSpinning()
    }
    
    func hideLoading() {
        self.setTitle(self.titleLabel?.text, for: .normal)
        if (activityIndicator != nil) {
            self.activityIndicator.stopAnimating()
            
        }
    }
    
    private func createActivityIndicator() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = indicatorColor
        return activityIndicator
    }
    
    private func showSpinning() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(activityIndicator)
        centerActivityIndicatorInButton()
        activityIndicator.startAnimating()
    }
    
    private func centerActivityIndicatorInButton() {
        let xCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: activityIndicator, attribute: .centerX, multiplier: 1, constant: 0)
        self.addConstraint(xCenterConstraint)
        
        let yCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: activityIndicator, attribute: .centerY, multiplier: 1, constant: 0)
        self.addConstraint(yCenterConstraint)
    }

}
