//
//  APIResource.swift
//  RickAndMortyApp
//
//  Created by Ludmila Rezunic on 12.06.2022.
//

import Foundation


struct Resource<T> {
    let url: URL
}

protocol APIResource{
    associatedtype ModelType: Codable
    var methodPath: String {get}
    var filter: String? {get}
    var page: Int? {get}
}

extension APIResource{
    var url: URL {
        var components = URLComponents(string: "https://rickandmortyapi.com/api")!
        components.path = methodPath
        
        if let filter = filter{
            components.queryItems?.append(URLQueryItem(name: "name", value: filter))
        }
        
        if let page = page{
            components.queryItems?.append(URLQueryItem(name: "page", value: String(page)))
        }
        
        return components.url!
    }
}
