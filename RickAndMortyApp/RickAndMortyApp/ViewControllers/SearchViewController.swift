//
//  SearchViewController.swift
//  RickAndMortyApp
//
//  Created by Ludmila Rezunic on 09.05.2022.
//

import UIKit

final class SearchViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        let ret = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 55))
        ret.layer.cornerRadius = 10
        ret.layer.borderColor = CGColor.init(red: 61/256, green: 62/256, blue: 64/256, alpha: 1 )
        ret.layer.borderWidth = 2
        
        tableView.tableHeaderView = ret
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        tableView.bounds = tableView.frame.insetBy(dx: 16.0, dy: 16.0)
        tableView.backgroundColor = .white
        
    }
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(SectionView.self, forCellReuseIdentifier: SectionView.identifier)
        return table
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
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterIconCell.identifier, for: indexPath) as? CharacterIconCell else{
            return UICollectionViewCell()
        }
        
        cell.layer.cornerRadius = 10
        cell.layer.borderWidth = 1
        cell.layer.borderColor = CGColor.init(red: 61/256, green: 62/256, blue: 64/256, alpha: 1)
        return cell
    }
}

final class CharacterIconCell: UICollectionViewCell{
    
    static let identifier = "CharacterIconCell"
    
    override init(frame: CGRect) {
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
        icon.kf.setImage(with: URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg"))
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
