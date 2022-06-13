//
//  Storage.swift
//  RickAndMortyApp
//
//  Created by Ludmila Rezunic on 07.06.2022.
//

import Foundation

protocol Storage{
    associatedtype DataModel: Codable

    func save<DataModel: Codable>(_ data: DataModel, forKey key: String) async throws
    func get<DataModel: Codable>(forKey key: String) async -> DataModel?
}


