//
//  Character.swift
//  RickAndMortyApp
//
//  Created by Ludmila Rezunic on 12.06.2022.
//

import Foundation
import UIKit

struct Character: Codable{
    let id: Int
    let name: String
    let status: String
    let species: String
    let gender: String
    let imageURL: String?
    
    enum CodingKeys: String, CodingKey{
        case id, name, status, species, gender
        case imageURL = "image"
    }
}

    
    
   
