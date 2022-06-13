//
//  NetworkingController.swift
//  RickAndMortyApp
//
//  Created by Ludmila Rezunic on 13.06.2022.
//

import Foundation
import UIKit

final class NetworkingController{
    private var request: APIGenericRequest<CharactersResource>?
    private var currentPage = 1
    private var pagesCount: Int?
    private var searchText: String?

    func fetchSearchedCharacters(searchText: String, complete: @escaping ([Character]?) -> ()) async{
        currentPage = 1
        self.searchText = searchText
        let resource = CharactersResource()
        resource.filter = searchText
        resource.page = currentPage
        let request = APIGenericRequest(resource: resource)
        self.request = request

        do{
            let res = try await request.execute()
            pagesCount = res?.info.pages
            complete(res?.results)
            
        }catch{
            print(error)
        }

    }
    
    func fetchSearchedNextPage(complete: @escaping ([Character]?) -> ()) async{
        guard pagesCount != nil, pagesCount! > currentPage, searchText != nil else {return}
        currentPage += 1
        let resource = CharactersResource()
        resource.filter = searchText
        resource.page = currentPage
        let request = APIGenericRequest(resource: resource)
        self.request = request

        do{
            let res = try await request.execute()
            complete(res?.results)
            
        }catch{
            print(error)
        }
        
    }
    
    static func getAsyncImage(imageUrl: URL) async -> UIImage? {
        let request = ImageRequest(url: imageUrl)
        do{
            return try await request.execute()
        }catch{
            print(error) // TODO: Log error
            return nil
        }
    }
    
    
}
