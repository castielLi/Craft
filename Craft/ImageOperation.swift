//
//  BlurryImage.swift
//  Craft
//
//  Created by castiel on 16/1/23.
//  Copyright © 2016年 castiel. All rights reserved.
//

import Foundation

struct ImageOperation {
    
    static func blurryImage(image : UIImage)->UIImage{
      
         let inputImage = CIImage(CGImage: image.CGImage!)
         let filter = CIFilter(name: "CIGaussianBlur")
         filter!.setValue(inputImage, forKey: kCIInputImageKey)
         filter!.setValue(0.5, forKey: kCIInputIntensityKey)
        
        
         let outImage = filter!.outputImage
         let context = CIContext(options: nil)
         let cgImage = context.createCGImage(outImage!, fromRect: outImage!.extent)
        
         return UIImage(CGImage: cgImage)
    }
    
    static func changeImageSize(size : CGSize , image : UIImage)->UIImage{
        UIGraphicsBeginImageContext(size)
        image.drawInRect(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        print(newImage.size)
        return newImage
    }
    
}