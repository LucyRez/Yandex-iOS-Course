//
//  GalleryHomeViewController.swift
//  RickAndMortyApp
//
//  Created by Ludmila Rezunic on 22.05.2022.
//

import UIKit

class GalleryHomeViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(imageScrollView)
        
        setUp()
        
        let image = UIImage(named: "HomeImage") ?? UIImage()
        self.imageScrollView.setImage(image: image)
        
    }
    
    func setUp(){
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        imageScrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageScrollView.topAnchor.constraint(equalTo: view.topAnchor),
            imageScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            imageScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
       
    }
    
    
    
    private lazy var imageScrollView: ImageScrollView = {
        return ImageScrollView(frame: view.bounds)
    }()
    
}
