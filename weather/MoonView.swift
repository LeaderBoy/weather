//
//  MoonView.swift
//  weather
//
//  Created by 杨志远 on 16/6/5.
//  Copyright © 2016年 杨志远. All rights reserved.
//

import UIKit

class MoonView: UIView {
    var shapLayer : CAShapeLayer?
    var arcCenter : CGPoint?
    var radius : CGFloat?
    var startAngle : CGFloat?
    var endAngle : CGFloat?
    var clockWise : Bool?
    var controlPoint : CGPoint?
    var moonPath:UIBezierPath?

    //var moonPath : UIBezierPath?


    override init(frame: CGRect) {
        super.init(frame: frame)


            moonPath = UIBezierPath()
    
    }
    
   
   
    
    func createMoon()
    {

        shapLayer = CAShapeLayer()
        shapLayer?.frame = self.bounds
        shapLayer?.lineWidth = 5
        shapLayer?.fillColor = UIColor.whiteColor().CGColor
        arcCenter = self.center
        
        radius = self.bounds.size.width/2
        startAngle = CGFloat(0.5 * M_PI)
        endAngle = CGFloat(1.5 * M_PI)
        
        clockWise = false
        
        
        moonPath?.addArcWithCenter(arcCenter!, radius: radius!, startAngle: startAngle!, endAngle: endAngle!, clockwise: clockWise!)


        
        moonPath!.moveToPoint(CGPoint(x:self.center.x, y:0 ))
        
        
        
        
       let  toPoint = CGPoint(x:self.center.x , y: self.center.y + self.bounds.size.width/2)
        
        controlPoint = CGPoint(x: self.center.x + self.bounds.size.width/2, y: self.center.y)
        
        moonPath!.addQuadCurveToPoint(toPoint, controlPoint: controlPoint!)
        

        
        
        shapLayer?.path = moonPath!.CGPath

        shapLayer?.strokeColor = UIColor.whiteColor().CGColor
        
        self.layer.addSublayer(shapLayer!)
     
        self.alpha = 0.0

    }
    
    
    func show(withSound:Bool)
    {
        self.createMoon()
        UIView.animateWithDuration(0.2, animations: { 
            self.alpha = 0.8
        }) { (finish:Bool) in
            
            if withSound
            {
                playSoundEffect.shareinstance.playMoonSoundEffect()

            }

        }
    }
    
    
    func hide()
    {
        UIView.animateWithDuration(0.2) { () -> Void in
            self.alpha = 0.0
            self.removeFromSuperview()
        }
    }
    
    
    
    
    
    
    
    
    
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
