//
//  UIAdapter.swift
//  Craft
//
//  Created by castiel on 15/11/7.
//  Copyright © 2015年 castiel. All rights reserved.
//

import Foundation
import UIKit

class UIAdapter{
    class var shared : UIAdapter{
        
        struct Inner{
            static var instance : UIAdapter? = nil
            static var token : dispatch_once_t = 0
        }
        
        dispatch_once(&Inner.token){
            Inner.instance = UIAdapter()
        }
        return Inner.instance!
    }
    
    var width : CGFloat = 0
    var height : CGFloat = 0
    var widthRatio : CGFloat = 0
    var heightRatio : CGFloat = 0
    
    var statusBarHeight : CGFloat = 20;
    var navBarHeight : CGFloat = 44;
    var tabBarHeight : CGFloat = 48;
    
    func config(window:CGRect){
        self.width = window.width
        self.height = window.height
        self.widthRatio = window.width / 320
        self.heightRatio =  window.height / 480
        if(self.width == 414){
            self.statusBarHeight  = 27;
            self.navBarHeight = 66;
            self.tabBarHeight = 73;
        }
    }
    
    func transferWidth(num:CGFloat) -> CGFloat{
        return num * self.widthRatio
    }
    
    func transferHeight(num:CGFloat) -> CGFloat{
        return num * heightRatio
    }
    
    
    func transferFont(num : CGFloat)->UIFont{
        return UIFont.systemFontOfSize(num * self.heightRatio)
    }
}

