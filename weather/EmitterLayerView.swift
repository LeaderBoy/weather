//
//  EmitterLayerView.swift
//  weather
//
//  Created by 杨志远 on 16/6/2.
//  Copyright © 2016年 杨志远. All rights reserved.
//

import UIKit
enum EmitterType
{
    case _SNOW
    case _RAIN
    case _NONE
}

class EmitterLayerView: UIView {
    var emitterLayer : CAEmitterLayer?
    
    
    override init(frame: CGRect) {
         super.init(frame: frame)
        
        emitterLayer = CAEmitterLayer()
        
    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func show(withSound:Bool)
    {
        
    }
    
    func hide()
    {
        
    }
    
    func configurateViewType(type:EmitterType)
    {
    
    }

}
