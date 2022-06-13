//
//  FilteredCharactersResource.swift
//  RickAndMortyApp
//
//  Created by Ludmila Rezunic on 12.06.2022.
//

import Foundation

class CharactersResource: APIResource{
    typealias ModelType = APIResponseModel
    
    var id: Int?
    var filter: String?
    var page: Int?
}
