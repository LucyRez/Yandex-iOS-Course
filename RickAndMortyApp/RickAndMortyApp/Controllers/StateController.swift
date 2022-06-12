//
//  StateController.swift
//  RickAndMortyApp
//
//  Created by Ludmila Rezunic on 23.05.2022.
//

import Foundation


class StateController{
    
    let allCharacters: [CharacterModel] = [
        CharacterModel(name: "Rick Sanchez", status: "Alive", species: "Human", gender: "Male", imageURL: URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg")!),
        CharacterModel(name: "Morty Smith", status: "Alive", species: "Human", gender: "Male", imageURL: URL(string: "https://rickandmortyapi.com/api/character/avatar/2.jpeg")!),
        CharacterModel(name: "Summer Smith", status: "Alive", species: "Human", gender: "Female", imageURL: URL(string: "https://rickandmortyapi.com/api/character/avatar/3.jpeg")!),
        CharacterModel(name: "Beth Smith", status: "Alive", species: "Human", gender: "Female", imageURL: URL(string: "https://rickandmortyapi.com/api/character/avatar/4.jpeg")!),
        CharacterModel(name: "Jerry Smith", status: "Alive", species: "Human", gender: "Male", imageURL: URL(string: "https://rickandmortyapi.com/api/character/avatar/5.jpeg")!),
        CharacterModel(name: "Abadango Cluster Princess", status: "Alive", species: "Alien", gender: "Female", imageURL: URL(string: "https://rickandmortyapi.com/api/character/avatar/6.jpeg")!),
        CharacterModel(name: "Abradolf Lincler", status: "Unknown", species: "Human", gender: "Male", imageURL: URL(string: "https://rickandmortyapi.com/api/character/avatar/7.jpeg")!),
        CharacterModel(name: "Adjudicator Rick", status: "Dead", species: "Human", gender: "Male", imageURL: URL(string: "https://rickandmortyapi.com/api/character/avatar/8.jpeg")!),
        CharacterModel(name: "Agency Director", status: "Dead", species: "Human", gender: "Male", imageURL: URL(string: "https://rickandmortyapi.com/api/character/avatar/9.jpeg")!),
        CharacterModel(name: "Alan Rails", status: "Dead", species: "Human", gender: "Male", imageURL: URL(string: "https://rickandmortyapi.com/api/character/avatar/10.jpeg")!),
        CharacterModel(name: "Albert Einstein", status: "Dead", species: "Human", gender: "Male", imageURL: URL(string: "https://rickandmortyapi.com/api/character/avatar/11.jpeg")!),
        CharacterModel(name: "Alexander", status: "Dead", species: "Human", gender: "Male", imageURL: URL(string: "https://rickandmortyapi.com/api/character/avatar/12.jpeg")!),
        CharacterModel(name: "Alien Googah", status: "Uknown", species: "Alien", gender: "Unknown", imageURL: URL(string: "https://rickandmortyapi.com/api/character/avatar/13.jpeg")!),
        CharacterModel(name: "Alien Morty", status: "Unknown", species: "Alien", gender: "Male", imageURL: URL(string: "https://rickandmortyapi.com/api/character/avatar/14.jpeg")!),
        CharacterModel(name: "Alien Rick", status: "Unknown", species: "Alien", gender: "Male", imageURL: URL(string: "https://rickandmortyapi.com/api/character/avatar/15.jpeg")!),
        CharacterModel(name: "Amish Cyborg", status: "Dead", species: "Alien", gender: "Male", imageURL: URL(string: "https://rickandmortyapi.com/api/character/avatar/16.jpeg")!),
        CharacterModel(name: "Annie", status: "Alive", species: "Human", gender: "Female", imageURL: URL(string: "https://rickandmortyapi.com/api/character/avatar/17.jpeg")!),
        CharacterModel(name: "Antenna Morty", status: "Alive", species: "Human", gender: "Male", imageURL: URL(string: "https://rickandmortyapi.com/api/character/avatar/18.jpeg")!),
        CharacterModel(name: "Antenna Rick", status: "Unknown", species: "Human", gender: "Male", imageURL: URL(string: "https://rickandmortyapi.com/api/character/avatar/19.jpeg")!),
        CharacterModel(name: "Ants in my Eyes Johnson", status: "Unknown", species: "Human", gender: "Male", imageURL: URL(string: "https://rickandmortyapi.com/api/character/avatar/20.jpeg")!),
        
    ]
    
    var favorites: [CharacterModel] = [
        CharacterModel(name: "Abadango Cluster Princess", status: "Alive", species: "Alien", gender: "Female", imageURL: URL(string: "https://rickandmortyapi.com/api/character/avatar/6.jpeg")!),
        CharacterModel(name: "Abradolf Lincler", status: "Unknown", species: "Human", gender: "Male", imageURL: URL(string: "https://rickandmortyapi.com/api/character/avatar/7.jpeg")!),
        CharacterModel(name: "Adjudicator Rick", status: "Dead", species: "Human", gender: "Male", imageURL: URL(string: "https://rickandmortyapi.com/api/character/avatar/8.jpeg")!),]
    
    var recents: [CharacterModel] = [
        CharacterModel(name: "Rick Sanchez", status: "Alive", species: "Human", gender: "Male", imageURL: URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg")!),
        CharacterModel(name: "Morty Smith", status: "Alive", species: "Human", gender: "Male", imageURL: URL(string: "https://rickandmortyapi.com/api/character/avatar/2.jpeg")!),
        CharacterModel(name: "Summer Smith", status: "Alive", species: "Human", gender: "Female", imageURL: URL(string: "https://rickandmortyapi.com/api/character/avatar/3.jpeg")!),]
    
    func addToFavorites(name: String){
        let characterFound = favorites.first(where: {(character: CharacterModel) -> Bool in
            character.name == name
        } )
        
        if characterFound != nil{
            return
        }
        
        let character = allCharacters.first(where: {(character: CharacterModel) -> Bool in
            character.name == name
        } )
        
        favorites.append(character!)
    
    }
    
    func removeFromFavourites(name: String){
        let characterFound = favorites.firstIndex(where: {(character: CharacterModel) -> Bool in
            character.name == name
        } )
        
        if characterFound != nil{
            favorites.remove(at: characterFound!)
        }
        
        return
    }
    
    func addToRecent(name: String){
        if(recents.count > 10){
            recents.popLast()
        }
        
        let characterFound = recents.firstIndex(where: {(character: CharacterModel) -> Bool in
            character.name == name
        } )
        
        if characterFound != nil{
            recents.remove(at: characterFound!)
        }
        
        let character = allCharacters.first(where: {(character: CharacterModel) -> Bool in
            character.name == name
        } )
        
        recents.insert(character!, at: 0)
    }
    
}


struct CharacterModel{
    let name: String
    let status: String
    let species: String
    let gender: String
    let imageURL: URL
}
