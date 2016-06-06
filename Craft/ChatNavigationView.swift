//
//  ChatNavigationView.swift
//  Craft
//
//  Created by castiel on 16/6/4.
//  Copyright © 2016年 castiel. All rights reserved.
//

import UIKit

class ChatNavigationView: UIView {

    var count : UILabel?
    var chat : UIButton?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        chat = UIButton(frame: CGRect(x: 0, y: 10, width: UIAdapter.shared.transferWidth(30), height: UIAdapter.shared.transferHeight(12)) )
        chat!.setBackgroundImage(UIImage(named: "friend"), forState: UIControlState.Normal)
        self.addSubview(self.chat!)
        
        self.count = UILabel(frame:CGRect(x: UIAdapter.shared.transferWidth(30) - 15 , y: 0, width: 20, height: 20))
        self.count?.backgroundColor = UIColor.redColor()
        self.count!.layer.cornerRadius = 10
        self.count!.textColor = UIColor.whiteColor()
        self.count!.layer.masksToBounds = true
        self.count!.textAlignment = NSTextAlignment.Center
        self.addSubview(self.count!)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
