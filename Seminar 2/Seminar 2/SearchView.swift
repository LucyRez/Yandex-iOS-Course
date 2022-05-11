//
//  SearchView.swift
//  Seminar 2
//
//  Created by Ludmila Rezunic on 26.04.2022.
//

import Foundation
import UIKit

final class SearchViewController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension SearchViewController: UITableViewDelegate{
    
}

extension SearchViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        return UITableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
}

final class SectionView: UITableViewCell{
    
    struct Model{
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
    private let titleLabel = UILabel()
    
    private func setup(){
        
    }
    
    
}

extension UITableViewCell{
    static var defaultReusableIdentifier: String{
        return String(describing: Self.self)
    }
}
