//
//  PublicRepositoryEmptyTableViewCell.swift
//  Desafio Hanzo
//
//  Created by Caio Cardozo on 16/02/20.
//  Copyright © 2020 CaioCardozo. All rights reserved.
//

import UIKit

class PublicRepositoryEmptyTableViewCell: UITableViewCell {

    @IBOutlet weak var textMessageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    private func setup() {
        textMessageLabel.text = "Nenhum repositório encontrado."
    }
}
