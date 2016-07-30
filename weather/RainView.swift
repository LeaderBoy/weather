//
//  RainView.swift
//  weather
//
//  Created by 杨志远 on 16/6/2.
//  Copyright © 2016年 杨志远. All rights reserved.
//

import UIKit
import AVFoundation
enum RainType
{
    case STORMRAIN
    case HEAVYRAIN
    case BIGRAIN
    case MIDRAIN
    case SMALLRAIN
    case NONE
    
}

enum ThunderType {
    case BIGTHUNDER
    case MIDTHUNDER
    case SMALLTHUNER
    case NONE
}

class RainView: EmitterLayerView {

   
   
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func createRainView(rainType:RainType,thundertype : ThunderType)
    {
        self.emitterLayer?.emitterShape = kCAEmitterLayerRectangle;
        self.emitterLayer?.emitterPosition = CGPoint(x: SCREEN_WIDTH/2, y: 0)
        let rect = CGRect(x: 0, y: -30, width: SCREEN_WIDTH, height: 50.0)
        
        self.emitterLayer?.frame = rect
        self.emitterLayer?.emitterSize = rect.size
        
        let rainCell = CAEmitterCell()
        
        
        switch rainType {
            
        case .STORMRAIN:
            rainCell.birthRate = 350
            rainCell.lifetime = 3.5
            rainCell.scale = 0.7
            rainCell.scaleSpeed = -0.2
            rainCell.scaleRange = 0.2
            rainCell.alphaRange = 0.5
            rainCell.alphaSpeed = -0.1
            rainCell.velocity = 20.0
            rainCell.yAcceleration = 200.0
            rainCell.xAcceleration = 10.0

            
        case .HEAVYRAIN:
            rainCell.birthRate = 300
            rainCell.lifetime = 3.5
            rainCell.scale = 0.7
            rainCell.scaleSpeed = -0.2
            rainCell.scaleRange = 0.2
            rainCell.alphaRange = 0.5
            rainCell.alphaSpeed = -0.1
            rainCell.velocity = 20.0
            rainCell.yAcceleration = 200.0
            rainCell.xAcceleration = 10.0

            
            
        case .BIGRAIN:
            rainCell.birthRate = 250
            rainCell.lifetime = 3.5
            rainCell.scale = 0.7
            rainCell.scaleSpeed = -0.2
            rainCell.scaleRange = 0.2
            rainCell.alphaRange = 0.5
            rainCell.alphaSpeed = -0.1
            rainCell.velocity = 20.0
            rainCell.yAcceleration = 200.0
            rainCell.xAcceleration = 10.0
        case .MIDRAIN:
            rainCell.birthRate = 150
            rainCell.lifetime = 3.5
            rainCell.scale = 0.7
            rainCell.scaleSpeed = -0.2
            rainCell.scaleRange = 0.2
            rainCell.alphaRange = 0.5
            rainCell.alphaSpeed = -0.1
            rainCell.velocity = 20.0
            rainCell.yAcceleration = 200.0
            rainCell.xAcceleration = 10.0
            
            
        case .SMALLRAIN:
            rainCell.birthRate = 100
            rainCell.lifetime = 3.5
            rainCell.scale = 0.7
            rainCell.scaleSpeed = -0.2
            rainCell.scaleRange = 0.2
            rainCell.alphaRange = 0.5
            rainCell.alphaSpeed = -0.1
            rainCell.velocity = 20.0
            rainCell.yAcceleration = 200.0
            rainCell.xAcceleration = 10.0
            
        default :
            rainCell.birthRate = 100
            rainCell.lifetime = 3.5
            rainCell.scale = 0.7
            rainCell.scaleSpeed = -0.2
            rainCell.scaleRange = 0.2
            rainCell.alphaRange = 0.5
            rainCell.alphaSpeed = -0.1
            rainCell.velocity = 20.0
            rainCell.yAcceleration = 200.0
            rainCell.xAcceleration = 10.0

            
        }
       
       
        
        
        
       
        rainCell.color = UIColor(colorLiteralRed: 1, green: 1, blue: 1, alpha: 0.6).CGColor
        
        var rainImage = UIImage()
       
        rainImage = UIImage(named: "rain10")!.scaleImage(15)
        
        rainCell.contents = rainImage.CGImage
 
        rainCell.emissionLongitude = CGFloat(-M_PI)
        
        self.emitterLayer?.emitterCells = [rainCell]
        
        self.layer.addSublayer(self.emitterLayer!)
        
        self.alpha = 0.0
    }
    
     func show(rainSound:Bool,rainType:RainType,thunderSound:Bool,thunderType:ThunderType)
    {
        self.createRainView(rainType, thundertype: thunderType)
        
        UIView.animateWithDuration(0.2, animations: { 
            self.alpha = 0.8
        }) { (finish:Bool) in
            if rainSound
            {
                playSoundEffect.shareinstance.playRainSoundEffect(rainType, withSound: rainSound)
            }
            
            if thunderSound
            {
                playSoundEffect.shareinstance.playThunderSoundEffect(thunderType, withSound: thunderSound)

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
