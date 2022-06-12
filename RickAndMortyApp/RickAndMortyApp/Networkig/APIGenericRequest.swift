//
//  CharactersRequest.swift
//  RickAndMortyApp
//
//  Created by Ludmila Rezunic on 12.06.2022.
//

import Foundation

class APIGenericRequest<Resource: APIResource>{
    let resource: Resource
    
    init(resource: Resource){
        self.resource = resource
    }
}

extension APIGenericRequest: APIRequest{

    func decode(_ data: Data) -> [Resource.ModelType]? {
        let decoder = JSONDecoder()
        let decodedModel = try? decoder.decode(Wrapper<Resource.ModelType>.self, from: data)
        return decodedModel?.results
    }
    
    func execute() async throws -> Array<Resource.ModelType>? {
        try await load(url: resource.url)
    }
}
