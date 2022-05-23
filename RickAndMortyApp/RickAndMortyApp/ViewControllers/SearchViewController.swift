//
//  SearchViewController.swift
//  RickAndMortyApp
//
//  Created by Ludmila Rezunic on 09.05.2022.
//

import UIKit

final class SearchViewController: UIViewController {
    
    var stateController: StateController
    
    var allCharacters: [CharacterModel] {
        return stateController.allCharacters
    }
    
    var recentCharacters: [CharacterModel]{
        return stateController.recents
    }
    
    init(state: StateController){
        stateController = state
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        tableView.delegate = self
        tableView.dataSource = self
        navigationController?.isNavigationBarHidden = true
        view.addSubview(searchBar)
        view.addSubview(viewForTable)
        
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        viewForTable.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            viewForTable.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            viewForTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            viewForTable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            viewForTable.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
            
        ])
        
        viewForTable.addSubview(tableView)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = viewForTable.bounds
        tableView.bounds = tableView.frame.insetBy(dx: 16.0, dy: 0)
        tableView.backgroundColor = .white
        
    }
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(SectionView.self, forCellReuseIdentifier: SectionView.identifier)
        return table
    }()
    
    private let viewForTable: UIView = {
        return UIView()
    }()
    
    
    private lazy var searchBar: UISearchBar = {
        
        let ret = UISearchBar(frame: CGRect(x: 0, y: 0, width: 0, height: 55))
        ret.showsCancelButton = false
        ret.searchTextField.backgroundColor = .white
        ret.layer.borderColor = CGColor.init(red: 61/256, green: 62/256, blue: 64/256, alpha: 1 )
        ret.layer.borderWidth = 2
        ret.layer.cornerRadius = 10
        ret.placeholder = "Search for character"
        return ret
        
    }()
    
    
}



extension SearchViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SectionView.identifier, for: indexPath) as? SectionView else{
            return UITableViewCell()
        }
        
        cell.recents = recentCharacters
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        46
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        160
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Recent"
    }
    
}


final class SectionView: UITableViewCell{
    
    var recents: [CharacterModel] = []
    
    static let identifier = "SectionView"
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
        contentView.addSubview(collection)
        collection.delegate = self
        collection.dataSource = self
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collection.frame = contentView.bounds
        collection.showsHorizontalScrollIndicator = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SectionView: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        recents.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterIconCell.identifier, for: indexPath) as? CharacterIconCell else{
            return UICollectionViewCell()
        }
        cell.iconURL = recents[indexPath.row].imageURL
        
        cell.layer.cornerRadius = 10
        cell.layer.borderWidth = 1
        cell.layer.borderColor = CGColor.init(red: 61/256, green: 62/256, blue: 64/256, alpha: 1)
        return cell
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
