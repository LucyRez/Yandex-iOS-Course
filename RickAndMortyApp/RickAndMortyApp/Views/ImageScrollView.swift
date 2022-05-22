//
//  ImageScrollView.swift
//  RickAndMortyApp
//
//  Created by Ludmila Rezunic on 22.05.2022.
//

import UIKit

class ImageScrollView: UIScrollView, UIScrollViewDelegate{

   
    private lazy var imageToZoom: UIImageView = UIImageView()

    override init(frame: CGRect){
        super.init(frame: frame)
        self.delegate = self
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setImage(image: UIImage){
               
        imageToZoom = UIImageView(image: image)
       
        self.addSubview(imageToZoom)
        
        self.contentSize = image.size
        self.minimumZoomScale = 0.5
        self.maximumZoomScale = 7.0
    }
    

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageToZoom
    }
}
