//
//  StarView.swift
//  weather
//
//  Created by 杨志远 on 16/6/7.
//  Copyright © 2016年 杨志远. All rights reserved.
//

import UIKit

var shapeLayer : CAShapeLayer?

class StarView: UIView {
    
    
    var starPath : UIBezierPath?

    override init(frame: CGRect) {
        super.init(frame: frame)
        starPath = UIBezierPath()
    }
    
    
    
    func createViewWith(bigStar:Bool)
    {
        
        shapeLayer = CAShapeLayer()
        shapeLayer?.frame = self.bounds
        shapeLayer?.fillMode = kCAFillModeBackwards

        shapeLayer?.fillColor = UIColor(red: 0.896, green: 0.856, blue: 0.417, alpha: 1.000).CGColor
        if bigStar
        {
            starPath!.moveToPoint(CGPointMake(12.12, -0.25))
            starPath!.addLineToPoint(CGPointMake(16.31, 5.73))
            starPath!.addLineToPoint(CGPointMake(23.42, 7.78))
            starPath!.addLineToPoint(CGPointMake(18.9, 13.53))
            starPath!.addLineToPoint(CGPointMake(19.1, 20.78))
            starPath!.addLineToPoint(CGPointMake(12.12, 18.35))
            starPath!.addLineToPoint(CGPointMake(5.15, 20.78))
            starPath!.addLineToPoint(CGPointMake(5.35, 13.53))
            starPath!.addLineToPoint(CGPointMake(0.83, 7.78))
            starPath!.addLineToPoint(CGPointMake(7.94, 5.73))
            starPath!.closePath()
        }else
        {
            starPath!.moveToPoint(CGPointMake(8, -0.25))
            starPath!.addLineToPoint(CGPointMake(10.73, 4))
            starPath!.addLineToPoint(CGPointMake(15.37, 5.45))
            starPath!.addLineToPoint(CGPointMake(12.42, 9.53))
            starPath!.addLineToPoint(CGPointMake(12.56, 14.67))
            starPath!.addLineToPoint(CGPointMake(8, 12.95))
            starPath!.addLineToPoint(CGPointMake(3.44, 14.67))
            starPath!.addLineToPoint(CGPointMake(3.58, 9.53))
            starPath!.addLineToPoint(CGPointMake(0.63, 5.45))
            starPath!.addLineToPoint(CGPointMake(5.27, 4))
            starPath!.closePath()
        }
        
        
        shapeLayer?.path = starPath!.CGPath
        
        self.layer.addSublayer(shapeLayer!)
        self.alpha = 0.0
        
    }
    
    
    func show(bigStar:Bool)
    {
        self.createViewWith(bigStar)
        UIView.animateWithDuration(0.2) {
            self.alpha = 0.8
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
