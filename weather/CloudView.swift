//
//  CloudView.swift
//  weather
//
//  Created by 杨志远 on 16/6/7.
//  Copyright © 2016年 杨志远. All rights reserved.
//

import UIKit

class CloudView: UIView {

    var cloudImageName : String?
    
  
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createCloudView(imageName:String)
    {
       let image = UIImage(named:imageName)
        
        let cloudImageView = UIImageView()
        cloudImageView.frame = self.bounds
        cloudImageView.image = image
        
        
        self.addSubview(cloudImageView)
        self.alpha = 0.0
        
    }
    
    
    func show()
    {
        UIView.animateWithDuration(0.2) { 
            self.createCloudView(self.cloudImageName!)
            self.alpha = 1
        }
    }
    
    func hide()
    {
        UIView.animateWithDuration(0.2) {
            self.alpha = 0

            self.removeFromSuperview()
        }
    }
    
    
   
    
    
    
    

}
