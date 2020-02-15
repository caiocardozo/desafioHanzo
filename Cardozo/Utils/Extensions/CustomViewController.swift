//
//  CustomViewController.swift
//  IOS-Base
//
//  Created by Caio Cardozo on 16/05/19.
//  Copyright © 2019 CaioCardozo. All rights reserved.
//

import UIKit
import MapKit
import LocalAuthentication

private var loaderView: UIView?

private let swizzling: (AnyClass, Selector, Selector) -> () = { forClass, originalSelector, swizzledSelector in
    let originalMethod = class_getInstanceMethod(forClass, originalSelector)
    let swizzledMethod = class_getInstanceMethod(forClass, swizzledSelector)
    method_exchangeImplementations(originalMethod!, swizzledMethod!)
}

extension UIViewController {
    
    static let classInit: Void = {
        let originalSelector = #selector(viewWillDisappear(_:))
        let swizzledSelector = #selector(swizzledViewWillDisappear(_:))
        swizzling(UIViewController.self, originalSelector, swizzledSelector)
    }()
    
    @objc func swizzledViewWillDisappear(_ animated: Bool) {
       // self.hideLoader()
        // Call the original viewWillDisappear - using the swizzledViewWillDisappear signature
        swizzledViewWillDisappear(animated)
    }
    
    func lockView(_ view: UIView){
        view.isUserInteractionEnabled = false
    }
    
    func unlockView(_ view: UIView) {
        view.isUserInteractionEnabled = true
    }
    
    // MARK: - LoaderView
    func setLoader(show: Bool) {
        show ? showLoader() : hideLoader()
    }
    
    private func showLoader() {
        if(loaderView == nil) {
            // creating loaderView
            loaderView = UIView(frame: UIScreen.main.bounds)
        
            let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
            let viewBlur = UIVisualEffectView(effect: blurEffect)
            
            viewBlur.layer.cornerRadius = 10
            viewBlur.clipsToBounds = true

            viewBlur.frame = CGRect(x: 0, y: 0, width: 120, height: 100)
            loaderView?.addSubview(viewBlur)
            viewBlur.center = loaderView!.center
            // stackview for loader and text
            let stackView = UIStackView(frame: viewBlur.frame)
            stackView.spacing = 16
            stackView.axis = .vertical
            
            // loader
            let loader = UIActivityIndicatorView(style: .large)
            loader.frame = CGRect(x: 0.0, y: 0.0, width: 50.0, height: 50.0)
            loader.startAnimating()
            loader.color = .white
            stackView.addArrangedSubview(loader)
            
            // add stackview as subview for centerView
            viewBlur.contentView.addSubview(stackView)
            
            // setup constraints
            stackView.translatesAutoresizingMaskIntoConstraints = false
            viewBlur.addConstraints([
                NSLayoutConstraint(item: stackView, attribute: .centerX, relatedBy: .equal, toItem: viewBlur, attribute: .centerX, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: stackView, attribute: .centerY, relatedBy: .equal, toItem: viewBlur, attribute: .centerY, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: stackView, attribute: .leading, relatedBy: .equal, toItem: viewBlur, attribute: .leading, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: stackView, attribute: .trailing, relatedBy: .equal, toItem: viewBlur, attribute: .trailing, multiplier: 1, constant: 0)
            ])
        }
        
        if self.navigationController ==  nil {
            self.view.addSubview(loaderView!)
        } else {
            self.navigationController?.view.addSubview(loaderView!)
        }
    }
    
   private func hideLoader () {
        if(loaderView != nil){
              loaderView?.removeFromSuperview()
        }
    }
    
    // MARK: - RegisterNib
    /**
     Registra a nib na tableView
     */
    func registerNibInTableView(_ tableView: UITableView, nibName: String){
        tableView.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: nibName)
    }
    
    /**
     Registra a nib na collectionView
     */
    func registerNibInCollectionView(_ collectionView: UICollectionView, nibName: String){
        collectionView.register(UINib(nibName: nibName, bundle: nil), forCellWithReuseIdentifier: nibName)
    }
}

//MARK: - Alets
extension UIViewController {
    func showNotImplementedAlert(){
        showAlert(title: "Alerta", message: "Função não implementada!", okBlock: nil, cancelBlock: nil)
    }
    
    func showSuccessAlert(message: String, okBlock:(() -> Void)?, cancelBlock: (() -> Void)?){
        showAlert(title: "Sucesso", message: message, okBlock: okBlock, cancelBlock: cancelBlock)
    }
    
    func showSuccessAlert(message: String){
        showAlert(title: "Sucesso", message: message, okBlock: nil, cancelBlock: nil)
    }
    
    func showErrorAlert(title:String = "Erro", message: String){
        showAlert(title: title, message: message, okBlock: nil, cancelBlock: nil)
    }
    
    func showErrorAlert(message: String, okBlock:(() -> Void)?, cancelBlock: (() -> Void)?){
        showAlert(title: "Erro", message: message, okBlock: okBlock, cancelBlock: cancelBlock)
    }
    
    func showAlert(title: String, message: String, okBlock:(() -> Void)?, cancelBlock: (() -> Void)?){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        var titleOkAction = "Ok"
        var titleCancelAction = "Cancelar"
        
        if (cancelBlock != nil) {
            titleOkAction = "sim".localized
            titleCancelAction = "nao".localized
        }
        
        
        let ok = UIAlertAction(title: titleOkAction, style: .default) { (action) in
            if let okBl = okBlock {
                okBl()
            }
            alert.dismiss(animated: true, completion: nil);
        }
        
        alert.addAction(ok)
        
        if let cancelBl = cancelBlock {
            let cancel = UIAlertAction(title: titleCancelAction, style: .cancel) { (action) in
                cancelBl()
            }
            alert.addAction(cancel)
        }
        
        self.present(alert, animated: true, completion: nil)
    }

}

//MARK: - NavBar
extension UIViewController {
    //MARK: - BacButton
    func createBackButton(onBack: Selector? = nil, icon:String = "ic_back") {
        
        let backbutton = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 44))
        
        //backbutton.imageView?.contentMode = .left
        backbutton.setTitle("", for: .normal)
        backbutton.setTitleColor(UIColor.white, for: .normal)
        backbutton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -30, bottom: 0, right: 0)
        backbutton.setImage(UIImage(named: icon), for: .normal)
        
        if onBack != nil {
            backbutton.addTarget(self, action: onBack!, for: .touchUpInside)
        } else {
            backbutton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        }
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backbutton)
        
    }
    
    @objc func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setupNavigationBar(hasBackButton:Bool, backIcon:String = "ic_back", isTransparent: Bool, title:String? = nil, titleColour:UIColor = .white, logo:String? = nil, leftButtons:[UIBarButtonItem]? = nil, rightButtons:[UIBarButtonItem]? = nil){
        
        /// Removes the default backButton of the navigation bar and adds ours
        if hasBackButton{
            createBackButton(icon: backIcon)
        }
        else{
            self.navigationItem.hidesBackButton = true
        }
        
        if isTransparent{
            setNavigationBarTranslucent()
        }
        
        if let title = title{
            self.title = title
            navigationController?.navigationBar.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor : titleColour,
                NSAttributedString.Key.font: UIFont(name: "PrometoTrial-Medium", size: 18)!
            ]
        }
        
        /// Adds the image to the cente rof the NavigationBar
        if let logo = logo, let image = UIImage(named: logo){
            let imgView = UIImageView(frame: .zero)
            imgView.image =  image
            imgView.frame = CGRect(x: 0, y: 0, width: 60, height: 35)
            imgView.contentMode = .scaleAspectFit
            self.navigationItem.titleView = imgView
        }
        
        /// Adds the actions to the left side of the NavigationBar
        if let leftButtons = leftButtons{
            self.navigationItem.leftBarButtonItems = leftButtons
        }
        
        /// Adds the actions to the right side of the NavigationBar
        if let rightButtons = rightButtons{
            self.navigationItem.rightBarButtonItems = rightButtons
        }
    }
    
    func setStatusBarStyle(_ style: UIStatusBarStyle) {
        if let statusBar = UIApplication.shared.value(forKey: "statusBar") as? UIView {
            statusBar.setValue(style == .lightContent ? UIColor.white : .black, forKey: "foregroundColor")
        }
    }
    
    func setNavigationBarTranslucent(){
        self.navigationController?.navigationBar.isTranslucent   = true
        self.navigationController?.navigationBar.barTintColor    = .clear
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    }
    
    func setNavigationBarNormalColor(){
        self.navigationController?.navigationBar.isTranslucent   = false
        self.navigationController?.navigationBar.barTintColor    = UIColor.appColor(.mainBlue)
        self.navigationController?.navigationBar.backgroundColor = UIColor.appColor(.mainBlue)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    }
}
