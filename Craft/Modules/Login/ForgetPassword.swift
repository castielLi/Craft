//
//  ForgetPassword.swift
//  Craft
//
//  Created by castiel on 15/8/27.
//
//

import UIKit

class ForgetPassword: ViewControllerBase {
   
    
    var backGroundImage : UIImageView?
    
    var phoneNumber : UITextField?
    
    var password : UITextField?
    
    var verification : UITextField?
    
    var backgroundImage : UIImageView?
    
    var verificationButton : UIButton?
    
    var confirmButton : UIButton?
    var backButton : UIButton?
    

    var timer:NSTimer?
    var verifyRequestCount:Int?
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController!.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "找回密码"
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func initView(){
        setBackGroundImage()
        setEnterView()
        setConfirmButton()
    }
    
    override func registerEvents() {
        
        
        verificationButton!.addTarget(self, action: "VerifyCodeButtonClick:", forControlEvents: UIControlEvents.TouchUpInside)
        
        
    }
    
    override func onLoad() {
//        service = LoginService()
    }
    
    func setBackGroundImage(){
        self.backGroundImage = UIImageView(frame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.height))
        let path = NSBundle.mainBundle().pathForResource("LoginBackGround", ofType: "png")
        self.backGroundImage!.image = UIImage(contentsOfFile: path!)
        self.view.addSubview(self.backGroundImage!)
    }

    
    func setEnterView(){
        
        self.phoneNumber = UITextField()
        self.phoneNumber!.backgroundColor = UIColor.whiteColor()
        self.phoneNumber!.alpha = 0.3
        self.phoneNumber!.layer.cornerRadius = 5
        self.phoneNumber!.layer.masksToBounds = true
        self.phoneNumber!.layer.borderWidth = 1
        self.phoneNumber!.layer.borderColor = UIColor(red: 123/255, green: 95/255, blue: 75/255, alpha: 1).CGColor
        
        self.view!.addSubview(self.phoneNumber!)
        
        self.phoneNumber!.mas_makeConstraints{ make in
            make.top.equalTo()(self.view!.mas_top).with().offset()(UIAdapter.shared.transferHeight(170))
            make.bottom.equalTo()(self.view!.mas_top).with().offset()(UIAdapter.shared.transferHeight(200))
            make.left.equalTo()(self.view!.mas_left).with().offset()(UIAdapter.shared.transferWidth(60))
            make.right.equalTo()(self.view!.mas_right).with().offset()(UIAdapter.shared.transferWidth(-60))
        }
        
        
    
        self.verification = UITextField()
        self.verification!.backgroundColor = UIColor.whiteColor()
        self.verification!.alpha = 0.3
        self.verification!.layer.cornerRadius = 5
        self.verification!.layer.masksToBounds = true
        self.verification!.layer.borderWidth = 1
        self.verification!.layer.borderColor = UIColor(red: 123/255, green: 95/255, blue: 75/255, alpha: 1).CGColor
        
        self.view!.addSubview(self.verification!)
        
        self.verification!.mas_makeConstraints{ make in
            make.top.equalTo()(self.phoneNumber!.mas_bottom).with().offset()(UIAdapter.shared.transferHeight(10))
            make.bottom.equalTo()(self.phoneNumber!.mas_bottom).with().offset()(UIAdapter.shared.transferHeight(40))
            make.left.equalTo()(self.view!.mas_left).with().offset()(UIAdapter.shared.transferWidth(60))
            make.right.equalTo()(self.view!.mas_left).with().offset()(self.view.frame.width / 2 - UIAdapter.shared.transferWidth(5))
        }
        
        
        self.verificationButton = UIButton(frame: CGRectMake(0, 0, UIAdapter.shared.transferWidth(100), UIAdapter.shared.transferHeight(100)))
        self.verificationButton!.setBackgroundImage(UIImage(named: "valideButton"), forState: UIControlState.Normal)
        self.verificationButton!.setTitle("发送验证码", forState: UIControlState.Normal)
        self.verificationButton!.titleLabel!.font = UIAdapter.shared.transferFont(11)
        self.verificationButton!.setTitleColor(UIColor(red: 89/255, green: 89/255, blue: 89/255, alpha: 1), forState: UIControlState.Normal)
        self.verificationButton!.layer.masksToBounds = true
        self.verificationButton!.layer.cornerRadius = 5
        self.view!.addSubview(verificationButton!)
        
        self.verificationButton!.mas_makeConstraints{ make in
            make.top.equalTo()(self.verification!.mas_top)
            make.bottom.equalTo()(self.verification!.mas_bottom)
            make.left.equalTo()(self.view!.mas_left).with().offset()(UIAdapter.shared.transferWidth(5) + self.view.frame.width / 2)
            make.right.equalTo()(self.view!.mas_right).with().offset()(UIAdapter.shared.transferWidth(-60))
        }
        verificationButton!.addTarget(self, action: "VerifyCodeButtonClick:", forControlEvents: UIControlEvents.TouchUpInside)
        
        
        
        self.password = UITextField()
        self.password!.backgroundColor = UIColor.whiteColor()
        self.password!.alpha = 0.3
        self.password!.layer.cornerRadius = 5
        self.password!.layer.masksToBounds = true
        self.password!.layer.borderWidth = 1
        self.password!.layer.borderColor = UIColor(red: 123/255, green: 95/255, blue: 75/255, alpha: 1).CGColor
        
        self.view!.addSubview(self.password!)
        
        self.password!.mas_makeConstraints{ make in
            make.top.equalTo()(self.verificationButton!.mas_bottom).with().offset()(UIAdapter.shared.transferHeight(10))
            make.bottom.equalTo()(self.verificationButton!.mas_bottom).with().offset()(UIAdapter.shared.transferHeight(40))
            make.left.equalTo()(self.view!.mas_left).with().offset()(UIAdapter.shared.transferWidth(60))
            make.right.equalTo()(self.view!.mas_right).with().offset()(UIAdapter.shared.transferWidth(-60))
        }

        
    }
    
    func setConfirmButton(){
        self.confirmButton = UIButton()
        self.confirmButton!.backgroundColor = UIColor.clearColor()
        self.confirmButton!.titleLabel?.font = UIFont(name: "TimesNewRomanPS-BoldMT", size: UIAdapter.shared.transferHeight(12))
        self.confirmButton!.setTitle("确    认", forState: UIControlState.Normal)
        self.confirmButton!.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        self.confirmButton!.addTarget(self, action: "confirmButtonClick:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view!.addSubview(confirmButton!)
        
        self.confirmButton!.mas_makeConstraints{make in
            make.top.equalTo()(self.password!.mas_bottom).with().offset()(UIAdapter.shared.transferHeight(10))
            make.bottom.equalTo()(self.password!.mas_bottom).with().offset()(UIAdapter.shared.transferHeight(30))
            make.left.equalTo()(self.phoneNumber?.mas_left)
            make.right.equalTo()(self.phoneNumber?.mas_right)
        }
        
        self.backButton = UIButton()
        self.backButton!.backgroundColor = UIColor.clearColor()
        self.backButton!.titleLabel?.font = UIFont(name: "TimesNewRomanPS-BoldMT", size: UIAdapter.shared.transferHeight(12))
        self.backButton!.setTitle("返    回", forState: UIControlState.Normal)
        self.backButton!.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        self.backButton!.addTarget(self, action: "backButtonClick:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view!.addSubview(backButton!)
        
        self.backButton!.mas_makeConstraints{make in
            make.top.equalTo()(self.confirmButton!.mas_bottom).with().offset()(UIAdapter.shared.transferHeight(10))
            make.bottom.equalTo()(self.confirmButton!.mas_bottom).with().offset()(UIAdapter.shared.transferHeight(30))
            make.left.equalTo()(self.phoneNumber?.mas_left)
            make.right.equalTo()(self.phoneNumber?.mas_right)
        }
    }

    
    
    
    func confirmButtonClick (sender : UIButton){
        
        
    }
    
    
    func backButtonClick(sender : UIButton){
        self.navigationController!.popViewControllerAnimated(true)
    }
    
    func VerifyCodeButtonClick(sender:UIButton)
    {
//        if(phoneNumber!.text.isEmpty)
//        {
//            MsgBoxHelper.showOkMessage("请输入电话号码", title:String())
//            return
//        }
//        
//        showProgress()
//        service!.getVerifyCode(phoneNumber!.text, handler:{(result:ApiResult,data:AnyObject?) in
//            self.closeProgress()
//            if(!result.success!)
//            {
//                MsgBoxHelper.showOkMessage(result.message!, title:String())
//            }
//            else
//            {
//                MsgBoxHelper.showOkMessage(result.message!, title:String())
//                self.verificationButton!.enabled  = false
//                self.verifyRequestCount = 60
//                self.timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "updateTimer:", userInfo: nil, repeats: true)
//            }
//        })
        
       

    }
    
    func updateTimer(sender: NSTimer) {
        verificationButton!.setTitle(String(stringInterpolationSegment: verifyRequestCount!), forState: UIControlState.Disabled)
        if(verifyRequestCount < 1)
        {
            timer!.invalidate()
            timer = nil
            verificationButton!.enabled = true
            verificationButton?.setTitle("获取验证码", forState: UIControlState.Normal)
        }
        verifyRequestCount! -= 1
    }
    
    func Validate()->Bool{
        
//        if(phoneNumber!.text.isEmpty)
//        {
//            MsgBoxHelper.showOkMessage("请输入电话号码", title: "")
//            return false
//        }
//        
//        if(phoneNumber!.text.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 11)
//        {
//            MsgBoxHelper.showOkMessage("电话号码的长度不正确", title: "")
//            return false
//        }
//        
//        if !self.phoneNumber!.matchRegex("^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$") {
//            MsgBoxHelper.showOkMessage("电话号码格式有错误", title: "")
//            return false
//        }
//        
//        if(password!.text.isEmpty)
//        {
//            MsgBoxHelper.showOkMessage("请输入密码", title: "")
//            return false
//        }
//        
//        
//        if(password!.text.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 16 ||
//            password!.text.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) < 6)
//        {
//            MsgBoxHelper.showOkMessage("密码长度不正确", title: "")
//            return false
//        }
//        
//        
//        if(verification!.text.isEmpty)
//        {
//            MsgBoxHelper.showOkMessage("请输入验证码", title: "")
//            return false
//        }
//        
        
        return true
    }

}
