//
//  activityDetail.swift
//  Craft
//
//  Created by castiel on 16/8/3.
//  Copyright © 2016年 castiel. All rights reserved.
//

import UIKit

class activityDetail: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    var backgroundView : UIImageView?
    var type : UILabel?
    var level : UILabel?
    var time : UILabel?
    var name : UILabel?
    var startLabel : UILabel?
    var endLabel : UILabel?
    var startTime : UILabel?
    var endTime : UILabel?
    var content : UITextView?
    var setting : UIButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        backgroundView!.image = UIImage(named: "allianceDetail")
        self.addSubview(backgroundView!)
        
        type = UILabel()
        type!.font = UIFont(name: "KaiTi", size: 15)
        self.addSubview(self.type!)
        type!.textColor = Resources.Color.dailyColor
        type!.text = "团队副本"
        self.type!.mas_makeConstraints{ make in
           make.top.equalTo()(self).with().offset()(UIAdapter.shared.transferHeight(5))
           make.left.equalTo()(self).with().offset()(UIAdapter.shared.transferWidth(8))
        }
        
        level = UILabel()
        level!.font = UIFont(name: "KaiTi", size: 15)
        self.addSubview(self.level!)
        level!.textColor = Resources.Color.dailyColor
        level!.text = "英雄"
        level!.textAlignment = NSTextAlignment.Center
        self.level!.mas_makeConstraints{ make in
            make.top.equalTo()(self).with().offset()(UIAdapter.shared.transferHeight(5))
            make.centerX.equalTo()(self)
        }
        
        time = UILabel()
        time!.font = UIFont(name: "KaiTi", size: 15)
        self.addSubview(self.time!)
        time!.textColor = Resources.Color.dailyColor
        time!.text = "2016/07/20"
        time!.textAlignment = NSTextAlignment.Right
        self.time!.mas_makeConstraints{ make in
            make.top.equalTo()(self).with().offset()(UIAdapter.shared.transferHeight(5))
            make.right.equalTo()(self).with().offset()(UIAdapter.shared.transferWidth(-8))
        }
        
        name = UILabel()
        name!.font = UIFont(name: "KaiTi", size: 20)
        self.addSubview(self.name!)
        name!.textColor = UIColor.whiteColor()
        name!.text = "纳克萨玛斯"
        name!.textAlignment = NSTextAlignment.Center
        self.name!.mas_makeConstraints{ make in
            make.top.equalTo()(self).with().offset()(UIAdapter.shared.transferHeight(25))
            make.centerX.equalTo()(self)
        }
        
        startLabel = UILabel()
        startLabel!.font = UIFont(name: "KaiTi", size: 14)
        self.addSubview(self.startLabel!)
        startLabel!.textColor = UIColor.whiteColor()
        startLabel!.text = "开始"
        startLabel!.textAlignment = NSTextAlignment.Center
        self.startLabel!.mas_makeConstraints{ make in
            make.top.equalTo()(self).with().offset()(UIAdapter.shared.transferHeight(45))
            make.centerX.equalTo()(self).with().offset()(-self.frame.width / 4)
        }
        
        endLabel = UILabel()
        endLabel!.font = UIFont(name: "KaiTi", size: 14)
        self.addSubview(self.endLabel!)
        endLabel!.textColor = UIColor.whiteColor()
        endLabel!.text = "结束"
        endLabel!.textAlignment = NSTextAlignment.Center
        self.endLabel!.mas_makeConstraints{ make in
            make.top.equalTo()(self).with().offset()(UIAdapter.shared.transferHeight(45))
            make.centerX.equalTo()(self).with().offset()(self.frame.width / 4)
        }
        
        startTime = UILabel()
        startTime!.font = UIFont(name: "Papyrus-Regular", size: 30)
        self.addSubview(self.startTime!)
        startTime!.textColor = UIColor.whiteColor()
        startTime!.text = "19:30"
        startTime!.textAlignment = NSTextAlignment.Center
        self.startTime!.mas_makeConstraints{ make in
            make.top.equalTo()(self).with().offset()(UIAdapter.shared.transferHeight(51))
            make.centerX.equalTo()(self).with().offset()(-self.frame.width / 4)
        }
        
        endTime = UILabel()
        endTime!.font = UIFont(name: "Papyrus-Regular", size: 30)
        self.addSubview(self.endTime!)
        endTime!.textColor = UIColor.whiteColor()
        endTime!.text = "22:30"
        endTime!.textAlignment = NSTextAlignment.Center
        self.endTime!.mas_makeConstraints{ make in
            make.top.equalTo()(self).with().offset()(UIAdapter.shared.transferHeight(51))
            make.centerX.equalTo()(self).with().offset()(self.frame.width / 4)
        }
        
        content = UITextView()
        content!.text = "7-12来熟练工，不墨迹！"
        content!.editable = false
        content!.textColor = UIColor.whiteColor()
        content!.font = UIFont(name: "KaiTi", size: 14)
        content!.backgroundColor = UIColor.clearColor()
        self.addSubview(content!)
        self.content!.mas_makeConstraints{ make in
            make.top.equalTo()(self).with().offset()(UIAdapter.shared.transferHeight(80))
            make.bottom.equalTo()(self).with().offset()(UIAdapter.shared.transferHeight(-10))
            make.left.equalTo()(self).with().offset()(UIAdapter.shared.transferWidth(8))
            make.right.equalTo()(self).with().offset()(UIAdapter.shared.transferWidth(-40))
        }
        
        
        setting = UIButton()
        setting!.setBackgroundImage( UIImage(named: "detailsetting"), forState: UIControlState.Normal)
        self.addSubview(setting!)
        self.setting!.mas_makeConstraints{ make in
            make.top.equalTo()(self.mas_bottom).with().offset()(UIAdapter.shared.transferHeight(-30))
            make.height.equalTo()(UIAdapter.shared.transferWidth(20))
            make.width.equalTo()(UIAdapter.shared.transferWidth(20))
            make.left.equalTo()(self.mas_right).with().offset()(UIAdapter.shared.transferWidth(-28))
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
