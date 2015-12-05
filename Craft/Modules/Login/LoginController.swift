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
    
    var accountLabel : UILabel?
    var passwordLabel : UILabel?
    
    var loginButton : UIButton?
    var player : AVAudioPlayer?
    var service : LoginService?

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.tabBarController?.tabBar.hidden = true
        
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

        // Do any additional setup after loading the view.
    }
    
    override func onLoad() {
        service = LoginService()
        service!.login("", pwd: "") { (result) -> Void in
            
        }
    }
    
    override func initView() {
         setBackGroundImage()
         setEnterPart()
        setLoginButton()
        beginSound()
    }
    
    func beginSound(){

        let customQueue = dispatch_queue_create("pcmPlayer", nil)
        dispatch_async(customQueue, {
            let mainBundle = NSBundle.mainBundle()
                        let filePath = mainBundle.pathForResource("wow_main_theme", ofType:"mp3")
                        let url = NSURL(fileURLWithPath: filePath!)
                        let fileData = NSData(contentsOfURL: url)
                        do{
                        self.player = try AVAudioPlayer(data: fileData!)
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
        self.backGroundImage!.image = UIImage(named: "LoginBackGround")
        self.view.addSubview(self.backGroundImage!)
    }
    
    func setEnterPart(){
        
        self.accountLabel = UILabel()
        self.accountLabel!.textAlignment = NSTextAlignment.Center
        self.accountLabel!.text = "通行证帐号"
        self.accountLabel!.textColor = UIColor(red: 77/255, green: 98/255, blue: 91/255, alpha: 1)
        self.accountLabel!.font = UIFont(name: "TimesNewRomanPS-BoldMT", size: UIAdapter.shared.transferHeight(12))
        self.view!.addSubview(accountLabel!)
        
        self.accountLabel!.mas_makeConstraints{ make in
            make.top.equalTo()(self.view!.mas_top).with().offset()(UIAdapter.shared.transferHeight(150))
            make.bottom.equalTo()(self.view!.mas_top).with().offset()(UIAdapter.shared.transferHeight(165))
            make.left.equalTo()(self.view?.mas_left).with().offset()(UIAdapter.shared.transferWidth(40))
            make.right.equalTo()(self.view?.mas_right).with().offset()(UIAdapter.shared.transferWidth(-40))
        }
        
        
        self.acccountTextfield = UITextField()
        self.acccountTextfield!.backgroundColor = UIColor(red: 47/255, green: 69/255, blue: 66/255, alpha: 0.5)
        self.acccountTextfield!.layer.cornerRadius = 5
        self.acccountTextfield!.layer.masksToBounds = true
        self.acccountTextfield!.layer.borderWidth = 2
        self.acccountTextfield!.layer.borderColor = UIColor(red: 77/255, green: 98/255, blue: 91/255, alpha: 1).CGColor
        self.view!.addSubview(self.acccountTextfield!)
     
        self.acccountTextfield!.mas_makeConstraints{ make in
           make.top.equalTo()(self.view!.mas_top).with().offset()(UIAdapter.shared.transferHeight(170))
           make.bottom.equalTo()(self.view!.mas_top).with().offset()(UIAdapter.shared.transferHeight(200))
           make.left.equalTo()(self.view?.mas_left).with().offset()(UIAdapter.shared.transferWidth(40))
           make.right.equalTo()(self.view?.mas_right).with().offset()(UIAdapter.shared.transferWidth(-40))
        }
        
        
        self.passwordLabel = UILabel()
        self.passwordLabel!.textAlignment = NSTextAlignment.Center
        self.passwordLabel!.text = "密码"
        self.passwordLabel!.textColor = UIColor(red: 77/255, green: 98/255, blue: 91/255, alpha: 1)
        self.passwordLabel!.font = UIFont(name: "TimesNewRomanPS-BoldMT", size: UIAdapter.shared.transferHeight(12))
        self.view!.addSubview(passwordLabel!)
        
        self.passwordLabel!.mas_makeConstraints{ make in
            make.top.equalTo()(self.acccountTextfield!.mas_bottom).with().offset()(UIAdapter.shared.transferHeight(10))
            make.bottom.equalTo()(self.acccountTextfield!.mas_bottom).with().offset()(UIAdapter.shared.transferHeight(25))
            make.left.equalTo()(self.acccountTextfield?.mas_left)
            make.right.equalTo()(self.acccountTextfield?.mas_right)
        }
        
        
        self.passwordTextfield = UITextField()
        self.passwordTextfield!.backgroundColor = UIColor(red: 47/255, green: 69/255, blue: 66/255, alpha: 0.5)
        self.passwordTextfield!.layer.cornerRadius = 5
        self.passwordTextfield!.layer.masksToBounds = true
        self.passwordTextfield!.layer.borderWidth = 2
        self.passwordTextfield!.layer.borderColor = UIColor(red: 77/255, green: 98/255, blue: 91/255, alpha: 1).CGColor
        self.view!.addSubview(self.passwordTextfield!)
        
        self.passwordTextfield!.mas_makeConstraints{ make in
            make.top.equalTo()(self.acccountTextfield!.mas_bottom).with().offset()(UIAdapter.shared.transferHeight(30))
            make.bottom.equalTo()(self.acccountTextfield!.mas_bottom).with().offset()(UIAdapter.shared.transferHeight(60))
            make.left.equalTo()(self.acccountTextfield?.mas_left)
            make.right.equalTo()(self.acccountTextfield?.mas_right)
        }
    }
    
    
    func setLoginButton(){
        self.loginButton = UIButton()
        self.loginButton!.layer.cornerRadius = 5
        self.loginButton!.layer.masksToBounds = true
        self.loginButton!.layer.borderWidth = 2
        self.loginButton!.layer.borderColor = UIColor(red: 80/255, green: 1/255, blue: 3/255, alpha: 1).CGColor
        self.loginButton!.backgroundColor = UIColor(red: 101/255, green: 1/255, blue: 3/255, alpha: 1)
        self.loginButton!.titleLabel?.font = UIFont(name: "TimesNewRomanPS-BoldMT", size: UIAdapter.shared.transferHeight(12))
        self.loginButton!.setTitle("登  录", forState: UIControlState.Normal)
        self.loginButton!.setTitleColor(UIColor(red: 150/255, green: 132/255, blue: 68/255, alpha: 1), forState: UIControlState.Normal)
        self.loginButton!.addTarget(self, action: "loginButtonClick:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view!.addSubview(loginButton!)
        
        self.loginButton!.mas_makeConstraints{make in
           make.top.equalTo()(self.passwordTextfield!.mas_bottom).with().offset()(UIAdapter.shared.transferHeight(50))
           make.bottom.equalTo()(self.passwordTextfield!.mas_bottom).with().offset()(UIAdapter.shared.transferHeight(80))
            make.left.equalTo()(self.acccountTextfield?.mas_left)
            make.right.equalTo()(self.acccountTextfield?.mas_right)
        }
    
    }
    
    
    func loginButtonClick(sender : UIButton){
        
        
        self.acccountTextfield!.hidden = true
        self.passwordTextfield!.hidden = true
        self.passwordLabel!.hidden = true
        self.accountLabel!.hidden = true
        self.loginButton!.hidden = true
        
        self.definesPresentationContext = true
        let chooseSideView = ChooseSide(nibName: nil, bundle: nil)
        let dialogViewNav = UINavigationController(rootViewController: chooseSideView)
        dialogViewNav.modalPresentationStyle = UIModalPresentationStyle.OverFullScreen
        self.presentViewController(dialogViewNav, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
