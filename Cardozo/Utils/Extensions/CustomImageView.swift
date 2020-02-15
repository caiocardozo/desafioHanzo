//
//  CustomImageView.swift
//  Cardozo
//
//  Created by Caio Cardozo on 19/05/19.
//  Copyright © 2019 CaioCardozo. All rights reserved.
//

import Foundation
import SDWebImage

extension UIImageView {
    /**
     Insere a imagem. Se a URL for null, então coloca a imagem default NAME_PLACEHOLDER_NO_PHOTO
     */
    func setImage(imageURL: String?){
        if let imgURL = imageURL {
            UIView.animate(withDuration: 0.5) {
                self.sd_setImage(with: URL(string: imgURL), completed: nil)
            }
        }
        else {
            self.image = UIImage(named: Constants.placeHolderNoPhoto)
        }
        
    }
}
