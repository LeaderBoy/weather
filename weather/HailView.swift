//
//  HailView.swift
//  weather
//
//  Created by 杨志远 on 16/7/11.
//  Copyright © 2016年 杨志远. All rights reserved.
//

import UIKit


class HailView: EmitterLayerView {

    var hailImage : UIImage?
    var birthRate : CGFloat?
    var lifeTime : CGFloat?
    var speed : CGFloat?
    var hailColor : UIColor?
    var speedRange : CGFloat?
    var gravity : CGFloat?
    
    var hailType : HailView?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func createHailView()
    {
        
        
        self.emitterLayer?.emitterShape = kCAEmitterLayerRectangle;
        self.emitterLayer?.emitterPosition = CGPoint(x: SCREEN_WIDTH/2, y: 0)
        let rect = CGRect(x: 0, y: -30, width: SCREEN_WIDTH, height: 50.0)
        
        self.emitterLayer?.frame = rect
        self.emitterLayer?.emitterSize = rect.size
        
        let hailCell = CAEmitterCell()
        
        
        
        
        hailCell.birthRate = 15
        hailCell.lifetime = 3.5
        hailCell.color = UIColor(colorLiteralRed: 1, green: 1, blue: 1, alpha: 0.6).CGColor
        // 240 255 255  248 248 255
        hailCell.scale = 0.7
        hailCell.scaleSpeed = -0.2
        hailCell.scaleRange = 0.3
        
        hailCell.alphaRange = 0.5
        hailCell.alphaSpeed = -0.1
        
        hailCell.velocity = 20.0
        hailImage = UIImage(named: "bingbao")?.scaleImage(18)
        
        hailCell.contents = hailImage?.CGImage
        
        hailCell.yAcceleration = 500
        hailCell.xAcceleration = 10.0
        
        hailCell.emissionLongitude = CGFloat(-M_PI)
        
        self.emitterLayer?.emitterCells = [hailCell]
        
        
        self.layer.addSublayer(self.emitterLayer!)
        
        self.alpha = 0.0
    }
    
    func show()
    {
        self.createHailView()
        
        UIView.animateWithDuration(0.2, animations: {
            self.alpha = 0.8
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
