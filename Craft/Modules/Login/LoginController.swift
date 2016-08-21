//
//  LoginController.swift
//  Craft
//
//  Created by castiel on 15/11/7.
//  Copyright © 2015年 castiel. All rights reserved.
//

import UIKit
import AVFoundation


class LoginController: ViewControllerBase,LoginServiceDelegate {
    
    var backGroundImage : UIImageView?
    var acccountTextfield : UITextField?
    var passwordTextfield : UITextField?

    var iconImage : UIImageView?
    
    var loginButton : UIButton?
    var player : AVAudioPlayer?
    var service : LoginService?
    var forgetPassword : UILabel?
    var register : UILabel?
    
    
    //register
    var nick : UITextField?
    var battleAccount : UITextField?
    var password : UITextField?
    var passwordConfirm : UITextField?
    var telphone : UITextField?
    var registerButton : UIButton?
    var cancelButton : UIButton?
    

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.service = LoginService()
        self.service!.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController!.setNavigationBarHidden(true, animated: false)
        self.tabBarController?.tabBar.hidden = true
        
        self.setIconAnimation()
        
        let nc = NSNotificationCenter.defaultCenter()
        nc.addObserver(self, selector: Selector("ChooseSideDialogDisappear:"), name: "AfterChooseSide", object: nil)
    }

    func ChooseSideDialogDisappear(sender : NSNotification){
        
        let shrinkDuration = 2 * 0.3;
        let growDuration = 2 * 0.7;
        
        UIView.animateWithDuration(shrinkDuration, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 10, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                   let scaleTransform = CGAffineTransformMakeScale(1 , 1);
                   self.backGroundImage!.transform = scaleTransform

        }) { (finished) -> Void in
            UIView.animateWithDuration(growDuration, animations: { () -> Void in
                let scaleTransform = CGAffineTransformMakeScale(20, 30)
                self.backGroundImage!.transform = scaleTransform
                self.backGroundImage!.alpha = 0
                }, completion: { (finish) -> Void in
                   self.backGroundImage!.removeFromSuperview()
                    
                    self.dismissViewControllerAnimated(false, completion: {
                        NSNotificationCenter.defaultCenter().postNotificationName("loginDisappear", object: self)
                    })
            })
        }
        
        self.backGroundImage!.startAnimating()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.backGroundImage?.backgroundColor = UIColor.whiteColor()
        
        let backButton = UIBarButtonItem()
        self.navigationItem.backBarButtonItem = backButton
        self.navigationItem.backBarButtonItem?.title = ""

        
    }
    
    override func onLoad() {
        self.acccountTextfield!.text = "1120753340@qq.com"
        self.passwordTextfield!.text = "123"
    }
    
    override func initView() {
         setBackGroundImage()
         setIconImage()
        
        //login page
         setEnterPart()
         setRegister()
         setForgetPassword()
         setLoginButton()
        
        //register page
//        setRegisterEnterView()
//        setRegisterButton()
        
         beginSound()
    }
    
    func setForgetPassword(){
        self.forgetPassword = UILabel()
        self.forgetPassword!.text = "忘记密码?"
        self.forgetPassword!.textColor = Resources.Color.dailyColor
        self.forgetPassword!.font = UIFont(name: "KaiTi", size: UIAdapter.shared.transferHeight(10))
        self.view.addSubview(self.forgetPassword!)
        self.forgetPassword!.mas_makeConstraints{ make in
           make.top.equalTo()(self.passwordTextfield!.mas_bottom).with().offset()(UIAdapter.shared.transferHeight(2))
           make.right.equalTo()(self.passwordTextfield!).with().offset()(UIAdapter.shared.transferWidth(-2))
        }
        
        let forgetPasswordTap = UITapGestureRecognizer(target: self, action: "forgetPasswordLabelClick:")
        forgetPasswordTap.numberOfTapsRequired = 1
        self.forgetPassword!.userInteractionEnabled = true
        self.forgetPassword!.addGestureRecognizer(forgetPasswordTap)
    }
    
    func forgetPasswordLabelClick( sender : UITapGestureRecognizer){
        let forgetPasswordView = ForgetPassword(nibName: nil, bundle: nil)
        self.navigationController!.pushViewController(forgetPasswordView, animated: true)
    }
    
    
    func beginSound(){

        let customQueue = dispatch_queue_create("pcmPlayer", nil)
        dispatch_async(customQueue, {
            let mainBundle = NSBundle.mainBundle()
                        let filePath = mainBundle.pathForResource("wow_main_theme", ofType:"mp3")
                        let url = NSURL(fileURLWithPath: filePath!)
                        let fileData = try! NSData(contentsOfURL: url, options: NSDataReadingOptions.MappedRead)
                        do{
                        self.player = try AVAudioPlayer(data: fileData)
                        }catch{
                
                        }

                        if self.player!.prepareToPlay() && self.player!.play(){
                            /* Successfully started playing */
                        } else {
                            /* Failed to play */
                        }
            })

    }
    
    func setBackGroundImage(){
        self.backGroundImage = UIImageView(frame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.height))
        let path = NSBundle.mainBundle().pathForResource("LoginBackGround", ofType: "png")
        self.backGroundImage!.image = UIImage(contentsOfFile: path!)
        self.view.addSubview(self.backGroundImage!)
    }
    
    
    func setIconImage(){
        self.iconImage = UIImageView(frame: CGRectMake(0, 0, UIAdapter.shared.transferWidth(80), UIAdapter.shared.transferWidth(80)))
        self.iconImage!.image = UIImage(named: "icon")
        self.backGroundImage!.addSubview(iconImage!)
        
        self.iconImage!.mas_makeConstraints{ make in
            make.centerX.equalTo()(self.view)
            make.top.equalTo()(self.view.mas_top).with().offset()(UIAdapter.shared.transferHeight(100))
        }
        
    }
    
    func setIconAnimation(){
        
        
        let values = [0, 0, (M_PI)]
        let times = [0.0,0.35 , 0.55,1]
        
        let animation = CAKeyframeAnimation(keyPath: "transform.rotation.y")
        animation.values = values as [AnyObject]
        animation.keyTimes = times
        animation.removedOnCompletion = false
        animation.timeOffset = 0;
        
        animation.repeatCount =  Float.infinity
        animation.duration = 2
        
        iconImage!.layer.addAnimation(animation, forKey: "rotation")
        
        let xAnimation = CABasicAnimation(keyPath: "position.x")
        xAnimation.toValue = -self.iconImage!.frame.size.width
        xAnimation.fromValue = self.view.frame.width + self.iconImage!.frame.size.width
        xAnimation.duration = 3
        xAnimation.repeatCount = Float.infinity
        iconImage!.layer.addAnimation(xAnimation, forKey: "position.x")
    }
    
    
    func setLoginButton(){
        self.loginButton = UIButton()
        self.loginButton!.layer.cornerRadius = 5
        self.loginButton!.layer.masksToBounds = true
        self.loginButton!.setBackgroundImage(UIImage(named: "loginbutton"), forState: UIControlState.Normal)
        self.loginButton!.addTarget(self, action: "loginButtonClick:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view!.addSubview(loginButton!)
        
        self.loginButton!.mas_makeConstraints{make in
           make.top.equalTo()(self.passwordTextfield!.mas_bottom).with().offset()(UIAdapter.shared.transferHeight(30))
           make.bottom.equalTo()(self.passwordTextfield!.mas_bottom).with().offset()(UIAdapter.shared.transferHeight(55))
            make.left.equalTo()(self.passwordTextfield?.mas_left)
            make.right.equalTo()(self.passwordTextfield?.mas_right)
        }
    
    }
    
    func setRegister(){
        self.register = UILabel()
        self.register!.backgroundColor = UIColor.clearColor()
        self.register!.font = UIFont(name: "KaiTi", size: UIAdapter.shared.transferHeight(10))
        self.register!.text = "注册帐号"
        self.register!.textColor = Resources.Color.dailyColor
        self.view!.addSubview(register!)
        
        self.register!.mas_makeConstraints{make in
            make.top.equalTo()(self.acccountTextfield!.mas_bottom).with().offset()(UIAdapter.shared.transferHeight(2))
            make.right.equalTo()(self.acccountTextfield!.mas_right).with().offset()(UIAdapter.shared.transferWidth(-2))
        }

    }
    

    func setEnterPart(){
        
        self.acccountTextfield = UITextField()
        self.acccountTextfield!.backgroundColor = UIColor.blackColor()
        self.acccountTextfield!.textColor = UIColor.whiteColor()
        self.acccountTextfield!.leftView = UIView(frame:CGRect(x: 0, y: 0, width: 5, height: UIAdapter.shared.transferHeight(30) ))
        self.acccountTextfield!.font = UIFont(name: "KaiTi", size: UIAdapter.shared.transferHeight(15))
        self.acccountTextfield!.layer.cornerRadius = 5
        self.acccountTextfield!.layer.masksToBounds = true
        self.acccountTextfield!.layer.borderWidth = 2
        acccountTextfield!.leftViewMode = UITextFieldViewMode.Always
        self.acccountTextfield!.layer.borderColor = UIColor(red: 28/255, green: 34/255, blue: 38/255, alpha: 1).CGColor
        
        self.view!.addSubview(self.acccountTextfield!)
        
        self.acccountTextfield!.mas_makeConstraints{ make in
            make.top.equalTo()(self.view!.mas_bottom).with().offset()(UIAdapter.shared.transferHeight(-200))
            make.bottom.equalTo()(self.view!.mas_bottom).with().offset()(UIAdapter.shared.transferHeight(-170))
            make.left.equalTo()(self.view).with().offset()(UIAdapter.shared.transferWidth(50))
            make.right.equalTo()(self.view!).with().offset()(-UIAdapter.shared.transferWidth(50))
        }
        
        
        
        self.passwordTextfield = UITextField()
        self.passwordTextfield!.backgroundColor = UIColor.blackColor()
        self.passwordTextfield!.textColor = UIColor.whiteColor()
        self.passwordTextfield!.leftView = UIView(frame:CGRect(x: 0, y: 0, width: 5, height: UIAdapter.shared.transferHeight(30)))
        passwordTextfield!.leftViewMode = UITextFieldViewMode.Always
        self.passwordTextfield!.font = UIFont(name: "KaiTi", size: UIAdapter.shared.transferHeight(15))
        self.passwordTextfield!.layer.cornerRadius = 5
        self.passwordTextfield!.layer.masksToBounds = true
        self.passwordTextfield!.layer.borderWidth = 2
        self.passwordTextfield!.secureTextEntry = true
        self.passwordTextfield!.layer.borderColor = UIColor(red: 28/255, green: 34/255, blue: 38/255, alpha: 1).CGColor
        self.view!.addSubview(self.passwordTextfield!)
        
        self.passwordTextfield!.mas_makeConstraints{ make in
            make.top.equalTo()(self.acccountTextfield!.mas_bottom).with().offset()(UIAdapter.shared.transferHeight(25))
            make.bottom.equalTo()(self.acccountTextfield!).with().offset()(UIAdapter.shared.transferHeight(55))
            make.left.equalTo()(self.acccountTextfield)
            make.right.equalTo()(self.acccountTextfield)
        }
    }

    
    func loginButtonClick(sender : UIButton){
        self.showProgress()
        self.service!.login(self.acccountTextfield!.text, password: self.passwordTextfield!.text)
    }
    
    func didLogin(rcToken : String){
        self.acccountTextfield!.hidden = true
        self.passwordTextfield!.hidden = true
        self.loginButton!.hidden = true
        self.register!.hidden = true
        self.forgetPassword!.hidden = true
        
        self.definesPresentationContext = true
        
        //获取用户好友列表
        service!.GetMyFriends()
        //获取用户群组列表
        service!.GetMyGroups()
        
        service!.GetInitActivitiesData()
        
        //融云登录
        RCIM.sharedRCIM().connectWithToken(rcToken,
                                           success: { (userId) -> Void in
                                            print("登陆成功。当前登录的用户ID：\(userId)")
            }, error: { (status) -> Void in
                print("登陆的错误码为:\(status.rawValue)")
            }, tokenIncorrect: {
                //token过期或者不正确。
                //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
                //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
                print("token错误")
        })
        
        
        
        let chooseSideView = ChooseSide(nibName: nil, bundle: nil)
        let dialogViewNav = UINavigationController(rootViewController: chooseSideView)
        dialogViewNav.modalPresentationStyle = UIModalPresentationStyle.OverFullScreen
        self.presentViewController(dialogViewNav, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.player = nil
    }

    func loginDidFinish(result: ApiResult!, response: AnyObject!) {
        self.closeProgress()
        if(result.state){
            self.didLogin((result.data as! ProfileModel).chatToken)
        }else{
            MsgBoxHelper.show("错误", message: result.message)
        }
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
