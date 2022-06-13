//
//  APIResponseModel.swift
//  RickAndMortyApp
//
//  Created by Ludmila Rezunic on 12.06.2022.
//

import Foundation


struct APIResponseModel: Codable{
    let info: InfoModel
    let results: [Character]?
}

struct InfoModel: Codable{
    let count: Int
    let pages: Int
    let next: String?
    
}
