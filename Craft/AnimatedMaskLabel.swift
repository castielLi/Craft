//
//  AnimatedMaskLabel.swift
//  Craft
//
//  Created by castiel on 16/5/15.
//  Copyright © 2016年 castiel. All rights reserved.
//

import UIKit
import QuartzCore

class AnimatedMaskLabel: UIView {
    
    var attributeType : String?
    
    init(frame: CGRect , type : String) {
        super.init(frame: frame)
        attributeType = type
        
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        
        // Configure the gradient here
        
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        let colors = [
            UIColor.lightGrayColor().CGColor,
            UIColor.whiteColor().CGColor,
            UIColor.lightGrayColor().CGColor
        ]
        gradientLayer.colors = colors
        
        let locations = [
            0.25,
            0.5,
            0.75
        ]
        gradientLayer.locations = locations
        
        return gradientLayer
    }()
    
    let textAttributesRaid : [String: AnyObject] = {
        let style = NSMutableParagraphStyle()
        style.alignment = NSTextAlignment.Left
        
        return [
            NSFontAttributeName:UIFont(name: "HelveticaNeue", size: 19)!,
            NSParagraphStyleAttributeName:style
        ]
    }()
    
    let textAttributesTime : [String: AnyObject] = {
        let style = NSMutableParagraphStyle()
        style.alignment = NSTextAlignment.Left
        
        return [
            NSFontAttributeName:UIFont(name: "DB LCD Temp", size: UIAdapter.shared.transferHeight(20))!,
            NSParagraphStyleAttributeName:style
        ]
    }()
    
    @IBInspectable var text: String! {
        didSet {
            setNeedsDisplay()
            
            UIGraphicsBeginImageContextWithOptions(frame.size, false, 0)
            if attributeType == "raid"{
            text.drawInRect(bounds, withAttributes: textAttributesRaid)
            }else{
              text.drawInRect(bounds, withAttributes: textAttributesTime)
            }
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            let maskLayer = CALayer()
            maskLayer.backgroundColor = UIColor.clearColor().CGColor
            maskLayer.frame = CGRectOffset(bounds, bounds.size.width, 0)
            maskLayer.contents = image.CGImage
            
            gradientLayer.mask = maskLayer
        }
    }
    
    override func layoutSubviews() {
        gradientLayer.frame = CGRect(
            x: -bounds.size.width,
            y: bounds.origin.y,
            width: 3 * bounds.size.width,
            height: bounds.size.height)
        
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        
        layer.addSublayer(gradientLayer)
    }
    
}
