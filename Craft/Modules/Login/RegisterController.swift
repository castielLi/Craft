//
//  RegisterController.swift
//  Craft
//
//  Created by castiel on 15/6/17.
//  
//

import UIKit
import XCGLogger

class RegisterController: ViewControllerBase {
    
    let logger = XCGLogger()
    
    var backGroundImage : UIImageView?
    
    var phoneNumber : UITextField?
    
    var password : UITextField?
    
    var verification : UITextField?
    
    var verificationButton : UIButton?
    
    var checkBoxView : UIView?

    var service : LoginService?
    var checkBoxButton : UIButton?
    var checkBoxContent : UILabel?
    var linkCowPlanRules : UIButton?
    var timer:NSTimer?
    var verifyRequestCount:Int?
    var isSelected : Bool?

    
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
        self.title = "注册"
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
//        setCheckBoxPart()
        
    }
    
    override func registerEvents() {
        verificationButton!.addTarget(self, action: "VerifyCodeButtonClick:", forControlEvents: UIControlEvents.TouchUpInside)

        let tap = UITapGestureRecognizer(target: self, action: Selector("checkLabelTap"))
        tap.numberOfTapsRequired = 1
//        self.checkBoxView!.addGestureRecognizer(tap)
        

    }
    
    override func onLoad() {
        service = LoginService()
        self.isSelected = true
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
        self.verification!.keyboardType = UIKeyboardType.NumberPad
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
        self.password!.secureTextEntry = true
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
    
    
    func setCheckBoxPart(){
        
        self.checkBoxView = UIView(frame: CGRectMake(0, 0, UIAdapter.shared.transferWidth(200), UIAdapter.shared.transferHeight(10)))
        self.view.addSubview(self.checkBoxView!)
        self.checkBoxView!.backgroundColor = UIColor.clearColor()
        self.checkBoxView!.mas_makeConstraints{ make in
            make.top.equalTo()(self.password!.mas_bottom).with().offset()(UIAdapter.shared.transferHeight(5))
            make.bottom.equalTo()(self.password!.mas_bottom).with().offset()(UIAdapter.shared.transferHeight(15))
            make.left.equalTo()(self.password!.mas_left)
            make.right.equalTo()(self.view)
        }

        
        checkBoxButton = UIButton(frame: CGRectMake(0, 0, UIAdapter.shared.transferWidth(10), UIAdapter.shared.transferHeight(10)))
        checkBoxButton!.layer.masksToBounds = true
        checkBoxButton!.layer.cornerRadius = 2
        checkBoxButton!.backgroundColor = UIColor.whiteColor()
        checkBoxButton!.hidden = true
        checkBoxButton!.setBackgroundImage(UIImage(named: "checkbox_checked"), forState: UIControlState.Normal)
//        checkBoxButton!.backgroundColor = Resources.Color.navgationColor
        self.checkBoxView!.addSubview(checkBoxButton!)
        self.checkBoxButton!.mas_makeConstraints{ make in
            make.top.equalTo()(self.checkBoxView!.mas_top)
            make.bottom.equalTo()(self.checkBoxView!.mas_bottom)
            make.left.equalTo()(self.checkBoxView!.mas_left)
            make.right.equalTo()(self.checkBoxView!.mas_left).with().offset()(UIAdapter.shared.transferWidth(11))
        }
        
        checkBoxContent = UILabel()
        checkBoxContent!.font = UIAdapter.shared.transferFont(10)
        checkBoxContent!.text = "我已经阅读并接受"
        checkBoxContent!.hidden = true
        checkBoxContent!.textColor = UIColor.whiteColor()
        self.checkBoxView!.addSubview(checkBoxContent!)
        self.checkBoxContent!.mas_makeConstraints{ make in
            make.top.equalTo()(self.checkBoxView!.mas_top)
            make.bottom.equalTo()(self.checkBoxView!.mas_bottom)
            make.left.equalTo()(self.checkBoxButton!.mas_right).with().offset()(UIAdapter.shared.transferWidth(3))

        }
        
        linkCowPlanRules = UIButton(frame: CGRectMake(0, 0, UIAdapter.shared.transferWidth(10), UIAdapter.shared.transferHeight(50)))
        linkCowPlanRules!.backgroundColor = UIColor.whiteColor()
        linkCowPlanRules!.setTitle("《xx用户协议》", forState: UIControlState.Normal)
        linkCowPlanRules!.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
//        linkCowPlanRules!.backgroundColor = Resources.Color.navgationColor
        linkCowPlanRules!.titleLabel!.font = UIAdapter.shared.transferFont(10)
        linkCowPlanRules!.hidden = true
        self.checkBoxView!.addSubview(linkCowPlanRules!)
        
        linkCowPlanRules!.mas_makeConstraints{ make in
            make.top.equalTo()(self.checkBoxView!.mas_top)
            make.bottom.equalTo()(self.checkBoxView!.mas_bottom)
            make.left.equalTo()(self.checkBoxContent!.mas_right)
        }
        
    }
    
    func registerButtonClick (sender : UIButton){
        
        var validate:Bool = self.Validate()
        if(!validate) {return}
        
//        if !self.isSelected! {
//            MsgBoxHelper.showOkMessage("必须接受xx协议", title: "")
//            return
//        }
//        
//        var phone = self.phoneNumber!.text
//        var pwd1 = self.password!.text
//        var verify = self.verification!.text
//        
//        self.showProgress()
//        
//        service!.register(phone, pwd: pwd1, code: verify) { (result, data) -> Void in
//            self.closeProgress()
//            if(result.success!){
//               var currentLength = self.navigationController?.viewControllers.count
//               
//               var loginObject = self.navigationController?.viewControllers[currentLength! - 2] as? LoginViewController
//               if loginObject != nil {
//                    loginObject!.phoneTextField?.text = phone
//                    loginObject!.passwordTextField?.text = pwd1
//                }
//               self.navigationController?.popViewControllerAnimated(true)
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
//        if !self.phoneNumber!.matchRegex("^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$") {
//            MsgBoxHelper.showOkMessage("电话号码格式有错误", title: "")
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
//        
//        
//
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
//        if(password!.text.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 16 ||
//            password!.text.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) < 6)
//        {
//            MsgBoxHelper.showOkMessage("密码长度不正确", title: "")
//            return false
//        }
//        
//        if(verification!.text.isEmpty)
//        {
//            MsgBoxHelper.showOkMessage("请输入验证码", title: "")
//            return false
//        }
//        
//        
        return true
    }
    
    func checkLabelTap(){
        if !self.isSelected! {
            checkBoxButton!.setBackgroundImage(UIImage(named: "checkbox_checked"), forState: UIControlState.Normal)
//            checkBoxButton!.backgroundColor = Resources.Color.navgationColor
            checkBoxButton!.setNeedsDisplay()
            self.isSelected = !self.isSelected!
        }else{
            checkBoxButton!.setBackgroundImage(UIImage(named: ""), forState: UIControlState.Normal)
            checkBoxButton!.backgroundColor = UIColor.whiteColor()
            checkBoxButton!.setNeedsDisplay()
            self.isSelected = !self.isSelected!
        }
    }
}
