//
//  AcitvityMainView.swift
//  Craft
//
//  Created by castiel on 16/3/26.
//  Copyright © 2016年 castiel. All rights reserved.
//

import UIKit

class ActivityMainView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    var activityMainView : UIImageView?
    
    var testButton : UIButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.activityMainView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        self.activityMainView!.userInteractionEnabled = true
        self.activityMainView!.backgroundColor = UIColor(red: 30/255, green: 69/255, blue: 102/255, alpha: 1)
        self.activityMainView!.alpha = 0.7
        self.activityMainView!.layer.cornerRadius = 5
        self.activityMainView!.layer.borderWidth = 2
        self.activityMainView!.layer.borderColor = UIColor.grayColor().CGColor
        self.activityMainView!.layer.masksToBounds = true
        self.addSubview(self.activityMainView!)
        
        setTestButton()
    }
    
    func setTestButton(){
        testButton = UIButton()
        
        testButton!.backgroundColor = UIColor.blackColor()
        testButton!.setTitle("Test Button", forState: UIControlState.Normal)
        self.activityMainView!.addSubview(testButton!)
        
        self.testButton!.mas_makeConstraints{ make in
            make.top.equalTo()(self.activityMainView!.mas_top).with().offset()(100)
            make.centerX.equalTo()(self.activityMainView)
            make.height.equalTo()(40)
            make.width.equalTo()(100)
        }
    }

    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
