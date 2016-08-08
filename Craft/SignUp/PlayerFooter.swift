//
//  PlayerFooter.swift
//  Craft
//
//  Created by castiel on 16/8/6.
//  Copyright © 2016年 castiel. All rights reserved.
//

import UIKit

class PlayerFooter: UIView {

    var backgroundImage : UIImageView?
    var chat : UIButton?
    var info : UIButton?
    var add : UIButton?
    var assist : UIButton?
    var kick : UIButton?
    
    var infoClick :((indexPath:Int)->Void)?
    var chatClick :((indexPath:Int)->Void)?
    var addClick :((indexPath:Int)->Void)?
    var releaseClick :((indexPath:Int , setAssist: Bool)->Void)?
    var kickClick :((indexPath:Int)->Void)?
    
     override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundImage = UIImageView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        backgroundImage!.image = UIImage(named: "cellfooter")
        self.addSubview(backgroundImage!)
        
        chat = UIButton(frame:CGRect(x: 0, y: 5, width: self.frame.width / 5, height: 20))
        chat!.backgroundColor = UIColor.clearColor()
        chat!.setTitleColor(Resources.Color.dailyColor, forState: UIControlState.Normal)
        chat!.setTitle("信息", forState: UIControlState.Normal)
        chat!.addTarget(self, action: "ChatClick:", forControlEvents: UIControlEvents.TouchUpInside)
        chat!.titleLabel!.font = UIFont(name: "KaiTi", size: 12)
        chat!.titleLabel!.textAlignment = NSTextAlignment.Center
        self.addSubview(chat!)
        
        info = UIButton(frame:CGRect(x: self.frame.width / 5, y: 5, width: self.frame.width / 5, height: 20))
        info!.backgroundColor = UIColor.clearColor()
        info!.setTitleColor(Resources.Color.dailyColor, forState: UIControlState.Normal)
        info!.setTitle("私聊", forState: UIControlState.Normal)
        info!.titleLabel!.font = UIFont(name: "KaiTi", size: 12)
        info!.titleLabel!.textAlignment = NSTextAlignment.Center
        info!.addTarget(self, action: "InfoClick:", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(info!)
        
        add = UIButton(frame:CGRect(x: self.frame.width / 5 * 2, y: 5, width: self.frame.width / 5, height: 20))
        add!.backgroundColor = UIColor.clearColor()
        add!.setTitleColor(Resources.Color.dailyColor, forState: UIControlState.Normal)
        add!.setTitle("添加", forState: UIControlState.Normal)
        add!.titleLabel!.font = UIFont(name: "KaiTi", size: 12)
        add!.titleLabel!.textAlignment = NSTextAlignment.Center
        add!.addTarget(self, action: "AddClick:", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(add!)
        
        assist = UIButton(frame:CGRect(x: self.frame.width / 5 * 3, y: 5, width: self.frame.width / 5, height: 20))
        assist!.backgroundColor = UIColor.clearColor()
        assist!.setTitleColor(Resources.Color.dailyColor, forState: UIControlState.Normal)
        assist!.setTitle("解除协助", forState: UIControlState.Normal)
        assist!.titleLabel!.font = UIFont(name: "KaiTi", size: 12)
        assist!.titleLabel!.textAlignment = NSTextAlignment.Center
        assist!.addTarget(self, action: "ResponseClick:", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(assist!)
        
        kick = UIButton(frame:CGRect(x: self.frame.width / 5 * 4, y: 5, width: self.frame.width / 5, height: 20))
        
        kick!.backgroundColor = UIColor.clearColor()
        kick!.setTitleColor( UIColor(red: 230/255, green: 41/255, blue: 41/255, alpha: 1)  , forState: UIControlState.Normal)
        kick!.setTitle("踢出", forState: UIControlState.Normal)
        kick!.titleLabel!.font = UIFont(name: "KaiTi", size: 12)
        kick!.addTarget(self, action: "KickClick:", forControlEvents: UIControlEvents.TouchUpInside)
        kick!.titleLabel!.textAlignment = NSTextAlignment.Center
        self.addSubview(kick!)
    }
    
    func InfoClick(sender:UIButton){
        if self.infoClick != nil{
           self.infoClick!(indexPath: sender.tag)
        }
    }
    
    func AddClick(sender:UIButton){
        if self.addClick != nil{
            self.addClick!(indexPath: sender.tag)
        }
    }
    
    func ChatClick(sender:UIButton){
        if self.chatClick != nil{
            self.chatClick!(indexPath: sender.tag)
        }
    }
    
    func ResponseClick(sender:UIButton){
        if self.releaseClick != nil{
            if self.assist!.titleLabel!.text == "解除协助"{
               self.assist!.setTitle("团队助手", forState: UIControlState.Normal)
               self.releaseClick!(indexPath: sender.tag , setAssist: true)
            }else{
               self.assist!.setTitle("解除协助", forState: UIControlState.Normal)
               self.releaseClick!(indexPath: sender.tag , setAssist: false)
            }
            
        }
    }
    
    func KickClick(sender:UIButton){
        if self.kickClick != nil{
            self.kickClick!(indexPath: sender.tag)
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
