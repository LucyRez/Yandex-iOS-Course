//
//  SearchViewController.swift
//  RickAndMortyApp
//
//  Created by Ludmila Rezunic on 09.05.2022.
//

import UIKit
import SwiftUI

final class SearchViewController: UIViewController {
    
    var stateController: StateController
    var networkingController = NetworkingController()
    
    var isSearching: Bool
    var filteredCharacters: [Character] = []
    
    var recents: [Character] = []
    var favorites: [Character] = []
    
    init(state: StateController){
        stateController = state
        isSearching = false
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(searchBar)
        view.addSubview(viewForTable)
        viewForTable.addSubview(tableView)
        
        setUpConstraints()
        
        view.backgroundColor = .background
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        Task{
            recents = await stateController.getSearchedCharacters()
            favorites = await stateController.getFavCharacters()

            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = viewForTable.bounds
        tableView.backgroundColor = .background
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        
    }
    
    private func setUpConstraints(){
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        viewForTable.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            viewForTable.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 16),
            viewForTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            viewForTable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            viewForTable.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
    }
    
    private let viewForTable: UIView = {
        let ret = UIView()
        ret.backgroundColor = .background
        return ret
    }()
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(RecentSectionView.self, forCellReuseIdentifier: RecentSectionView.identifier)
        table.register(SearchSectionView.self, forCellReuseIdentifier: SearchSectionView.identifier)
        table.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 1))
        return table
    }()
    
    
    private lazy var searchBar: UISearchBar = {
        let ret = UISearchBar(frame: CGRect(x: 0, y: 0, width: 0, height: 55))
        ret.showsCancelButton = false
        ret.searchTextField.backgroundColor = .background
        ret.layer.borderColor = UIColor.main.cgColor
        ret.layer.borderWidth = 2
        ret.layer.cornerRadius = 10
        ret.placeholder = "Search for character"
        ret.backgroundColor = .background
        return ret
    }()
    
    
}


extension SearchViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if !searchText.trimmingCharacters(in: [" "]).isEmpty {
            fetchSearchedCharacters(searchText: searchText)
            self.isSearching = false

        }else{
            isSearching = false
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private func fetchSearchedCharacters(searchText: String){
        Task{
            guard !isSearching else { return }
            isSearching = true
            
            await networkingController.fetchSearchedCharacters(searchText: searchText){ [weak self] filteredResult in
                self?.filteredCharacters = []
                self?.filteredCharacters.append(contentsOf: filteredResult ?? [])
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isSearching ? filteredCharacters.count : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if !isSearching {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: RecentSectionView.identifier , for: indexPath) as? RecentSectionView else{
                return UITableViewCell()
            }
            
            cell.navigationController = navigationController!
            cell.state = stateController
            cell.charactersToShow = recents
            cell.favorites = favorites
            return cell
            
        }else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchSectionView.identifier , for: indexPath) as? SearchSectionView else{
                return UITableViewCell()
            }
            cell.name = filteredCharacters[indexPath.row].name
            cell.species = filteredCharacters[indexPath.row].species
            let stringUrl: String = filteredCharacters[indexPath.row].imageURL!
            cell.iconURL = URL(string: stringUrl)!
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let character = filteredCharacters[indexPath.row]
        let isLiked = favorites.contains(where: {(char: Character) -> Bool in
                char.id == character.id
        })
        
        let vc = UIHostingController(rootView: CharacterView(state: stateController, model: character, isLiked: isLiked))
        
        Task{
            await stateController.addToRecent(characterToAdd: character)
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        isSearching ? 200 : 160
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return isSearching ? nil : "Recent"
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return isSearching ? 1 : 20
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        let tableViewContentSizeHeight = tableView.contentSize.height
        let scrollViewHeight = scrollView.frame.size.height
                
        if position > (tableViewContentSizeHeight - 100 - scrollViewHeight) {
            Task{
                await networkingController.fetchSearchedNextPage(){ [weak self] filteredResult in
                    self?.filteredCharacters.append(contentsOf: filteredResult ?? [])
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            }
        }
    }
    
    
}

final class RecentSectionView: UITableViewCell{
    
    var characters: [Character] = []
    var favorites: [Character]?
    var navigationController: UINavigationController?
    var state: StateController?
    
    var charactersToShow: [Character] {
        set{
            characters = newValue
            collection.reloadData()
        }
        get{
            return characters
        }
    }
    
    static let identifier = "RecentSectionView"
    private let collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 120, height: 160)
        let ret = UICollectionView(frame: .zero, collectionViewLayout: layout)
        ret.register(CharacterIconCell.self, forCellWithReuseIdentifier: CharacterIconCell.identifier)
        return ret
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        navigationController = nil
        state = nil
        contentView.backgroundColor = .background
        contentView.addSubview(collection)
        collection.delegate = self
        collection.dataSource = self
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collection.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0))
        collection.showsHorizontalScrollIndicator = false
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RecentSectionView: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        charactersToShow.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterIconCell.identifier, for: indexPath) as? CharacterIconCell else{
            return UICollectionViewCell()
        }
        
        
        cell.iconURL = URL(string: charactersToShow[indexPath.row].imageURL!)!
        
        cell.layer.cornerRadius = 10
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.main.cgColor
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let character = charactersToShow[indexPath.row]
        
        let isLiked = favorites?.contains(where: {(char: Character) -> Bool in
            char.id == character.id
        })
        
        let vc = UIHostingController(rootView: CharacterView(state: state!, model: character, isLiked: isLiked ?? false))
        
        Task{
            await state?.addToRecent(characterToAdd: character)

        }
        navigationController?.pushViewController(vc, animated: true)
    }
}

final class CharacterIconCell: UICollectionViewCell{
    
    static let identifier = "CharacterIconCell"
    var iconURL: URL{
        set{
            icon.kf.setImage(with: newValue)
        }
        get{
            return URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg")!
        }
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        addSubview(icon)
        updateInfo()
        
        icon.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            icon.widthAnchor.constraint(equalToConstant: 120),
            icon.heightAnchor.constraint(equalToConstant: 160),
        ])
    }
    
    private func updateInfo(){
        icon.kf.setImage(with: iconURL)
    }
    
    
    private lazy var icon: UIImageView = {
        let ret = UIImageView()
        ret.layer.cornerRadius = 10
        ret.layer.masksToBounds = true
        ret.contentMode = .scaleAspectFill
        return ret
    }()
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

final class SearchSectionView: UITableViewCell{
    static let identifier = "SearchSectionView"
    var iconURL: URL{
        set{
            icon.kf.setImage(with: newValue)
        }
        get{
           return URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg")!
        }
    }
    
    var name: String{
        set{
            let str = newValue.split(separator: " ")
            var res = String(str[0]) + "\n"
            for (index, item) in str.enumerated(){
                if index != 0{
                    res += (String(item) + " ")
                }
            }
            
            nameLabel.text = res
        }
        
        get{
            return "Rick Sanchez"
        }
    }
    
    var species: String{
        set{
            speciesLabel.text = newValue
        }
        get{
            return "Human"
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(icon)
        contentView.addSubview(labelsPlaceholder)
        labelsPlaceholder.addArrangedSubview(nameLabel)
        labelsPlaceholder.addArrangedSubview(speciesLabel)
        //contentView.addSubview(nameLabel)
        contentView.addSubview(line)
        updateInfo()
        
        contentView.subviews.forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            
            icon.widthAnchor.constraint(equalToConstant: 120),
            icon.heightAnchor.constraint(equalToConstant: 160),
            icon.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            icon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            labelsPlaceholder.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            labelsPlaceholder.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 24),
            labelsPlaceholder.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            line.topAnchor.constraint(equalTo: icon.bottomAnchor, constant: 23),
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
        speciesLabel.text = species
        
    }
    
    private lazy var icon: UIImageView = {
        let ret = UIImageView()
        ret.layer.cornerRadius = 10
        ret.layer.masksToBounds = true
        ret.layer.borderWidth = 1
        ret.layer.borderColor = UIColor.main.cgColor
        ret.contentMode = .scaleAspectFill
        return ret
    }()
    
    private lazy var labelsPlaceholder: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.contentMode = .left
        stack.axis = .vertical
        stack.spacing = 16
        return stack
    }()
    
    private lazy var nameLabel: UILabel = {
        let ret = UILabel()
        ret.textColor = .main
        ret.lineBreakMode = .byWordWrapping
        ret.numberOfLines = 0
        ret.font = .boldSystemFont(ofSize: 22)
        return ret
    }()
    
    private lazy var speciesLabel: UILabel = {
        let ret = UILabel()
        ret.textColor = .key
        ret.numberOfLines = 1
        ret.font = .boldSystemFont(ofSize: 17)
        return ret
    }()
    
    private let line: Line = {
        let ret = Line()
        return ret
    }()
    
}


