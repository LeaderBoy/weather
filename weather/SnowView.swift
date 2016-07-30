//
//  SnowView.swift
//  weather
//
//  Created by 杨志远 on 16/6/2.
//  Copyright © 2016年 杨志远. All rights reserved.
//

import UIKit

enum SnowType {
    case SMALLSNOW
    case MIDSNOW
    case BIGSNOW
    case HEAVYSNOW
    case NONE
}

class SnowView: EmitterLayerView {


    
    override init(frame: CGRect) {
        super.init(frame: frame)

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    
    }
    
    func createSnowView(snowType:SnowType)
    {
        self.emitterLayer?.emitterShape = kCAEmitterLayerRectangle;
        self.emitterLayer?.emitterPosition = CGPoint(x: self.bounds.size.width/2, y: 0)
        let rect = CGRect(x: 0, y: -30, width: self.bounds.size.width, height: 50.0)
        
        self.emitterLayer?.frame = rect
        self.emitterLayer?.emitterSize = rect.size
        
        let snowCell = CAEmitterCell()
        snowCell.color = UIColor(colorLiteralRed: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).CGColor
        
        var snowImage = UIImage()


        switch snowType {
        case .SMALLSNOW:
            snowCell.birthRate = 30
            snowCell.lifetime = 3.5
            snowCell.scale = 0.6
            snowCell.scaleSpeed = -0.1
            snowCell.scaleRange = 0.2
            snowCell.alphaRange = 0.5
            snowCell.alphaSpeed = -0.1
            snowCell.velocity = 20.0
            snowImage = UIImage(named: "snow")!.scaleImage(30)
            snowCell.yAcceleration = 150
            snowCell.xAcceleration = 10.0

        case .MIDSNOW:
            snowCell.birthRate = 60
            snowCell.lifetime = 3.5
            snowCell.scale = 0.6
            snowCell.scaleSpeed = -0.1
            snowCell.scaleRange = 0.2
            snowCell.alphaRange = 0.5
            snowCell.alphaSpeed = -0.1
            snowCell.velocity = 20.0
            snowImage = UIImage(named: "snow")!.scaleImage(30)
            snowCell.yAcceleration = 150
            snowCell.xAcceleration = 10.0

        case .BIGSNOW:
            snowCell.birthRate = 90
            snowCell.lifetime = 3.5
            snowCell.scale = 0.6
            snowCell.scaleSpeed = -0.1
            snowCell.scaleRange = 0.2
            snowCell.alphaRange = 0.5
            snowCell.alphaSpeed = -0.1
            snowCell.velocity = 20.0
            snowImage = UIImage(named: "snow")!.scaleImage(30)
            snowCell.yAcceleration = 150
            snowCell.xAcceleration = 10.0

        case .HEAVYSNOW:
            snowCell.birthRate = 120
            snowCell.lifetime = 3.5
            snowCell.scale = 0.6
            snowCell.scaleSpeed = -0.1
            snowCell.scaleRange = 0.2
            snowCell.alphaRange = 0.5
            snowCell.alphaSpeed = -0.1
            snowCell.velocity = 20.0
            snowImage = UIImage(named: "snow")!.scaleImage(30)
            snowCell.yAcceleration = 150
            snowCell.xAcceleration = 10.0

            
            
        default:
            snowCell.birthRate = 30
            snowCell.lifetime = 3.5
            snowCell.scale = 0.6
            snowCell.scaleSpeed = -0.1
            snowCell.scaleRange = 0.2
            snowCell.alphaRange = 0.5
            snowCell.alphaSpeed = -0.1
            snowCell.velocity = 20.0
            snowImage = UIImage(named: "snow")!.scaleImage(30)
            snowCell.yAcceleration = 150
            snowCell.xAcceleration = 10.0
            
        }
        
        
        
        
        snowCell.contents = snowImage.CGImage
        
   
        snowCell.emissionLongitude = CGFloat(-M_PI)
        
        self.emitterLayer?.emitterCells = [snowCell]
        self.layer.addSublayer(self.emitterLayer!)
        
        self.alpha = 0.0
    }
    
    func show(withSound:Bool,snowType:SnowType)
    {
        self.createSnowView(snowType)

       UIView.animateWithDuration(0.2, animations: { 
        self.alpha = 0.8
       }) { (finish:Bool) in
        
        if withSound
        {
            playSoundEffect.shareinstance.playSnowfieldSoundEffect()

        }

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
