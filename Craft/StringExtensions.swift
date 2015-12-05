//
//  StringExtensions.swift
//  Craft
//
//  Created by castiel on 15/12/5.
//  Copyright © 2015年 castiel. All rights reserved.
//

import Foundation
extension String {
    
    
    var md5: String! {
        let str = self.cStringUsingEncoding(NSUTF8StringEncoding)
        let strLen = CC_LONG(self.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.alloc(digestLen)
        
        CC_MD5(str!, strLen, result)
        
        let hash = NSMutableString()
        for i in 0..<digestLen {
            hash.appendFormat("%02x", result[i])
        }
        
        result.destroy()
        
        return String(format: hash as String)
    }
    
    var charToUInt8:UInt8
        {
            
            let str = self.cStringUsingEncoding(NSUTF8StringEncoding);
            if( str!.count != 1)
            {
                
            }
            
            
            
            return UInt8(str![0]);
    }
    
}

//extension NSString {
//    func textSizeWithFont(font: UIFont, constrainedToSize size:CGSize) -> CGSize {
//        var textSize:CGSize!
//        if CGSizeEqualToSize(size, CGSizeZero) {
//            let attributes = NSDictionary(object: font, forKey: NSFontAttributeName)
//            textSize = self.sizeWithAttributes(attributes as [NSObject : AnyObject] as [NSObject : AnyObject])
//        } else {
//            let option = NSStringDrawingOptions.UsesLineFragmentOrigin | NSStringDrawingOptions.UsesFontLeading
//            let attributes = NSDictionary(object: font, forKey: NSFontAttributeName)
//            let stringRect = self.boundingRectWithSize(size, options: option, attributes: attributes as [NSObject : AnyObject], context: nil)
//            textSize = stringRect.size
//        }
//        return textSize
//    }
//    
//    
//    func hexToByte()->[UInt8]
//    {
//        return []
//    }
//}