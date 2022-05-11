//
//  FavoritesViewController.swift
//  RickAndMortyApp
//
//  Created by Ludmila Rezunic on 10.05.2022.
//

import UIKit

final class FavoritesViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        tableView.dataSource = self
        tableView.delegate = self
        setUp()
        
    }
    
    private func setUp(){
        view.addSubview(tableView)
        
        
        
        view.subviews.forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        tableView.tableHeaderView = Header(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 78))
        
        
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        
        
        tableView.separatorStyle = .none
    }
    
//    private lazy var viewLabel: UILabel = {
//        let ret = UILabel()
//        ret.frame = CGRect(x: 0, y: 0, width: view.bounds.width-32, height: 41)
//        ret.numberOfLines = 1
//        ret.textColor = .main
//        ret.font = .boldSystemFont(ofSize: 34)
//        ret.text = "Favorites"
//
//        NSLayoutConstraint.activate([
//            ret.topAnchor.constraint(equalTo: tableView.topAnchor, constant: 19),
//            ret.leadingAnchor.constraint(equalTo: tableView.leadingAnchor, constant: 16),
//
//        ])
//
//        return ret
//    }()
    
    
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
            label.topAnchor.constraint(equalTo: topAnchor, constant: 19),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterCell.identifier, for: indexPath) as? CharacterCell else{
            return UITableViewCell()
        }
        
        return cell
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
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 52),
            //nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
            line.topAnchor.constraint(equalTo: icon.bottomAnchor, constant: 22),
            line.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            line.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateInfo(){
        icon.kf.setImage(with: URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg"))
        nameLabel.text = "Rick Sanchez"
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
        ret.numberOfLines = 1
        ret.textColor = .main
        ret.font = .boldSystemFont(ofSize: 22)
        return ret
    }()
    
    private let line: Line = {
        let ret = Line()
        return ret
    }()
    
    //    override func draw(_ rect: CGRect) {
    //      guard let context = UIGraphicsGetCurrentContext() else {
    //        return
    //      }
    //
    //      let y = bounds.maxY - 0.5
    //      let minX = bounds.minX
    //      let maxX = bounds.maxX
    //
    //      context.setStrokeColor(CGColor.init(red: 61/256, green: 62/256, blue: 64/256, alpha: 1))
    //      context.setLineWidth(1.0)
    //      context.move(to: CGPoint(x: minX, y: y))
    //      context.addLine(to: CGPoint(x: maxX, y: y))
    //      context.strokePath()
    //    }
    
    
}
