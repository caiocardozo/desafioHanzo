//
//  PublicRepositoryTableViewCell.swift
//  Desafio Hanzo
//
//  Created by Caio Cardozo on 16/02/20.
//  Copyright © 2020 CaioCardozo. All rights reserved.
//

import UIKit

class PublicRepositoryTableViewCell: UITableViewCell {

    @IBOutlet weak var titleRepositoryLabel: UILabel!
    @IBOutlet weak var privateRepositoryLabel: UILabel!
    @IBOutlet weak var descriptionRepositoryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(repository: PublicRepositoryModel) {
        titleRepositoryLabel.text = repository.name
        privateRepositoryLabel.text = repository.prv ?? false ? "Privado" : "Aberto"
        descriptionRepositoryLabel.text = repository.desc
    }    
}
