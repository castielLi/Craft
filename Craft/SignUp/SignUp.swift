//
//  SignUp.swift
//  Craft
//
//  Created by castiel on 15/11/7.
//  Copyright © 2015年 castiel. All rights reserved.
//

import UIKit

class SignUp: ViewControllerBase {

   
    var backGroundImage : UIImageView?
    var backGroundImageNumber : Int = 1
    var timer:NSTimer?
    var verifyRequestCount : Int = 5

    var joinButton : UIButton?
    
    var panGesture : UIPanGestureRecognizer?
   
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//        self.backGroundImageNumber = (random() % 4) + 1
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
       
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "报  名"
        self.view.backgroundColor = UIColor.grayColor()
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func initView() {
        setBackGround()
        setButton()
    }
    
    func setBackGround(){
        self.backGroundImage = UIImageView(frame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.height))
        self.backGroundImage!.image = UIImage(named: "MainBackGround\(self.backGroundImageNumber)")
        self.backGroundImageNumber += 1
        self.view.addSubview(self.backGroundImage!)
        
        self.verifyRequestCount = 5
        self.timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "updateTimer:", userInfo: nil, repeats: true)
    }
    
    func setButton(){
        self.joinButton = UIButton(frame: CGRectMake( (self.view.frame.width - UIAdapter.shared.transferWidth(200)) / 2 ,
           (self.view.frame.height - UIAdapter.shared.transferWidth(200)) / 2 + 64 ,UIAdapter.shared.transferWidth(200), UIAdapter.shared.transferWidth(200)))
        self.joinButton!.layer.masksToBounds = true
        self.joinButton!.layer.cornerRadius = UIAdapter.shared.transferWidth(100)
        self.view.addSubview(self.joinButton!)
        
        self.joinButton!.backgroundColor = UIColor(red: 83/255, green: 86/255, blue: 93/255, alpha: 0.9)
        
//        self.joinButton!.mas_makeConstraints{ make in
//           make.centerX.equalTo()(self.view)
//           make.centerY.equalTo()(self.view)
//        }
    }
    
    func updateTimer(sender: NSTimer) {
        if(verifyRequestCount < 1)
        {
            timer!.invalidate()
            timer = nil
            
            UIView.animateWithDuration(1, animations: { () -> Void in
                self.backGroundImage!.alpha = 0.5
                self.backGroundImage!.setNeedsDisplay()
                }, completion: { (finished) -> Void in
                    self.backGroundImage!.layer.removeAllAnimations()
                    self.backGroundImage!.image = UIImage(named: "MainBackGround\(self.backGroundImageNumber)")
                    UIView.animateWithDuration(2, animations: { () -> Void in
                        self.backGroundImage!.alpha = 1
                        }, completion: { (finished) -> Void in
                            self.backGroundImage!.layer.removeAllAnimations()
                            self.verifyRequestCount = 5
                            self.timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "updateTimer:", userInfo: nil, repeats: true)
                            self.backGroundImageNumber = (self.backGroundImageNumber % 4) + 1
                    })
            })
          }
         self.verifyRequestCount -= 1
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
