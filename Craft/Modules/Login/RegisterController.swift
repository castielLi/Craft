//
//  RegisterController.swift
//  Craft
//
//  Created by castiel on 15/6/17.
//  
//

import UIKit

class RegisterController: ViewControllerBase,LoginServiceDelegate {
    
    var backGroundImage : UIImageView?
    
    var nick : UITextField?
    
    var battleAccount : UITextField?
    
    var password : UITextField?
    
    var passwordConfirm : UITextField?

    var checkBoxView : UIView?
    
    var registerButton : UIButton?
    var backButton : UIButton?
    var service : LoginService?


    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        service = LoginService()
        service!.delegate = self
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
        self.title = "注册"
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func initView(){
        setBackGround()
        setEnterView()
        setLoginButton()
    }
    
    override func registerEvents() {

    }
    
    override func onLoad() {

    }
    
    
    func setBackGround(){
        self.backGroundImage = UIImageView(frame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.height))
        let path = NSBundle.mainBundle().pathForResource("LoginBackGround", ofType: "png")
        self.backGroundImage!.image = UIImage(contentsOfFile: path!)
        self.view.addSubview(self.backGroundImage!)
    }
    

    
    func setEnterView(){
        
        self.nick = UITextField()
        self.nick!.backgroundColor = UIColor.whiteColor()
        self.nick!.alpha = 0.3
        self.nick!.layer.cornerRadius = 5
        self.nick!.layer.masksToBounds = true
        self.nick!.layer.borderWidth = 1
        self.nick!.layer.borderColor = UIColor(red: 123/255, green: 95/255, blue: 75/255, alpha: 1).CGColor
        
        self.view!.addSubview(self.nick!)
        
        self.nick!.mas_makeConstraints{ make in
            make.top.equalTo()(self.view!.mas_top).with().offset()(UIAdapter.shared.transferHeight(170))
            make.bottom.equalTo()(self.view!.mas_top).with().offset()(UIAdapter.shared.transferHeight(200))
            make.left.equalTo()(self.view!.mas_left).with().offset()(UIAdapter.shared.transferWidth(60))
            make.right.equalTo()(self.view!.mas_right).with().offset()(UIAdapter.shared.transferWidth(-60))
        }
        
        self.password = UITextField()
        self.password!.backgroundColor = UIColor.whiteColor()
        self.password!.alpha = 0.3
        self.password!.layer.cornerRadius = 5
        self.password!.layer.masksToBounds = true
        self.password!.layer.borderWidth = 1
        self.password!.layer.borderColor = UIColor(red: 123/255, green: 95/255, blue: 75/255, alpha: 1).CGColor
        
        self.view!.addSubview(self.password!)
        
        self.password!.mas_makeConstraints{ make in
            make.top.equalTo()(self.nick!.mas_bottom).with().offset()(UIAdapter.shared.transferHeight(10))
            make.bottom.equalTo()(self.nick!.mas_bottom).with().offset()(UIAdapter.shared.transferHeight(40))
            make.left.equalTo()(self.view!.mas_left).with().offset()(UIAdapter.shared.transferWidth(60))
            make.right.equalTo()(self.view!.mas_right).with().offset()(UIAdapter.shared.transferWidth(-60))
        }
        
        self.passwordConfirm = UITextField()
        self.passwordConfirm!.backgroundColor = UIColor.whiteColor()
        self.passwordConfirm!.alpha = 0.3
        self.passwordConfirm!.layer.cornerRadius = 5
        self.passwordConfirm!.layer.masksToBounds = true
        self.passwordConfirm!.layer.borderWidth = 1
        self.passwordConfirm!.layer.borderColor = UIColor(red: 123/255, green: 95/255, blue: 75/255, alpha: 1).CGColor
        
        self.view!.addSubview(self.passwordConfirm!)
        
        self.passwordConfirm!.mas_makeConstraints{ make in
            make.top.equalTo()(self.password!.mas_bottom).with().offset()(UIAdapter.shared.transferHeight(10))
            make.bottom.equalTo()(self.password!.mas_bottom).with().offset()(UIAdapter.shared.transferHeight(40))
            make.left.equalTo()(self.view!.mas_left).with().offset()(UIAdapter.shared.transferWidth(60))
            make.right.equalTo()(self.view!.mas_right).with().offset()(UIAdapter.shared.transferWidth(-60))
        }

        
        self.battleAccount = UITextField()
        self.battleAccount!.backgroundColor = UIColor.whiteColor()
        self.battleAccount!.alpha = 0.3
        self.battleAccount!.layer.cornerRadius = 5
        self.battleAccount!.layer.masksToBounds = true
        self.battleAccount!.layer.borderWidth = 1
        self.battleAccount!.layer.borderColor = UIColor(red: 123/255, green: 95/255, blue: 75/255, alpha: 1).CGColor
        
        self.view!.addSubview(self.battleAccount!)
        
        self.battleAccount!.mas_makeConstraints{ make in
            make.top.equalTo()(self.passwordConfirm!.mas_bottom).with().offset()(UIAdapter.shared.transferHeight(10))
            make.bottom.equalTo()(self.passwordConfirm!.mas_bottom).with().offset()(UIAdapter.shared.transferHeight(40))
            make.left.equalTo()(self.view!.mas_left).with().offset()(UIAdapter.shared.transferWidth(60))
            make.right.equalTo()(self.view!.mas_right).with().offset()(UIAdapter.shared.transferWidth(-60))
        }
        
    }
    
    func setLoginButton(){
        self.registerButton = UIButton()
        self.registerButton!.backgroundColor = UIColor.clearColor()
        self.registerButton!.titleLabel?.font = UIFont(name: "TimesNewRomanPS-BoldMT", size: UIAdapter.shared.transferHeight(12))
        self.registerButton!.setTitle("注    册", forState: UIControlState.Normal)
        self.registerButton!.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        self.registerButton!.addTarget(self, action: "registerButtonClick:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view!.addSubview(registerButton!)
        
        self.registerButton!.mas_makeConstraints{make in
            make.top.equalTo()(self.battleAccount!.mas_bottom).with().offset()(UIAdapter.shared.transferHeight(10))
            make.bottom.equalTo()(self.battleAccount!.mas_bottom).with().offset()(UIAdapter.shared.transferHeight(30))
            make.left.equalTo()(self.battleAccount?.mas_left)
            make.right.equalTo()(self.battleAccount?.mas_right)
        }
        
        self.backButton = UIButton()
        self.backButton!.backgroundColor = UIColor.clearColor()
        self.backButton!.titleLabel?.font = UIFont(name: "TimesNewRomanPS-BoldMT", size: UIAdapter.shared.transferHeight(12))
        self.backButton!.setTitle("返    回", forState: UIControlState.Normal)
        self.backButton!.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        self.backButton!.addTarget(self, action: "backButtonClick:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view!.addSubview(backButton!)
        
        self.backButton!.mas_makeConstraints{make in
            make.top.equalTo()(self.registerButton!.mas_bottom).with().offset()(UIAdapter.shared.transferHeight(10))
            make.bottom.equalTo()(self.registerButton!.mas_bottom).with().offset()(UIAdapter.shared.transferHeight(30))
            make.left.equalTo()(self.battleAccount?.mas_left)
            make.right.equalTo()(self.battleAccount?.mas_right)
        }
    }

    func backButtonClick(sender : UIButton){
        self.navigationController!.popViewControllerAnimated(true)
    }
    

    func registerButtonClick (sender : UIButton){
        
        let validate:Bool = self.Validate()
        if(!validate) {return}
        
        self.showProgress()
        service!.registerNewAccount(nick!.text!, password: password!.text!, battleAccount: "")
        
    }
    
    func registerDidFinish(result: ApiResult!, response: AnyObject!) {
        self.closeProgress()
        if(result.state){
            MsgBoxHelper.show("", message: "新建帐号成功")
            self.navigationController!.popViewControllerAnimated(true)
        }else{
            MsgBoxHelper.show("错误", message: result.message)
        }
    }
    
    
    func Validate()->Bool{
        
        if(nick!.text!.isEmpty)
        {
            MsgBoxHelper.show("", message: "请输入帐号信息")
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
            MsgBoxHelper.show("", message: "请输入验证码")
            return false
        }
        
        
        return true
    }
    
}
