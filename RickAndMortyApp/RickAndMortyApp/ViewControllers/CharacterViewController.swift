//
//  CharacterViewController.swift
//  RickAndMortyApp
//
//  Created by Ludmila Rezunic on 02.05.2022.
//

import UIKit
import Kingfisher
import Combine

final class CharacterViewController: UIViewController {
    
    struct Model{
        let name: String
        let status: String
        let species: String
        let gender: String
        let imageURL: URL
    }
    
    init(model: Model){
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Character"
        setUp()
        updateInfo()
    }
    
    private func updateInfo(){
        icon.kf.setImage(with: model.imageURL)
        nameLabel.text = model.name
        status.update(with: CharacterInfoCellView.Model(key: "Status:", value: model.status, hasDivider: true))
        species.update(with: CharacterInfoCellView.Model(key: "Species:", value: model.species, hasDivider: true))
        gender.update(with: CharacterInfoCellView.Model(key: "Gender:", value: model.gender, hasDivider: false))
    }
    
    private func setUp(){
        view.addSubview(icon)
        view.addSubview(nameLabel)
        view.addSubview(status)
        view.addSubview(species)
        view.addSubview(gender)
        
        view.subviews.forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        
        NSLayoutConstraint.activate([
            icon.widthAnchor.constraint(equalToConstant: 300),
            icon.heightAnchor.constraint(equalToConstant: 300),
            icon.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            icon.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: icon.bottomAnchor, constant: 35),
            nameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            status.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 16),
            status.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            status.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            species.topAnchor.constraint(equalTo: status.bottomAnchor, constant: 16),
            species.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            species.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            gender.topAnchor.constraint(equalTo: species.bottomAnchor, constant: 16),
            gender.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            gender.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
        ])
    }
    
    private let model: Model
    
    
    private lazy var icon: UIImageView = {
        let ret = UIImageView()
        ret.layer.cornerRadius = 10
        ret.layer.masksToBounds = true
        ret.contentMode = .scaleAspectFill
        return ret
    }()
    
    private lazy var nameLabel: UILabel = {
        let ret = UILabel()
        ret.numberOfLines = 1
        ret.textColor = .main
        ret.font = .boldSystemFont(ofSize: 34)
        
        return ret
    }()
    
    private lazy var status = CharacterInfoCellView()
    private lazy var species = CharacterInfoCellView()
    private lazy var gender = CharacterInfoCellView()
    
    
    
}
