//
//  AddNewFriend.swift
//  Craft
//
//  Created by castiel on 16/8/27.
//  Copyright © 2016年 castiel. All rights reserved.
//

import UIKit

class AddNewFriend: ViewControllerBase , ChatServiceDelegate{
    
    var service : ChatService?
    var backgroundImage : UIImageView?
    
    //search friend
    var battleAccountIcon : UIImageView?
    var accountLabel : UILabel?
    var searchText : UITextField?
    var account : String?
    var targetId : String?
    
    
    //user info
    var userIcon : UIImageView?
    var userName : UILabel?
    var battleAccountLabel : UILabel?
    var honorIcon : UIImageView?
    var honorNumber : UILabel?
    var content : UITextView?
    
    
    var confirmButton : UIButton?
    var cancenButton : UIButton?
    
    var searchStatus : Bool = true
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.service = ChatService()
        self.service!.delegate = self
        self.view.backgroundColor = UIColor.clearColor()
        // Do any additional setup after loading the view.
    }
    
    override func initView() {
        backgroundImage = UIImageView(frame: CGRect(x: (self.view.frame.width - UIAdapter.shared.transferWidth(220)) / 2, y: (self.view.frame.height - UIAdapter.shared.transferWidth(250)) / 2, width: UIAdapter.shared.transferWidth(220), height: UIAdapter.shared.transferWidth(250)))
        self.view.addSubview(backgroundImage!)
        backgroundImage!.layer.cornerRadius = 5
        backgroundImage!.layer.masksToBounds = true
        
        let path = NSBundle.mainBundle().pathForResource("addFriendOrAddToGroup", ofType: "png")
        backgroundImage!.image = UIImage(contentsOfFile: path!)
        
        
        confirmButton = UIButton()
        confirmButton?.setBackgroundImage(UIImage(named: "confirm"), forState: UIControlState.Normal)
        confirmButton!.addTarget(self, action: "confirmClick:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view!.addSubview(confirmButton!)
        
        self.confirmButton!.mas_makeConstraints{ make in
           make.top.equalTo()(self.backgroundImage!).with().offset()(UIAdapter.shared.transferWidth(210))
           make.left.equalTo()(self.backgroundImage!).with().offset()(20)
           make.height.equalTo()(UIAdapter.shared.transferWidth(23))
           make.width.equalTo()((UIAdapter.shared.transferWidth(220) - 60) / 2)
        }
        
        cancenButton = UIButton()
        cancenButton!.setBackgroundImage(UIImage(named: "cancel"), forState: UIControlState.Normal)
        cancenButton!.addTarget(self, action: "cancelClick:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view!.addSubview(cancenButton!)
        
        self.cancenButton!.mas_makeConstraints{ make in
            make.top.equalTo()(self.backgroundImage!).with().offset()(UIAdapter.shared.transferWidth(210))
            make.right.equalTo()(self.backgroundImage!).with().offset()(-20)
            make.height.equalTo()(UIAdapter.shared.transferWidth(23))
            make.width.equalTo()((UIAdapter.shared.transferWidth(220) - 60) / 2)
        }
        
        battleAccountIcon = UIImageView()
        battleAccountIcon!.image = UIImage(named: "battleAccount")
        self.view.addSubview(battleAccountIcon!)
        battleAccountIcon?.mas_makeConstraints{ make in
           make.centerX.equalTo()(self.backgroundImage!)
           make.width.equalTo()(UIAdapter.shared.transferWidth(20))
           make.height.equalTo()(UIAdapter.shared.transferWidth(20))
           make.top.equalTo()(self.backgroundImage!).with().offset()(UIAdapter.shared.transferWidth(60))
        }
        
        searchText = UITextField()
        searchText?.backgroundColor = UIColor.blackColor()
        searchText!.layer.cornerRadius = 5
        searchText!.layer.masksToBounds = true
        searchText!.textColor = Resources.Color.accountColor
        searchText!.font = UIFont.systemFontOfSize(16)
        self.view.addSubview(searchText!)
        
        self.searchText!.mas_makeConstraints{ make in
           make.top.equalTo()(self.battleAccountIcon!.mas_bottom).with().offset()(UIAdapter.shared.transferWidth(5))
           make.left.equalTo()(self.backgroundImage!).with().offset()(UIAdapter.shared.transferWidth(20))
           make.right.equalTo()(self.backgroundImage!).with().offset()(UIAdapter.shared.transferWidth(-20))
           make.height.equalTo()(UIAdapter.shared.transferWidth(20))
        }
        
        
        //

        userIcon = UIImageView()
        userIcon!.image = UIImage(named: "playericon")
        self.view.addSubview(userIcon!)
        self.userIcon!.alpha = 0
        self.userIcon!.hidden = true
        
        self.userIcon!.mas_makeConstraints{ make in
           make.top.equalTo()(self.backgroundImage!).with().offset()(UIAdapter.shared.transferWidth(20))
            make.centerX.equalTo()(self.backgroundImage!)
            make.width.equalTo()(UIAdapter.shared.transferWidth(50))
            make.height.equalTo()(UIAdapter.shared.transferWidth(50))
        }
        
        self.userIcon!.layer.cornerRadius = UIAdapter.shared.transferWidth(25)
        self.userIcon!.layer.masksToBounds = true
        
        let iconRange = CALayer()
        iconRange.frame = CGRectMake(0, 0, UIAdapter.shared.transferWidth(50), UIAdapter.shared.transferWidth(50))
        iconRange.contents = UIImage(named: "iconWidth")!.CGImage
        self.userIcon!.layer.addSublayer(iconRange)
        
        
        self.userName = UILabel()
        self.userName!.font = UIFont(name: "KaiTi", size: 16)
        self.view.addSubview(userName!)
        self.userName!.text = "伊莎贝拉殿下"
        self.userName!.textColor = Resources.Color.dailyColor
        self.userName!.mas_makeConstraints{ make in
            make.top.equalTo()(self.userIcon!.mas_bottom).with().offset()(UIAdapter.shared.transferWidth(5))
            make.centerX.equalTo()(self.backgroundImage!)
            make.height.equalTo()(UIAdapter.shared.transferWidth(17))
        }
        self.userName!.alpha = 0
        self.userName!.hidden = true
        
        
        self.battleAccountLabel = UILabel()
        self.battleAccountLabel!.font = UIFont(name: "KaiTi", size: 12)
        self.view.addSubview(battleAccountLabel!)
//        self.battleAccountLabel!.text = "853757935@qq.com"
        self.battleAccountLabel!.textColor = Resources.Color.accountColor
        self.battleAccountLabel!.mas_makeConstraints{ make in
            make.top.equalTo()(self.userName!.mas_bottom).with().offset()(UIAdapter.shared.transferWidth(5))
            make.centerX.equalTo()(self.backgroundImage!)
            make.height.equalTo()(UIAdapter.shared.transferWidth(13))
        }
        
        self.battleAccountLabel!.alpha = 0
        self.battleAccountLabel!.hidden = true
        
        
        honorIcon = UIImageView()
        honorIcon!.image = UIImage(named: "honour")
        self.view.addSubview(honorIcon!)
        self.honorIcon!.mas_makeConstraints{ make in
            make.top.equalTo()(self.battleAccountLabel!.mas_bottom).with().offset()(UIAdapter.shared.transferWidth(5))
            make.left.equalTo()(self.userIcon!)
            make.height.equalTo()(UIAdapter.shared.transferWidth(20))
            make.width.equalTo()(UIAdapter.shared.transferWidth(20))
        }
        
        self.honorIcon!.alpha = 0
        self.honorIcon!.hidden = true
        
        honorNumber = UILabel()
        honorNumber!.text = "10"
        honorNumber!.textColor = Resources.Color.dailyColor
        honorNumber!.font = UIFont(name: "DB LCD Temp", size: 12)
        self.view.addSubview(honorNumber!)
        
        self.honorNumber!.mas_makeConstraints{ make in
            make.top.equalTo()(self.battleAccountLabel!.mas_bottom).with().offset()(UIAdapter.shared.transferWidth(5))
            make.left.equalTo()(self.honorIcon!.mas_right).with().offset()(UIAdapter.shared.transferWidth(5))
            make.right.equalTo()(self.userIcon!)
            make.centerY.equalTo()(self.honorIcon!)
        }
        self.honorNumber!.alpha = 0
        self.honorNumber!.hidden = true
        
        self.content = UITextView()
        self.content!.backgroundColor = UIColor.blackColor()
        self.content!.textColor = UIColor.whiteColor()
        self.content!.font = UIFont(name: "KaiTi", size: 13)
        self.content!.layer.cornerRadius = 4
        self.content!.layer.masksToBounds = true
        self.content!.placeholderText = "备注信息:"
        self.view.addSubview(self.content!)
        
        self.content!.mas_makeConstraints{ make in
           make.top.equalTo()(self.honorIcon!.mas_bottom).with().offset()(UIAdapter.shared
            .transferWidth(10))
           make.left.equalTo()(self.confirmButton!)
           make.right.equalTo()(self.cancenButton!)
           make.bottom.equalTo()(self.confirmButton!.mas_top).with().offset()(UIAdapter.shared.transferWidth(-10))
        }
        self.content!.alpha = 0
        self.content!.hidden = true

    }
    
    
    func confirmClick(sender : UIButton){
       print("click")
        if(self.searchStatus){
           self.showProgress()
           self.service!.SearchAccount(self.searchText!.text)
           self.account = self.searchText!.text
        }else{
           self.SendFriendApply(self.targetId!,content: self.content!.text)
        }
    }
    
    func cancelClick(sender : UIButton){
        print("cancel")
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func DidSearchFriendFinish(result: ApiResult!, response: AnyObject!) {
        self.closeProgress()
        if(result.state){
           self.searchStatus = !self.searchStatus
            if(result.data == nil){
                
                MsgBoxHelper.show("", message: "没有查询到相关用户")
                return
                
            }
           let model = result.data as! UserInfoModel
           self.userName!.text = model.friend_name!
           self.battleAccountLabel!.text = self.account!
           self.targetId = model.user_id!
           self.exchangeStatus()
        }else{
           MsgBoxHelper.show("错误", message: result.message)
        }
    }
    
    private func exchangeStatus(){
        
        if(!self.searchStatus){

            self.userIcon!.hidden = false
            self.userName!.hidden = false
            self.honorIcon!.hidden = false
            self.honorNumber!.hidden = false
            self.battleAccountLabel!.hidden = false
            self.content!.hidden = false
            
            UIView.animateWithDuration(0.8, animations: {
                self.searchText!.alpha = 0
                self.battleAccountIcon!.alpha = 0
                
                self.userIcon!.alpha = 1
                self.userName!.alpha = 1
                self.honorIcon!.alpha = 1
                self.honorNumber!.alpha = 1
                self.battleAccountLabel!.alpha = 1
                self.content!.alpha = 1
                
                }, completion: { (success) in
                    self.searchText!.hidden = true
                    self.battleAccountIcon!.hidden = true
            })
        }else{
            self.searchText!.hidden = false
            self.battleAccountIcon!.hidden = false
            
            UIView.animateWithDuration(0.8, animations: {
                self.searchText!.alpha = 1
                self.battleAccountIcon!.alpha = 1
                
                self.userIcon!.alpha = 0
                self.userName!.alpha = 0
                self.honorIcon!.alpha = 0
                self.honorNumber!.alpha = 0
                self.battleAccountLabel!.alpha = 0
                self.content!.alpha = 0
                
                
                }, completion: { (success) in
                    self.userIcon!.hidden = true
                    self.userName!.hidden = true
                    self.honorIcon!.hidden = true
                    self.honorNumber!.hidden = true
                    self.battleAccountLabel!.hidden = true
                    self.content!.hidden = true
            })
        }
        
    }
    
    
    func SendFriendApply(targetId : String, content : String){
        
            let addModel = ChatMessageModel()
            addModel.type = "friend"
            addModel.userId = DBBaseInfoHelper.GetCurrentUserInfo()![0] as! String
            addModel.content = DBBaseInfoHelper.GetCurrentUserInfo()![1] as! String
            
            let message = RCInformationNotificationMessage()
            if(self.content!.text != ""){
                message.message = self.content!.text
            }else{
                message.message = "申请加你为好友"
            }
        
            let json = addModel.currentModelToJsonString()
            message.extra = json
            RCIMClient.sharedRCIMClient().sendMessage(RCConversationType.ConversationType_PRIVATE, targetId: targetId, content: message, pushContent: nil, success: { (messageId) in
                print("发送成功")

                MsgBoxHelper.show("", message: "好友邀请已发送,正等待对方确认!")
                
                
                }, error: { (error, messageId) in
                    print("发送失败")
                    
            })

        
    }

    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
