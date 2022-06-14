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
    
    func save(_ data: DataModel, forKey key: Category.RawValue) async throws {
        let url = documentsURL.appendingPathComponent("\(key).json")
        let jsonData = try JSONEncoder().encode(data)
        try jsonData.write(to: url)
    }
    
    func get(forKey key: Category.RawValue) async -> DataModel? {
        let url = documentsURL.appendingPathComponent("\(key).json")
        guard FileManager.default.fileExists(atPath: url.path) else{
            return []
        }
        let content = FileManager.default.contents(atPath: url.path)!

        do{
            return try JSONDecoder().decode([Character].self, from: content)

        }catch{
            print(error)
            // TODO: Log error
        }
        
        return []

    
    }
  
}
