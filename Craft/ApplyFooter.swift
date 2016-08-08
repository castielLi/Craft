//
//  ApplyFooter.swift
//  Craft
//
//  Created by castiel on 16/8/7.
//  Copyright © 2016年 castiel. All rights reserved.
//

import UIKit

class ApplyFooter: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    var backgroundImage : UIImageView?
    var chat : UIButton?
    var info : UIButton?
    var apply : UIButton?
    var refuses : UIButton?
    
    var infoClick :((indexPath:Int)->Void)?
    var chatClick :((indexPath:Int)->Void)?
    var inviteClick :((indexPath:Int)->Void)?
    var refusesClick :((indexPath:Int)->Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundImage = UIImageView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        backgroundImage!.image = UIImage(named: "cellfooter")
        self.addSubview(backgroundImage!)
        
        chat = UIButton(frame:CGRect(x: 0, y: 5, width: self.frame.width / 4, height: 20))
        chat!.backgroundColor = UIColor.clearColor()
        chat!.setTitleColor(Resources.Color.dailyColor, forState: UIControlState.Normal)
        chat!.setTitle("信息", forState: UIControlState.Normal)
        chat!.titleLabel!.font = UIFont(name: "KaiTi", size: 12)
        chat!.addTarget(self, action: "ChatClick:", forControlEvents: UIControlEvents.TouchUpInside)
        chat!.titleLabel!.textAlignment = NSTextAlignment.Center
        self.addSubview(chat!)
        
        info = UIButton(frame:CGRect(x: self.frame.width / 4, y: 5, width: self.frame.width / 4, height: 20))
        info!.backgroundColor = UIColor.clearColor()
        info!.setTitleColor(Resources.Color.dailyColor, forState: UIControlState.Normal)
        info!.setTitle("私聊", forState: UIControlState.Normal)
        info!.titleLabel!.font = UIFont(name: "KaiTi", size: 12)
        info!.titleLabel!.textAlignment = NSTextAlignment.Center
        info!.addTarget(self, action: "InfoClick:", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(info!)
        
        apply = UIButton(frame:CGRect(x: self.frame.width / 4 * 2, y: 5, width: self.frame.width / 4, height: 20))
        apply!.backgroundColor = UIColor.clearColor()
        apply!.setTitleColor(UIColor(red: 29/255, green: 184/255, blue: 28/255, alpha: 1), forState: UIControlState.Normal)
        apply!.setTitle("接受", forState: UIControlState.Normal)
        apply!.titleLabel!.font = UIFont(name: "KaiTi", size: 12)
        apply!.titleLabel!.textAlignment = NSTextAlignment.Center
        apply!.addTarget(self, action: "InviteClick:", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(apply!)
        
        refuses = UIButton(frame:CGRect(x: self.frame.width / 4 * 3, y: 5, width: self.frame.width / 4, height: 20))
        refuses!.backgroundColor = UIColor.clearColor()
        refuses!.setTitleColor(UIColor(red: 230/255, green: 41/255, blue: 41/255, alpha: 1), forState: UIControlState.Normal)
        refuses!.setTitle("拒绝", forState: UIControlState.Normal)
        refuses!.titleLabel!.font = UIFont(name: "KaiTi", size: 12)
        refuses!.titleLabel!.textAlignment = NSTextAlignment.Center
        refuses!.addTarget(self, action: "RefusesClick:", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(refuses!)
    
    }
    
    func InfoClick(sender:UIButton){
        if self.infoClick != nil{
            self.infoClick!(indexPath: sender.tag)
        }
    }
    
    func ChatClick(sender:UIButton){
        if self.chatClick != nil{
            self.chatClick!(indexPath: sender.tag)
        }
    }
    
    func InviteClick(sender:UIButton){
        if self.inviteClick != nil{
            self.inviteClick!(indexPath: sender.tag)
        }
    }
    
    func RefusesClick(sender:UIButton){
        if self.refusesClick != nil{
            self.refusesClick!(indexPath: sender.tag)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
