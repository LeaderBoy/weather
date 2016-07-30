//
//  WindView.swift
//  weather
//
//  Created by 杨志远 on 16/7/17.
//  Copyright © 2016年 杨志远. All rights reserved.
//

import UIKit

enum WindType {
    case SMALLWIND //小风
    case MIDWIND   //中风
    case BIGWIND   //大风
    case STORMWIND //暴风
    case NONE
    
}

class WindView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createWindViewWith(windType:WindType)
    {
        let imageView1 = UIImageView(frame: CGRect(x:21, y: 75/2, width: 69/2, height: 75))
        
        print(self.center)
        
        
        
        
        imageView1.image = UIImage(named: "fengche1")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        
        
        let imageView2 = UIImageView(frame: CGRect(x: 0, y: 0, width: 75, height: 75))
        imageView2.image = UIImage(named: "fengche")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = M_PI * 2
        switch windType {
        case .SMALLWIND:
            rotationAnimation.duration = 10
        case .MIDWIND:
            rotationAnimation.duration = 3
        case .BIGWIND:
            rotationAnimation.duration = 1.5
        case .STORMWIND:
            rotationAnimation.duration = 1
        
        default:
            rotationAnimation.duration = 12

        }
        rotationAnimation.repeatCount = HUGE
        imageView2.layer.addAnimation(rotationAnimation, forKey: "rotationAnimation")
     
        self.addSubview(imageView1)
        self.addSubview(imageView2)
        self.alpha = 0.0
    }
    
    func show(windType:WindType)
    {
        self.createWindViewWith(windType)
        UIView.animateWithDuration(0.2) { 
            self.alpha = 1.0
        }
    }
    
    func hide()
    {
        UIView.animateWithDuration(0.2) {
            self.alpha = 0.0
            self.removeFromSuperview()
        }
    }
    
    
    
    

}
