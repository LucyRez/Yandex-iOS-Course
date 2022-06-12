//
//  Storage.swift
//  RickAndMortyApp
//
//  Created by Ludmila Rezunic on 07.06.2022.
//

import Foundation

protocol Storage{
    func save<T: Codable>(_ data: T, forKey key: String)
    func get<T: Codable>(forKey key: String) -> T?
}

enum Tab{
    case main
    case favourites
}

enum Category{
    case favourites
    case searched
}

protocol CharacterStorage{
    func saveCharacters(_ characters: [Character], for category: Category) async throws
    func getCharacters(from category: Category) async -> [Character]
  
}
