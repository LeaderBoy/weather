//
//  UIImage + extension.swift
//  Particle
//
//  Created by 杨志远 on 16/5/4.
//  Copyright © 2016年 杨志远. All rights reserved.
//

import UIKit

extension UIImage{
    func scaleImage(width: CGFloat) -> UIImage{
        if size.width < width {
            return self
        }
        
        let height = width * size.height / size.width
        let newsize = CGSizeMake(width, height)
        
        UIGraphicsBeginImageContext(newsize)
        UIGraphicsGetCurrentContext()
        //        drawInRect(CGRect(origin: CGPointZero,size: newsize))
        drawInRect(CGRectMake(0, 0, width, height))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}

