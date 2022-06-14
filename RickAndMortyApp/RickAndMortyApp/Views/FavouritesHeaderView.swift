//
//  FavouritesHeaderView.swift
//  RickAndMortyApp
//
//  Created by Ludmila Rezunic on 14.06.2022.
//

import Foundation
import UIKit

final class FavouritesHeaderView: UIView{
    let label = UILabel(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = .main
        label.font = .boldSystemFont(ofSize: 34)
        label.text = "Favorites"
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.0),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.0),
            label.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
