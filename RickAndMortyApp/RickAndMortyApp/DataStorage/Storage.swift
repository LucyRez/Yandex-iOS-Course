//
//  Storage.swift
//  RickAndMortyApp
//
//  Created by Ludmila Rezunic on 07.06.2022.
//

import Foundation

protocol Storage{
    associatedtype DataModel: Codable

    func save(_ data: DataModel, forKey key: String) async throws
    func get(forKey key: String) async -> DataModel?
}


