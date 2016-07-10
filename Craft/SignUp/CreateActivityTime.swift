//
//  CreateActivityTime.swift
//  Craft
//
//  Created by castiel on 16/7/10.
//  Copyright © 2016年 castiel. All rights reserved.
//

import UIKit

class CreateActivityTime: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    var labelBackground : UIView?
    var startLabel : UILabel?
    var endLabel: UILabel?
    
    var startTime : CreateNewTimeView?
    var endTime : CreateNewTimeView?
    var backgroundImage : UIImageView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        labelBackground = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: UIAdapter.shared.transferHeight(15)))
        labelBackground?.backgroundColor = UIColor(red: 13/255, green: 10/255, blue: 9/255, alpha: 1)
        self.addSubview(labelBackground!)
        
        self.startLabel = UILabel()
        self.startLabel!.textColor = UIColor.whiteColor()
        self.startLabel!.font = UIAdapter.shared.transferFont(8)
        self.labelBackground!.addSubview(self.startLabel!)
        self.startLabel!.textAlignment = NSTextAlignment.Left
        self.startLabel!.text = "开始时间"
        
        self.startLabel!.mas_makeConstraints{ make in
           make.centerY.equalTo()(self.labelBackground!)
           make.left.equalTo()(self.labelBackground!).with().offset()(UIAdapter.shared.transferWidth(30))
        }
        
        
        self.endLabel = UILabel()
        self.endLabel!.textColor = UIColor.whiteColor()
        self.endLabel!.font = UIAdapter.shared.transferFont(8)
        self.labelBackground!.addSubview(self.endLabel!)
        self.endLabel!.textAlignment = NSTextAlignment.Right
        self.endLabel!.text = "结束时间"
        
        self.endLabel!.mas_makeConstraints{ make in
            make.centerY.equalTo()(self.labelBackground!)
            make.right.equalTo()(self.labelBackground!).with().offset()(UIAdapter.shared.transferWidth(-30))
        }
        
        
        self.startTime = CreateNewTimeView(frame: CGRect(x: 0, y: UIAdapter.shared.transferHeight(17), width: self.frame.width / 3, height: UIAdapter.shared.transferHeight(35)))
        self.startTime!.date!.text = "7月20日"
        self.startTime!.time?.text = "19:00"
        self.addSubview(startTime!)
        
        self.endTime = CreateNewTimeView(frame: CGRect(x: self.frame.width / 3 * 2, y: UIAdapter.shared.transferHeight(17), width: self.frame.width / 3, height: UIAdapter.shared.transferHeight(35)))
        self.endTime!.date!.text = "7月20日"
        self.endTime!.time?.text = "23:00"
        self.addSubview(endTime!)
        
        
        self.backgroundImage = UIImageView(frame: CGRect(x: self.frame.width / 3 + UIAdapter.shared.transferWidth(4), y: UIAdapter.shared.transferHeight(17 + 21), width: self.frame.width / 3 - UIAdapter.shared.transferWidth(8), height: UIAdapter.shared.transferHeight(5)))
        self.backgroundImage!.image = UIImage(named: "during")
        
        self.addSubview(backgroundImage!)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
