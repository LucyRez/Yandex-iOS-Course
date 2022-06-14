//
//  FavoritesViewController.swift
//  RickAndMortyApp
//
//  Created by Ludmila Rezunic on 10.05.2022.
//

import UIKit
import SwiftUI

final class FavoritesViewController: UIViewController {
    
    var stateController: StateController
    var favorites: [Character] = []
    
    init(state: StateController){
        stateController = state
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        
        setUp()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = .background
        print("Loaded favorites")
        Task{
            favorites = await stateController.getFavCharacters()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.navigationController?.setNavigationBarHidden(true, animated: true)

    }
 
    
    private func setUp(){
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self

        
        view.subviews.forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        tableView.tableHeaderView = Header(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 78))
              
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        tableView.backgroundColor = .background
        tableView.separatorStyle = .none
    }
    
    private lazy var tableView: UITableView = {
        let ret = UITableView()
        ret.register(CharacterCell.self, forCellReuseIdentifier: CharacterCell.identifier)
        return ret
    }()
}

private final class Header: UIView{
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
            label.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterCell.identifier, for: indexPath) as? CharacterCell else{
            return UITableViewCell()
        }
        
        cell.iconURL = URL(string: favorites[indexPath.row].imageURL!)!
        cell.name = favorites[indexPath.row].name
        
        return cell
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let character = favorites[indexPath.row]
//        let characterVC = CharacterViewController(model: CharacterViewController.Model(name: character.name, status: character.status, species: character.species, gender: character.gender, imageURL: character.imageURL, isLiked: true), state: stateController)
//        
//        let isLiked = stateController.favorites.contains(where: {(char: CharacterModel) -> Bool in
//            char.name == character.name
//        })
//        
        let vc = UIHostingController(rootView: CharacterView(state: stateController, model: character, isLiked: true))
        
        Task{
            await stateController.addToRecent(characterToAdd: character)
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        139
    }
    
}

final class CharacterCell: UITableViewCell{
    static let identifier = "CharacterCell"
    
    var iconURL: URL{
        set{
            icon.kf.setImage(with: newValue)
        }
        get{
            return URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg")!
        }
    }
    
    // TODO: Add property
    var name: String{
        set{
            nameLabel.text = newValue
        }
        get{
            return "Rick Sanchez"
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .background
        contentView.addSubview(icon)
        contentView.addSubview(nameLabel)
        contentView.addSubview(line)
        updateInfo()
        
        contentView.subviews.forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            
            icon.widthAnchor.constraint(equalToConstant: 100),
            icon.heightAnchor.constraint(equalToConstant: 100),
            icon.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            icon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 24),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            //nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 52),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            line.topAnchor.constraint(equalTo: icon.bottomAnchor, constant: 22),
            line.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            line.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateInfo(){
        icon.kf.setImage(with: iconURL)
        nameLabel.text = name
    }
    
    private lazy var icon: UIImageView = {
        let ret = UIImageView()
        ret.layer.cornerRadius = 10
        ret.layer.masksToBounds = true
        ret.layer.borderWidth = 1
        ret.layer.borderColor = CGColor.init(red: 61/256, green: 62/256, blue: 64/256, alpha: 1)
        ret.contentMode = .scaleAspectFit
        return ret
    }()
    
    private lazy var nameLabel: UILabel = {
        let ret = UILabel()
        ret.textColor = .main
        ret.lineBreakMode = .byWordWrapping
        ret.numberOfLines = 0
        ret.font = .boldSystemFont(ofSize: 22)
        return ret
    }()
    
    private let line: Line = {
        let ret = Line()
        return ret
    }()
    
    
}
