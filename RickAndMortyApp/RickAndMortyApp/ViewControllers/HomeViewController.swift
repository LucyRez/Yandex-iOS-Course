//
//  HomeViewController.swift
//  RickAndMortyApp
//
//  Created by Ludmila Rezunic on 21.05.2022.
//

import UIKit
import SwiftUI

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        

        setUp()

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        
        homeImage.isUserInteractionEnabled = true
        homeImage.addGestureRecognizer(tapGestureRecognizer)
                
    }
    
    private func setUp(){
        view.addSubview(mainTitle)
        view.addSubview(subtitle)
        view.addSubview(homeImage)
        homeImage.image = UIImage(named: "HomeImage")
        view.backgroundColor = .background
        
        view.subviews.forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            mainTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            mainTitle.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            mainTitle.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            subtitle.topAnchor.constraint(equalTo: mainTitle.bottomAnchor, constant: 24),
            subtitle.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            subtitle.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            homeImage.widthAnchor.constraint(equalToConstant: 446),
            homeImage.heightAnchor.constraint(equalToConstant: 446),
            homeImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            homeImage.topAnchor.constraint(equalTo: subtitle.bottomAnchor, constant: 45),
            
        ])
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.navigationController?.setNavigationBarHidden(true, animated: true)

    }
    
    
    private lazy var homeImage: UIImageView = {
        
        let ret = UIImageView()
        ret.clipsToBounds = true
        ret.contentMode = .scaleAspectFill
        
        return ret
    }()
    
    private lazy var mainTitle: UILabel = {
                 
        let ret = UILabel()
        let attributes: [NSAttributedString.Key : Any] = [.strokeColor: UIColor.main,
                                                          .foregroundColor: UIColor.background,
                                                          .strokeWidth: -1.0,
                                                          .font : UIFont(name: "SFUIDisplay-Black", size: 72) ?? UIFont.systemFont(ofSize: 72)
        ]
    

        ret.attributedText = NSAttributedString(string: "RICK\nAND\nMORTY", attributes: attributes)
        ret.numberOfLines = 0
        ret.lineBreakMode = .byWordWrapping
        
 
        return ret
    }()
    
    private lazy var subtitle: UILabel = {
        
        let ret = UILabel()
        
        ret.font = UIFont(name: "SFUIDisplay-Black", size: 32)
        ret.textColor = .main
        ret.numberOfLines = 0
        ret.lineBreakMode = .byWordWrapping
        ret.text = "CHARACTER\nBOOK"
        
        return ret
    }()

    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer){
        guard let tappedImage = tapGestureRecognizer.view as? UIImageView else {
            return
        }
        
        let vc = GalleryHomeViewController()
        vc.transitioningDelegate = self
        present(vc, animated: true)

    }
  
}

extension HomeViewController: UIViewControllerTransitioningDelegate{
  
    
    func animationController(forPresented presented: UIViewController,
                                presenting: UIViewController,
                                source: UIViewController)
           -> UIViewControllerAnimatedTransitioning?
       {
           return AnimatorController(presentationImage: homeImage)
       }
    

    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }
}


