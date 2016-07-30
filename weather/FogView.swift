//
//  FogView.swift
//  weather
//
//  Created by 杨志远 on 16/7/11.
//  Copyright © 2016年 杨志远. All rights reserved.
//

import UIKit

enum FogType {
    case SMALLFOG
    case NORMALFOG
    case NONE
}

enum ColorType {
    case DUSTCOLOR
    case FOGCOLOR
    case RAINCOLOR
    case NONE
}

class FogView: EmitterLayerView {
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func createFogView(fogType:FogType,color:ColorType)
    {
        self.emitterLayer?.emitterShape = kCAEmitterLayerRectangle;
        self.emitterLayer?.emitterPosition =
            CGPoint(x: SCREEN_WIDTH/2, y: 0)
    
        let rect = CGRect(x: 0, y: -30, width: SCREEN_WIDTH, height: 200)
        
        self.emitterLayer?.frame = rect
        self.emitterLayer?.emitterSize = rect.size
        
        let fogCell = CAEmitterCell()
        
        
        switch  fogType{
            
        case .SMALLFOG:
            fogCell.birthRate = 120
            fogCell.lifetime = 10
            fogCell.scale = 0.7
            fogCell.scaleRange = 0.2
            fogCell.scaleSpeed = -0.1
            fogCell.alphaSpeed = -0.05
            fogCell.alphaRange = 0.5
            fogCell.velocity = 0
            fogCell.yAcceleration = 0.5
            fogCell.xAcceleration = 5
            
            
        case .NORMALFOG:
            fogCell.birthRate = 100
            fogCell.lifetime = 3.5
            fogCell.scale = 0.7
            fogCell.scaleRange = 0.2
            fogCell.alphaRange = 0.5
            fogCell.velocity = 20.0
            fogCell.yAcceleration = 0
            fogCell.xAcceleration = 10.0
            
            
        
            
        default :
            fogCell.birthRate = 100
            fogCell.lifetime = 3.5
            fogCell.scale = 0.7
            fogCell.scaleRange = 0.2
            fogCell.alphaRange = 0.5
            fogCell.velocity = 20.0
            fogCell.yAcceleration = 0.5
            fogCell.xAcceleration = 5
            
            
        }
        
        
        switch color {
        case .FOGCOLOR:
            fogCell.color = UIColor(colorLiteralRed: 1, green: 1, blue: 1, alpha: 0.6).CGColor

            
        case .DUSTCOLOR:
            fogCell.color = UIColor(colorLiteralRed: 189/255, green: 115/255, blue: 0, alpha: 0.6).CGColor

        default:
            fogCell.color = UIColor(colorLiteralRed: 1, green: 1, blue: 1, alpha: 0.6).CGColor

        }
    
        
        var fogImage = UIImage()
        
        fogImage = UIImage(named: "fog")!
        fogCell.contents = fogImage.CGImage
        
        fogCell.emissionLongitude = CGFloat(-M_PI)
        
        self.emitterLayer?.emitterCells = [fogCell]
        
        self.layer.addSublayer(self.emitterLayer!)
        
        self.alpha = 0.0
    }
    
    func show(fogType:FogType,colorType:ColorType)
    {
        self.createFogView(fogType, color: colorType)
        
        UIView.animateWithDuration(0.2, animations: {
            
            switch fogType
            {
            case.SMALLFOG:
                self.alpha = 0.2
            case.NORMALFOG:
                self.alpha = 0.5
                
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
