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

    func decode(_ data: Data) -> APIResponseModel? {
        let decoder = JSONDecoder()
        let decodedModel = try? decoder.decode(APIResponseModel.self, from: data)
        return decodedModel
    }
    
    func execute() async throws -> APIResponseModel? {
        try await load(url: resource.url)!
    }
}
