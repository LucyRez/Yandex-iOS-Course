//
//  CharacterStorage.swift
//  RickAndMortyApp
//
//  Created by Ludmila Rezunic on 14.06.2022.
//

import Foundation


enum Category: String{
    case favourites
    case searched
}

class CharacterStorage: Storage{
    
    typealias DataModel = [Character]
    let documentsURL: URL
    
    init(){
        documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    func save<DataModel: Codable>(_ data: DataModel, forKey key: Category.RawValue) async throws {
        let url = documentsURL.appendingPathComponent("\(key).json")
        let jsonData = try JSONEncoder().encode(data)
        try jsonData.write(to: url)
    }
    
    func get<DataModel: Codable>(forKey key: Category.RawValue) async -> DataModel? {
        let url = documentsURL.appendingPathComponent("\(key).json")
        guard FileManager.default.fileExists(atPath: url.path) else{
            return [] as? DataModel
        }
        let content = FileManager.default.contents(atPath: url.path)!

        do{
            return try JSONDecoder().decode([Character].self, from: content) as? DataModel

        }catch{
            print(error)
            // TODO: Log error
        }
        
        return [] as? DataModel

    
    }
    
  

    
//    func saveCharacters(_ characters: [Character], for category: Category) async throws
//    func getCharacters(from category: Category) async -> [Character]
  
}
