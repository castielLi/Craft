//
//  LoginController.swift
//  Craft
//
//  Created by castiel on 15/11/7.
//  Copyright © 2015年 castiel. All rights reserved.
//

import UIKit
import AVFoundation


class LoginController: ViewControllerBase {
    
    var backGroundImage : UIImageView?
    var acccountTextfield : UITextField?
    var passwordTextfield : UITextField?

    var iconImage : UIImageView?
    
    var loginButton : UIButton?
    var registerButton : UIButton?
    var player : AVAudioPlayer?
    var service : LoginService?
    
    
    var forgetPassword : UILabel?
    var register : UILabel?

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

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
        service = LoginService()
//        service!.login("jack", password: "123") { (result) -> Void in
//            
//        }
        service!.login("jack", password: "123")
    }
    
    override func initView() {
         setBackGroundImage()
         setIconImage()
         setEnterPart()
         setRegister()
         setForgetPassword()
         setLoginButton()
         beginSound()
    }
    
    func setForgetPassword(){
        self.forgetPassword = UILabel()
        self.forgetPassword!.text = "忘记密码?"
        self.forgetPassword!.textColor = UIColor.whiteColor()
        self.forgetPassword!.font = UIFont(name: "TimesNewRomanPS-BoldMT", size: UIAdapter.shared.transferHeight(9))
        self.view.addSubview(self.forgetPassword!)
        self.forgetPassword!.mas_makeConstraints{ make in
           make.bottom.equalTo()(self.passwordTextfield!).with().offset()(UIAdapter.shared.transferHeight(-1))
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
    
    
    func setEnterPart(){
        
        self.acccountTextfield = UITextField()
        self.acccountTextfield!.backgroundColor = UIColor.whiteColor()
        self.acccountTextfield!.alpha = 0.3
        self.acccountTextfield!.layer.cornerRadius = 5
        self.acccountTextfield!.layer.masksToBounds = true
        self.acccountTextfield!.layer.borderWidth = 1
        self.acccountTextfield!.layer.borderColor = UIColor(red: 123/255, green: 95/255, blue: 75/255, alpha: 1).CGColor

        self.view!.addSubview(self.acccountTextfield!)
     
        self.acccountTextfield!.mas_makeConstraints{ make in
           make.top.equalTo()(self.view!.mas_bottom).with().offset()(UIAdapter.shared.transferHeight(-140))
           make.bottom.equalTo()(self.view!.mas_bottom).with().offset()(UIAdapter.shared.transferHeight(-110))
           make.left.equalTo()(self.view!.mas_left).with().offset()(UIAdapter.shared.transferWidth(20))
           make.right.equalTo()(self.view!.mas_left).with().offset()(self.view.frame.width / 2 - UIAdapter.shared.transferWidth(10))
        }
        

        
        self.passwordTextfield = UITextField()
        self.passwordTextfield!.backgroundColor = UIColor.whiteColor()
        self.passwordTextfield!.alpha = 0.3
        self.passwordTextfield!.layer.cornerRadius = 5
        self.passwordTextfield!.layer.masksToBounds = true
        self.passwordTextfield!.layer.borderWidth = 1
        self.passwordTextfield!.layer.borderColor = UIColor(red: 123/255, green: 95/255, blue: 75/255, alpha: 1).CGColor
        self.view!.addSubview(self.passwordTextfield!)
        
        self.passwordTextfield!.mas_makeConstraints{ make in
            make.top.equalTo()(self.acccountTextfield!)
            make.bottom.equalTo()(self.acccountTextfield!)
            make.left.equalTo()(self.view?.mas_left).with().offset()(self.view.frame.width / 2 + UIAdapter.shared.transferWidth(10))
            make.right.equalTo()(self.view?.mas_right).with().offset()(UIAdapter.shared.transferWidth(-20))
        }
    }
    
    
    func setLoginButton(){
        self.loginButton = UIButton()
        self.loginButton!.backgroundColor = UIColor.clearColor()
        self.loginButton!.titleLabel?.font = UIFont(name: "TimesNewRomanPS-BoldMT", size: UIAdapter.shared.transferHeight(12))
        self.loginButton!.setTitle("登    录", forState: UIControlState.Normal)
        self.loginButton!.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        self.loginButton!.addTarget(self, action: "loginButtonClick:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view!.addSubview(loginButton!)
        
        self.loginButton!.mas_makeConstraints{make in
           make.top.equalTo()(self.passwordTextfield!.mas_bottom).with().offset()(UIAdapter.shared.transferHeight(10))
           make.bottom.equalTo()(self.passwordTextfield!.mas_bottom).with().offset()(UIAdapter.shared.transferHeight(40))
            make.left.equalTo()(self.passwordTextfield?.mas_left)
            make.right.equalTo()(self.passwordTextfield?.mas_right)
        }
    
    }
    
    func setRegister(){
        self.registerButton = UIButton()
        self.registerButton!.backgroundColor = UIColor.clearColor()
        self.registerButton!.titleLabel?.font = UIFont(name: "TimesNewRomanPS-BoldMT", size: UIAdapter.shared.transferHeight(12))
        self.registerButton!.setTitle("注    册", forState: UIControlState.Normal)
        self.registerButton!.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        self.registerButton!.addTarget(self, action: "registerButtonClick:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view!.addSubview(registerButton!)
        
        self.registerButton!.mas_makeConstraints{make in
            make.top.equalTo()(self.acccountTextfield!.mas_bottom).with().offset()(UIAdapter.shared.transferHeight(10))
            make.bottom.equalTo()(self.acccountTextfield!.mas_bottom).with().offset()(UIAdapter.shared.transferHeight(40))
            make.left.equalTo()(self.acccountTextfield?.mas_left)
            make.right.equalTo()(self.acccountTextfield?.mas_right)
        }

    }
    
    func registerButtonClick(sender : UIButton){
        let registerView = RegisterController(nibName: nil, bundle: nil)
        self.navigationController!.pushViewController(registerView, animated: true)
    }
    
    
    func loginButtonClick(sender : UIButton){
        self.acccountTextfield!.hidden = true
        self.passwordTextfield!.hidden = true
        self.loginButton!.hidden = true
        self.registerButton!.hidden = true
        self.forgetPassword!.hidden = true
        
        self.definesPresentationContext = true
        
        
        //融云登录        
        RCIM.sharedRCIM().connectWithToken("WR2i0I07FA3sS6yv3j5G8slRWzGSVmtCYmURsUlF14+e5Rr9BT+O3cQMFJ+FPDFeOIACenxFpzL7O3U2PAtoUA==",
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

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
