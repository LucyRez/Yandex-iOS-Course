//
//  CharacterViewController.swift
//  RickAndMortyApp
//
//  Created by Ludmila Rezunic on 02.05.2022.
//

import UIKit
import Kingfisher

final class CharacterViewController: UIViewController {
    
    var state: StateController
    
    struct Model{
        let name: String
        let status: String
        let species: String
        let gender: String
        let imageURL: URL
        var isLiked: Bool
    }
    
    init(model: Model, state: StateController){
        self.model = model
        self.state = state
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        view.backgroundColor = .systemBackground
        model.isLiked = state.favorites.contains(where: {(character: CharacterModel) -> Bool in
            character.name == model.name
        })
        likeButton.addTarget(self, action: #selector(likeButtonPressed), for: .touchUpInside)
        title = "Character"
        setUp()
        updateInfo()
        
        state.addToRecent(name: model.name)
    }
    
    private func updateInfo(){
        icon.kf.setImage(with: model.imageURL)
        nameLabel.text = model.name
        
        if(!model.isLiked){
            likeButton.setImage(UIImage(named: "ButtonUnpressed"), for: .normal)
            
        }else{
            likeButton.setImage(UIImage(named: "ButtonPressed"), for: .normal)
        }
        
        status.update(with: CharacterInfoCellView.Model(key: "Status:", value: model.status, hasDivider: true))
        species.update(with: CharacterInfoCellView.Model(key: "Species:", value: model.species, hasDivider: true))
        gender.update(with: CharacterInfoCellView.Model(key: "Gender:", value: model.gender, hasDivider: false))
    }
    
    private func setUp(){
        
        
//        view.addSubview(icon)
//        view.addSubview(nameLabel)
//        view.addSubview(status)
//        view.addSubview(species)
//        view.addSubview(gender)
//        view.addSubview(likeButton)
//
//        view.subviews.forEach{
//            $0.translatesAutoresizingMaskIntoConstraints = false
//        }
//
//
//        NSLayoutConstraint.activate([
//            icon.widthAnchor.constraint(equalToConstant: 300),
//            icon.heightAnchor.constraint(equalToConstant: 300),
//            icon.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
//            icon.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            nameLabel.topAnchor.constraint(equalTo: icon.bottomAnchor, constant: 35),
//            nameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
//            nameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -85),
//            likeButton.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 16),
//            likeButton.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
//            status.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 16),
//            status.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
//            status.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
//            species.topAnchor.constraint(equalTo: status.bottomAnchor, constant: 16),
//            species.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
//            species.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
//            gender.topAnchor.constraint(equalTo: species.bottomAnchor, constant: 16),
//            gender.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
//            gender.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
//
//        ])
        
        // add the scroll view to self.view
        
        let screensize: CGRect = UIScreen.main.bounds
        let screenWidth = screensize.width
        let screenHeight = screensize.height

        scrollView = UIScrollView(frame: CGRect(x: 0, y: 120, width: screenWidth, height: screenHeight))

        view.addSubview(scrollView)

        // add labelOne to the scroll view
        scrollView.addSubview(icon)
        icon.translatesAutoresizingMaskIntoConstraints = false
        // add labelTwo to the scroll view
        scrollView.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false

        scrollView.addSubview(likeButton)
        likeButton.translatesAutoresizingMaskIntoConstraints = false

        scrollView.addSubview(status)
        status.translatesAutoresizingMaskIntoConstraints = false

        scrollView.addSubview(species)
        species.translatesAutoresizingMaskIntoConstraints = false

        scrollView.addSubview(gender)
        gender.translatesAutoresizingMaskIntoConstraints = false


        view.subviews.forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        
        // always a good idea to respect safe area
        let safeG = view.safeAreaLayoutGuide
        
        // we want to constrain subviews to the scroll view's Content Layout Guide
        let contentG = scrollView.contentLayoutGuide
        
        NSLayoutConstraint.activate([
            
            // constrain the scroll view to safe area with 8-pts on each side
            scrollView.topAnchor.constraint(equalTo: safeG.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: safeG.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeG.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeG.bottomAnchor),
//
            icon.widthAnchor.constraint(equalToConstant: 300),
            icon.heightAnchor.constraint(equalToConstant: 300),
            icon.topAnchor.constraint(equalTo: contentG.topAnchor, constant: 20),
            icon.centerXAnchor.constraint(equalTo: contentG.centerXAnchor),
           
            nameLabel.topAnchor.constraint(equalTo: icon.bottomAnchor, constant: 35.0),
            nameLabel.leadingAnchor.constraint(equalTo: contentG.leadingAnchor, constant: 16.0),
            nameLabel.trailingAnchor.constraint(equalTo: contentG.trailingAnchor, constant: -85),

            likeButton.trailingAnchor.constraint(equalTo: contentG.trailingAnchor, constant: -16),
            likeButton.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            status.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 16),
            status.leadingAnchor.constraint(equalTo: contentG.leadingAnchor, constant: 16),
            status.trailingAnchor.constraint(equalTo: contentG.trailingAnchor, constant: -16),
            species.topAnchor.constraint(equalTo: status.bottomAnchor, constant: 16),
            species.leadingAnchor.constraint(equalTo: contentG.leadingAnchor, constant: 16),
            species.trailingAnchor.constraint(equalTo: contentG.trailingAnchor, constant: -16),
            gender.bottomAnchor.constraint(equalTo: contentG.bottomAnchor, constant: -16),
            gender.trailingAnchor.constraint(equalTo: contentG.trailingAnchor, constant: -16)
           
            
        ])
        
       
        //scrollView.contentSize = CGSize(width: screenWidth, height: 2000)

        
    }
    
    private var model: Model
    
    private lazy var scrollView: UIScrollView = {
        let v = UIScrollView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    
    
    private lazy var icon: UIImageView = {
        let ret = UIImageView()
        ret.layer.cornerRadius = 10
        ret.layer.masksToBounds = true
        ret.contentMode = .scaleAspectFill
        return ret
    }()
    
    private lazy var nameLabel: UILabel = {
        let ret = UILabel()
        ret.numberOfLines = 0
        ret.lineBreakMode = .byWordWrapping
        ret.textColor = .main
        ret.font = .boldSystemFont(ofSize: 34)
        
        return ret
    }()
    
    private lazy var likeButton: UIButton = {
        let ret = UIButton(type: .custom)
        ret.frame = CGRect(x: 0, y: 0, width: 48, height: 48)
        ret.clipsToBounds = true

        return ret
    }()
    
    private lazy var status = CharacterInfoCellView()
    private lazy var species = CharacterInfoCellView()
    private lazy var gender = CharacterInfoCellView()
    
    @objc func likeButtonPressed() {
        if model.isLiked {
            state.removeFromFavourites(name: model.name)
        }else{
            state.addToFavorites(name: model.name)
        }
        
        model.isLiked = !model.isLiked
        updateInfo()
    }
    
}
