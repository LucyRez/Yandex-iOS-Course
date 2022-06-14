//
//  CharacterView.swift
//  RickAndMortyApp
//
//  Created by Ludmila Rezunic on 24.05.2022.
//

import SwiftUI

struct CharacterView: View {
    
    private var request: ImageRequest {
        ImageRequest(url: URL(string: model.imageURL!)!)
    }
    var state: StateController
    var model : Character
    
    @State var isLiked: Bool = false
    @State var characterImage: UIImage = UIImage()
    
    var body: some View {
        ScrollView{
            VStack(alignment: .center){
                Image(uiImage: characterImage)
                    .frame(width: 300, height: 300)
                    .cornerRadius(10)
                    .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(uiColor: .main), lineWidth: 1))
                    .padding(.top, 20)
                
                HStack{
                    Text(model.name)
                        .font(.custom("SFUIDisplay-Bold", size: 34))
                        .foregroundColor(Color(uiColor: .main))
                        .padding(.vertical, 20)
                    
                    Spacer()
                    
                    Button(action: {
                        if !isLiked{
                            Task{
                                await state.addToFavorites(characterToAdd: model)
                            }
                            
                        }else{
                            Task{
                                await state.removeFromFavourites(characterToRemove: model)
                            }
                        }
                        
                        isLiked.toggle()
                        
                    }, label:{
                        
                        if !isLiked{
                            Image("ButtonUnpressed")
                                .resizable()
                                .frame(width: 48, height: 48)
                            
                        }else{
                            Image("ButtonPressed")
                                .resizable()
                                .frame(width: 48, height: 48)
                        }
                        
                    })
                    
                }
                .padding(.horizontal, 16)
                
                CellView(key: "Status:", value: model.status)
                    .padding(.horizontal, 16)
                
                CellView(key: "Species:", value: model.species)
                    .padding(.horizontal, 16)
                
                CellView(key: "Gender:", value: model.gender)
                    .padding(.horizontal, 16)
                
                
            }
        }
        .task{
            await getAsyncImage()
        }
    }
    
    func getAsyncImage() async{
        do{
            characterImage = try await (request.execute() ?? UIImage())
        }
        catch{
            print(error) // TODO: Log error
        }
    }
}

struct CellView: View {
    let key: String
    let value: String
    var body: some View {
        VStack(alignment: .leading){
            Text(key)
                .font(.system(size: 22))
                .foregroundColor(Color(uiColor: .main))
                .bold()
            
            
            Text(value)
                .font(.system(size: 22))
                .bold()
            
            Rectangle()
                .frame( height: 1)
                .foregroundColor(Color(uiColor: .main))
                .padding(.top, 8)
            
            
        }
        
    }
}

