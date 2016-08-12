//
//  RegisterForLogin.swift
//  Craft
//
//  Created by castiel on 16/8/11.
//  Copyright © 2016年 castiel. All rights reserved.
//

import Foundation

extension LoginController{
    
    func setRegisterEnterView(){
        
        self.battleAccount = UITextField()
        self.battleAccount!.backgroundColor = UIColor.blackColor()
        self.battleAccount!.textColor = UIColor.whiteColor()
        self.battleAccount!.layer.cornerRadius = 5
        self.battleAccount!.font = UIFont(name: "KaiTi", size: UIAdapter.shared.transferHeight(15))
        self.battleAccount!.layer.masksToBounds = true
        self.battleAccount!.layer.borderWidth = 1
        self.battleAccount!.layer.borderColor = UIColor(red: 123/255, green: 95/255, blue: 75/255, alpha: 1).CGColor
        
        self.view!.addSubview(self.battleAccount!)
        
        self.battleAccount!.mas_makeConstraints{ make in
            make.top.equalTo()(self.view!.mas_top).with().offset()(UIAdapter.shared.transferHeight(150))
            make.bottom.equalTo()(self.view!.mas_top).with().offset()(UIAdapter.shared.transferHeight(180))
            make.left.equalTo()(self.view!.mas_left).with().offset()(UIAdapter.shared.transferWidth(50))
            make.right.equalTo()(self.view!.mas_right).with().offset()(UIAdapter.shared.transferWidth(-50))
        }

        
        self.nick = UITextField()
        self.nick!.backgroundColor = UIColor.blackColor()
        self.nick!.textColor = UIColor.whiteColor()
        self.nick!.layer.cornerRadius = 5
        self.nick!.font = UIFont(name: "KaiTi", size: UIAdapter.shared.transferHeight(15))
        self.nick!.layer.masksToBounds = true
        self.nick!.layer.borderWidth = 1
        self.nick!.layer.borderColor = UIColor(red: 123/255, green: 95/255, blue: 75/255, alpha: 1).CGColor
        
        self.view!.addSubview(self.nick!)
        
        self.nick!.mas_makeConstraints{ make in
            make.top.equalTo()(self.battleAccount!.mas_bottom).with().offset()(UIAdapter.shared.transferHeight(20))
            make.bottom.equalTo()(self.battleAccount!.mas_bottom).with().offset()(UIAdapter.shared.transferHeight(50))
            make.left.equalTo()(self.view!.mas_left).with().offset()(UIAdapter.shared.transferWidth(50))
            make.right.equalTo()(self.view!.mas_right).with().offset()(UIAdapter.shared.transferWidth(-50))
        }
        
        self.password = UITextField()
        self.password!.backgroundColor = UIColor.blackColor()
        self.password!.textColor = UIColor.whiteColor()
        self.password!.layer.cornerRadius = 5
        self.password!.layer.masksToBounds = true
        self.password!.secureTextEntry = true
        self.password!.layer.borderWidth = 1
        self.password!.layer.borderColor = UIColor(red: 123/255, green: 95/255, blue: 75/255, alpha: 1).CGColor
        
        self.view!.addSubview(self.password!)
        
        self.password!.mas_makeConstraints{ make in
            make.top.equalTo()(self.nick!.mas_bottom).with().offset()(UIAdapter.shared.transferHeight(20))
            make.bottom.equalTo()(self.nick!.mas_bottom).with().offset()(UIAdapter.shared.transferHeight(50))
            make.left.equalTo()(self.view!.mas_left).with().offset()(UIAdapter.shared.transferWidth(50))
            make.right.equalTo()(self.view!.mas_right).with().offset()(UIAdapter.shared.transferWidth(-50))
        }
        
        self.passwordConfirm = UITextField()
        self.passwordConfirm!.backgroundColor = UIColor.blackColor()
        self.passwordConfirm!.textColor = UIColor.whiteColor()
        self.passwordConfirm!.layer.cornerRadius = 5
        self.passwordConfirm!.layer.masksToBounds = true
        self.passwordConfirm!.secureTextEntry = true
        self.passwordConfirm!.layer.borderWidth = 1
        self.passwordConfirm!.layer.borderColor = UIColor(red: 123/255, green: 95/255, blue: 75/255, alpha: 1).CGColor
        
        self.view!.addSubview(self.passwordConfirm!)
        
        self.passwordConfirm!.mas_makeConstraints{ make in
            make.top.equalTo()(self.password!.mas_bottom).with().offset()(UIAdapter.shared.transferHeight(20))
            make.bottom.equalTo()(self.password!.mas_bottom).with().offset()(UIAdapter.shared.transferHeight(50))
            make.left.equalTo()(self.view!.mas_left).with().offset()(UIAdapter.shared.transferWidth(50))
            make.right.equalTo()(self.view!.mas_right).with().offset()(UIAdapter.shared.transferWidth(-50))
        }
        
        
        self.telphone = UITextField()
        self.telphone!.backgroundColor = UIColor.blackColor()
        self.telphone!.textColor = UIColor.whiteColor()
        self.telphone!.layer.cornerRadius = 5
        self.telphone!.font = UIFont(name: "KaiTi", size: UIAdapter.shared.transferHeight(15))
        self.telphone!.layer.masksToBounds = true
        self.telphone!.layer.borderWidth = 1
        self.telphone!.layer.borderColor = UIColor(red: 123/255, green: 95/255, blue: 75/255, alpha: 1).CGColor
        
        self.view!.addSubview(self.telphone!)
        
        self.telphone!.mas_makeConstraints{ make in
            make.top.equalTo()(self.passwordConfirm!.mas_bottom).with().offset()(UIAdapter.shared.transferHeight(20))
            make.bottom.equalTo()(self.passwordConfirm!.mas_bottom).with().offset()(UIAdapter.shared.transferHeight(50))
            make.left.equalTo()(self.view!.mas_left).with().offset()(UIAdapter.shared.transferWidth(50))
            make.right.equalTo()(self.view!.mas_right).with().offset()(UIAdapter.shared.transferWidth(-50))
        }
        
    }
    
    func setRegisterButton(){
        self.registerButton = UIButton()
        self.registerButton!.layer.cornerRadius = 5
        self.registerButton!.layer.masksToBounds = true
        self.registerButton!.setBackgroundImage(UIImage(named: "loginbutton"), forState: UIControlState.Normal)
        self.registerButton!.addTarget(self, action: "registerbuttonClick:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view!.addSubview(registerButton!)
        
        self.registerButton!.mas_makeConstraints{make in
            make.top.equalTo()(self.telphone!.mas_bottom).with().offset()(UIAdapter.shared.transferHeight(20))
            make.bottom.equalTo()(self.telphone!.mas_bottom).with().offset()(UIAdapter.shared.transferHeight(45))
            make.left.equalTo()(self.telphone?.mas_left)
            make.right.equalTo()(self.telphone?.mas_right)
        }
        
        
        self.cancelButton = UIButton()
        self.cancelButton!.layer.cornerRadius = UIAdapter.shared.transferWidth(13)
        self.cancelButton!.layer.masksToBounds = true
        self.cancelButton!.setBackgroundImage(UIImage(named: "loginbutton"), forState: UIControlState.Normal)
        self.cancelButton!.addTarget(self, action: "cancelButton:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view!.addSubview(cancelButton!)
        
        self.cancelButton!.mas_makeConstraints{make in
            make.top.equalTo()(self.registerButton!.mas_bottom).with().offset()(UIAdapter.shared.transferHeight(10))
            make.bottom.equalTo()(self.registerButton!.mas_bottom).with().offset()(UIAdapter.shared.transferWidth(26) + UIAdapter.shared.transferHeight(10))
            make.width.equalTo()(UIAdapter.shared.transferWidth(26))
            make.centerX.equalTo()(self.registerButton!)
        }

        
    }
    
    func cancelButton(sender : UIButton){
       
    }
    
    func registerbuttonClick(sender : UIButton){
        let success = self.ValidateRegister()
        if(success){
        self.showProgress()
        self.service!.Register(battleAccount!.text, nick: "洪都拉斯的春天", password: "123321", telphone: "15023201329")
        }
    }
    
    func registerDidFinish(result: ApiResult!, response: AnyObject!) {
        if(result.state){
           MsgBoxHelper.show("", message: "注册成功")
        }else{
           MsgBoxHelper.show("", message: "注册失败")
        }
    }

    func ValidateRegister()->Bool{
        
        if(battleAccount!.text!.isEmpty)
        {
            MsgBoxHelper.show("", message: "请输入帐号信息")
            return false
        }
        
        if(nick!.text!.isEmpty)
        {
            MsgBoxHelper.show("", message: "请输入昵称")
            return false
        }
        
        //        if !self.phoneNumber!.matchRegex("^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$") {
        //            MsgBoxHelper.showOkMessage("电话号码格式有错误", title: "")
        //            return false
        //        }
        
        if(password!.text!.isEmpty)
        {
            MsgBoxHelper.show("", message: "请输入密码")
            return false
        }
        
        if(password!.text!.characters.count > 16 ||
            password!.text!.characters.count < 6)
        {
            MsgBoxHelper.show("", message: "密码长度不正确")
            return false
        }
        
        if(battleAccount!.text!.isEmpty)
        {
            MsgBoxHelper.show("", message: "请输入战网帐号")
            return false
        }
        
        if(passwordConfirm!.text! != password!.text!){
            MsgBoxHelper.show("", message: "两次输入密码不一致")
            return false
        }
        
        return true
    }



}