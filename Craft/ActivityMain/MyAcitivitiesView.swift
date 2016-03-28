//
//  MyAcitivitiesView.swift
//  Craft
//
//  Created by castiel on 16/3/13.
//  Copyright © 2016年 castiel. All rights reserved.
//

import UIKit

class MyAcitivitiesView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.grayColor().CGColor
        self.backgroundColor = UIColor.clearColor()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
