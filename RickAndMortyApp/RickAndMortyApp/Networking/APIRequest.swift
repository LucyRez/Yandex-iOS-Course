//
//  APIRequest.swift
//  RickAndMortyApp
//
//  Created by Ludmila Rezunic on 12.06.2022.
//

import Foundation

protocol APIRequest: AnyObject{
    func decode(_ data: Data) -> APIResponseModel?
    func execute() async throws -> APIResponseModel?
}

extension APIRequest{
    func load(url: URL) async throws -> APIResponseModel? {
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse else{
            throw APIError.noResponse
        }
        
        print(url)

        guard response.statusCode == 200 else {
            throw APIError.not200
        }
        
        guard let decoded = decode(data) else {
            throw APIError.dataError
        }
        
        return decoded
    }
}

enum APIError: Error{
    case noResponse
    case not200
    case dataError
    
}
