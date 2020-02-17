//
//  UserRepository.swift
//  Desafio Hanzo
//
//  Created by Caio Cardozo on 16/02/20.
//  Copyright © 2020 CaioCardozo. All rights reserved.
//

import Foundation

struct UserRepository : Codable {
    var id: Int?
    var name: String?
    var full_name: String?
    var prv: Bool?
    var owner: Owner?
    var html_url: String?
    var desc: String?
    var stars: Int?
    var watchers: Int?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case full_name
        case prv = "private"
        case owner
        case html_url
        case desc = "description"
        case stars = "stargazers_count"
        case watchers
    }
}
