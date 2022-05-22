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
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        self.centerImage()
        
    }
    
    func setImage(image: UIImage){
               
        imageToZoom = UIImageView(image: image)
       
        self.addSubview(imageToZoom)
        
        self.contentSize = image.size
        setMaxMinScale()
        
        self.zoomScale = self.minimumZoomScale
    }
    
    private func setMaxMinScale(){
        let boundsSize = self.bounds.size
        let imageSize = imageToZoom.bounds.size
        
        let xScale = boundsSize.width/imageSize.width
        let yScale = boundsSize.height/imageSize.height
        let minScale = min(xScale, yScale)
        
        var maxScale = 1.0
        
        if minScale < 0.1{
            maxScale = 0.3
        }else if minScale >= 0.1 && minScale < 0.5{
            maxScale = 0.7
        }else if minScale >= 0.5{
            maxScale = max(1.0, minScale)
        }
        self.minimumZoomScale = minScale
        self.maximumZoomScale = maxScale
    }

    func centerImage(){
        let boundsSize = self.bounds.size
        var frameToCenter = imageToZoom.frame
        
        if frameToCenter.size.width < boundsSize.width{
            frameToCenter.origin.x = (boundsSize.width - frameToCenter.size.width)/2
            
        }else{
            frameToCenter.origin.x = 0
        }
        
        if frameToCenter.size.height < boundsSize.height{
            frameToCenter.origin.y = (boundsSize.height - frameToCenter.size.height)/2
            
        }else{
            frameToCenter.origin.y = 0
        }
        
        imageToZoom.frame = frameToCenter
    
    
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageToZoom
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        self.centerImage()
    }
}
