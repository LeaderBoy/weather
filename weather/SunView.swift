//
//  SunView.swift
//  weather
//
//  Created by 杨志远 on 16/6/5.
//  Copyright © 2016年 杨志远. All rights reserved.
//

import UIKit


class SunView: UIView {
    


  override  init(frame: CGRect) {
        super.init(frame: frame)

    self.backgroundColor = UIColor.clearColor()

    }
    
    
    override func drawRect(rect: CGRect) {
        
    
    
        let context = UIGraphicsGetCurrentContext();
        
        let gradient:CGGradientRef?
        let rgb = CGColorSpaceCreateDeviceRGB();
        
        let colors : [CGFloat] =
        [
            255.0/255.0,3/255,0,1
            ,
            255.0/255.0,19/255,0,1
            ,
            255.0/255.0,35/255,0,1
            ,
            255.0/255.0,51/255,0,1
            ,
            255.0/255.0,67/255,0,1
            ,
            255.0/255,83/255,0,1
            ,
            255.0/255,99/255,0,1
            ,
            255.0/255,115/255,0,1
            ,
            255.0/255,131/255,0,1
            ,
            255.0/255,252/255,251/255,0.2,
            ]
        gradient = CGGradientCreateWithColorComponents(rgb, colors, nil, 11);
        
        let width = self.frame.size.width;
        let height = self.frame.size.height;
        let radius = (width>height ? height : width)/2;
        
        let startPoint = CGPoint( x: radius, y: radius);
        let endPoint = CGPoint(x: radius, y: radius);
        let startRadius : CGFloat = 0.0
        let endRadius = radius;
        
        CGContextDrawRadialGradient(context, gradient, startPoint, startRadius, endPoint, endRadius, CGGradientDrawingOptions.DrawsAfterEndLocation);
        
        self.alpha = 0
        

    }
    
   
    

  
    
    
       
    
    

        
    
    
    
    
    
    
    
    func show(withSound:Bool)
    {
        self.setNeedsDisplay()
        UIView.animateWithDuration(0.5) { () -> Void in
            self.alpha = 0.8
            if withSound
            {
                playSoundEffect.shareinstance.playSunSoundEffect()

            }

        }
    }
    
    
    func hide()
    {
        UIView.animateWithDuration(0.5) { () -> Void in
            self.alpha = 0.0
            self.removeFromSuperview()
        }
    }
    
    
    
    
    
    
    
    
    

  required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
}
