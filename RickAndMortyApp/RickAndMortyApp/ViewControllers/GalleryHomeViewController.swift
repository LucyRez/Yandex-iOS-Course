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
        view.addSubview(dismissButton)
        
        setUp()
        
        let image = UIImage(named: "HomeImage") ?? UIImage()
        self.imageScrollView.setImage(image: image)
        dismissButton.addTarget(self, action: #selector(dismissButtonPressed), for: .touchUpInside)
        

        
    }
    
    func setUp(){
        imageScrollView.translatesAutoresizingMaskIntoConstraints = false
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dismissButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            dismissButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),

            imageScrollView.topAnchor.constraint(equalTo: view.topAnchor),
            imageScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            imageScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
       
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.navigationController?.setNavigationBarHidden(true, animated: true)

    }
    
    private lazy var dismissButton: UIButton = {
        let ret = UIButton(type: .custom)
        ret.frame = CGRect(x: 0, y: 0, width: 48, height: 48)
        ret.clipsToBounds = true
        ret.setImage(UIImage(named: "DismissButton"), for: .normal)

        return ret
    }()
    
    private lazy var imageScrollView: ImageScrollView = {
        return ImageScrollView(frame: view.bounds)
    }()
    
    @objc func dismissButtonPressed(){
        navigationController?.popViewController(animated: true)

        dismiss(animated: true, completion: nil)
    }
    
}

