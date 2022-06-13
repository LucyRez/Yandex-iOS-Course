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

//    var methodPath: String{
//        guard let id = id else {
//            return "character"
//        }
//        
//        return "character/\(id)"
//    }
    
    var filter: String?
    var page: Int?
}
