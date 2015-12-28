//
//  ForgetPassword.swift
//  Craft
//
//  Created by castiel on 15/8/27.
//
//

import UIKit
import XCGLogger

class ForgetPassword: ViewControllerBase {
   
    let logger = XCGLogger()
    
    var backGroundImage : UIImageView?
    
    var phoneNumber : UITextField?
    
    var password : UITextField?
    
    var verification : UITextField?
    
    var verificationButton : UIButton?
    var service : LoginService?
    var timer:NSTimer?
    var verifyRequestCount:Int?
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        logger.info("testing......")
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let registerButton = UIButton(frame: CGRectMake(0, 0, UIAdapter.shared.transferWidth(35), UIAdapter.shared.transferHeight(15)))
        registerButton.setTitle("完成", forState: UIControlState.Normal)
        registerButton.titleLabel?.font = UIAdapter.shared.transferFont(12)
        registerButton.addTarget(self, action: "registerButtonClick:", forControlEvents: UIControlEvents.TouchUpInside)
        let customButton = UIBarButtonItem(customView: registerButton)
        self.navigationItem.rightBarButtonItem = customButton
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
        setBackGround()
        setTitle()
        setEnterView()
        setValidButton()
        
    }
    
    override func registerEvents() {
        
        
        verificationButton!.addTarget(self, action: "VerifyCodeButtonClick:", forControlEvents: UIControlEvents.TouchUpInside)
        
        
    }
    
    override func onLoad() {
        service = LoginService()
    }
    
    
    func setTitle(){
        self.view.backgroundColor = UIColor.whiteColor()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar
    }
    
    func setBackGround(){
        backGroundImage = UIImageView(frame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.height))
        backGroundImage!.image = UIImage(named: "registerBackGround")
        self.view.addSubview(backGroundImage!)
    }
    
    
    
    func setEnterView(){
        
        phoneNumber = UITextField()
        phoneNumber!.placeholder = "请输入帐号"
        self.view!.addSubview(phoneNumber!)
        
        self.phoneNumber!.mas_makeConstraints{ make in
            make.right.equalTo()(self.view.mas_right).with().offset()(UIAdapter.shared.transferWidth( -120 ))
            make.left.equalTo()(self.view.mas_left).with().offset()(UIAdapter.shared.transferWidth( 20 ))
            make.top.equalTo()(self.view.mas_top).with().offset()(UIAdapter.shared.transferHeight( 80 ))
            make.bottom.equalTo()(self.view.mas_top).with().offset()(UIAdapter.shared.transferHeight(120))
        }
        
        
        self.verification = UITextField()
        self.verification!.placeholder = "请输入验证码"
        self.view!.addSubview(self.verification!)
        
        self.verification!.mas_makeConstraints{ make in
            make.height.equalTo()(self.phoneNumber!.mas_height)
            make.right.equalTo()(self.view.mas_right).with().offset()(UIAdapter.shared.transferWidth( -20 ))
            make.left.equalTo()(self.view.mas_left).with().offset()(UIAdapter.shared.transferWidth( 20 ))
            make.top.equalTo()(self.phoneNumber!.mas_bottom).with().offset()( UIAdapter.shared.transferHeight( 10 ) )
            make.height.equalTo()(self.phoneNumber)
        }
        
        self.password = UITextField()
        self.password!.placeholder = "请输入密码"
        self.view!.addSubview(self.password!)
        
        self.password!.mas_makeConstraints{ make in
            make.height.equalTo()(self.phoneNumber!.mas_height)
            make.left.equalTo()(self.verification!.mas_left)
            make.right.equalTo()(self.verification!.mas_right)
            make.top.equalTo()(self.verification!.mas_bottom).with().offset()( UIAdapter.shared.transferHeight(10) )
            make.height.equalTo()(self.phoneNumber)
        }
        
        
    }
    
    
    func setValidButton(){
        
        self.verificationButton = UIButton(frame: CGRectMake(0, 0, UIAdapter.shared.transferWidth(100), UIAdapter.shared.transferHeight(100)))
        self.verificationButton!.setTitle("获取验证码", forState: UIControlState.Normal)
        self.verificationButton!.titleLabel!.font = UIAdapter.shared.transferFont(14)
        self.verificationButton!.backgroundColor = UIColor.orangeColor()
        self.verificationButton!.layer.masksToBounds = true
        self.verificationButton!.layer.cornerRadius = 5
        self.view!.addSubview(verificationButton!)
        
        self.verificationButton!.mas_makeConstraints{ make in
            make.top.equalTo()(self.phoneNumber!.mas_top)
            make.bottom.equalTo()(self.phoneNumber!.mas_bottom)
            make.left.equalTo()(self.phoneNumber!.mas_right).with().offset()(UIAdapter.shared.transferWidth(2))
            make.right.equalTo()(self.view!.mas_right).with().offset()(UIAdapter.shared.transferWidth(-20))
        }
        verificationButton!.addTarget(self, action: "VerifyCodeButtonClick:", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    
    func registerButtonClick (sender : UIButton){
        
//        let validate:Bool = self.Validate()
//        if(!validate) {return}
//        
//        let phone = self.phoneNumber!.text
//        let pwd1 = self.password!.text
//        let verify = self.verification!.text
        
//        self.showProgress()
//        service!.getBackPassword(phone, pwd: pwd1, code: verify) { (result, data) -> Void in
//            self.closeProgress()
//            if(result.success!){
//            
//                self.navigationController?.popViewControllerAnimated(true)
//            }else{
//               MsgBoxHelper.showOkMessage(result.message!, title: "")
//            }
//        }
        
        
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
