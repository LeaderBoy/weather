//
//  DustView.swift
//  weather
//
//  Created by 杨志远 on 16/7/11.
//  Copyright © 2016年 杨志远. All rights reserved.
//

import UIKit

enum DustType {
    case SMALLDUST
    case BIGDUST
    case NONE
}

class DustView: EmitterLayerView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func createDustView(dustType:DustType)
    {
        self.emitterLayer?.emitterShape = kCAEmitterLayerRectangle;
        self.emitterLayer?.emitterPosition =
            CGPoint(x: SCREEN_WIDTH/2, y: 0)
        
        let rect = CGRect(x: 0, y: -30, width: SCREEN_WIDTH, height: 200)
        
        self.emitterLayer?.frame = rect
        self.emitterLayer?.emitterSize = rect.size
        
        let dustCell = CAEmitterCell()

        switch dustType {
        case .SMALLDUST:
            dustCell.birthRate = 50
            dustCell.lifetime = 10
            dustCell.scale = 0.1
            dustCell.scaleRange = 0.05
            dustCell.scaleSpeed = -0.04
            dustCell.alphaSpeed = -0.05
            dustCell.alphaRange = 0.5
            dustCell.velocity = 0
            dustCell.yAcceleration = 0.5
            dustCell.xAcceleration = 5
            
        case .BIGDUST:
            dustCell.birthRate = 70
            dustCell.lifetime = 10
            dustCell.scale = 0.2
            dustCell.scaleRange = 0.05
            dustCell.scaleSpeed = -0.04
            dustCell.alphaSpeed = -0.05
            dustCell.alphaRange = 0.5
            dustCell.velocity = 0
            dustCell.yAcceleration = 1
            dustCell.xAcceleration = 40

            

        default:
            dustCell.birthRate = 50
            dustCell.lifetime = 10
            dustCell.scale = 0.1
            dustCell.scaleRange = 0.05
            dustCell.scaleSpeed = -0.04
            dustCell.alphaSpeed = -0.05
            dustCell.alphaRange = 0.5
            dustCell.velocity = 0
            dustCell.yAcceleration = 0.5
            dustCell.xAcceleration = 5

        }
        
      
        dustCell.color = UIColor(colorLiteralRed: 0, green: 0, blue: 0, alpha: 0.6).CGColor
        
        var fogImage = UIImage()
        
        fogImage = UIImage(named: "dust")!.scaleImage(10)
        dustCell.contents = fogImage.CGImage
        
        dustCell.emissionLongitude = CGFloat(-M_PI)
        
        self.emitterLayer?.emitterCells = [dustCell]
        
        self.layer.addSublayer(self.emitterLayer!)
        
        self.alpha = 0.0
    }
    
    func show(dustType:DustType)
    {
        self.createDustView(dustType)
        
        UIView.animateWithDuration(0.2, animations: {
            
            switch dustType
            {
            case.SMALLDUST:
                self.alpha = 0.4
            case.BIGDUST:
                self.alpha = 0.6
                
            default :
                self.alpha = 0.4
                
                
            }
        }) { (finish:Bool) in
            
            
        }
        
    }
    
    override func hide()
    {
        UIView.animateWithDuration(0.5) { () -> Void in
            self.alpha = 0.0
            self.removeFromSuperview()
        }
        
    }
    
    override func configurateViewType(type: EmitterType)
    {
        
    }
    
    

    

}
