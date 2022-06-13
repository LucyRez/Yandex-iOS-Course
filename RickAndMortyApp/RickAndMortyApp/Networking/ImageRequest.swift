//
//  ImageRequest.swift
//  RickAndMortyApp
//
//  Created by Ludmila Rezunic on 12.06.2022.
//

import Foundation
import UIKit

class ImageRequest{
    
    let url: URL
    
    init(url: URL){
        self.url = url
    }
}

//extension ImageRequest: APIRequest{
//    func decode(_ data: Data) -> UIImage? {
//        return UIImage(data: data)
//    }
//    
//    func execute() async throws -> UIImage? {
//        try await load(url: url)
//    }
//}
