//
//  CharacterView.swift
//  RickAndMortyApp
//
//  Created by Ludmila Rezunic on 24.05.2022.
//

import SwiftUI

struct CharacterView: View {
    
    var state: StateController
    var model : Character
    @State var isLiked: Bool = false
    
    var body: some View {
        ScrollView{
            VStack(alignment: .center){
                AsyncImage(url: URL(string: model.imageURL!)!).frame(width: 300, height: 300)
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
                            state.addToFavorites(name: model.name)
                            
                        }else{
                            state.removeFromFavourites(name: model.name)
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

