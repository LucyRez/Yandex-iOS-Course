//
//  CharacterInfoCellView.swift
//  RickAndMortyApp
//
//  Created by Ludmila Rezunic on 03.05.2022.
//

import UIKit

final class CharacterInfoCellView: UIView {

    struct Model{
        let key: String
        let value: String
        let hasDivider: Bool
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp(){
        let stack = UIStackView()
        addSubview(stack)
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.contentMode = .left
        stack.axis = .vertical
        stack.spacing = 0
        
        addSubview(line)

        stack.addArrangedSubview(keyLabel)
        stack.addArrangedSubview(valueLabel)
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        line.translatesAutoresizingMaskIntoConstraints = false
      
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            line.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 8),
            line.leadingAnchor.constraint(equalTo: leadingAnchor),
            line.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
        
    }
    
    func update(with model: Model){
        keyLabel.text = model.key
        valueLabel.text = model.value
    }
    
//    private let stack: UIStackView = {
//        let ret = UIStackView()
//
//        ret.axis = .vertical
//        ret.alignment = .fill
//        ret.distribution = .fillEqually
//        ret.contentMode = .left
//        ret.spacing = 0
//
//        return ret
//    }()
    
    private let keyLabel: UILabel = {
        let ret = UILabel()
        ret.font = .boldSystemFont(ofSize: 22)
        ret.textColor = .key
        ret.numberOfLines = 1
        return ret
    }()
    
    private let valueLabel: UILabel = {
        let ret = UILabel()
        ret.font = .boldSystemFont(ofSize: 22)
        ret.textColor = .main
        ret.numberOfLines = 1
        return ret
    }()
    
    private let line: Line = {
        let ret = Line()
        return ret
    }()
    

}

final class Line: UIView{
    override init(frame: CGRect){
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp(){
        backgroundColor = .main
        translatesAutoresizingMaskIntoConstraints = false
      
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 1),
        ])
        
    }
}
