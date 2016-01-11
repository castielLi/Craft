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
   
    var ovalShapeLayer: CAShapeLayer?
    
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
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        setAnimationLayer()
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
        self.joinButton!.addTarget(self, action: "joinButtonClick:", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func setAnimationLayer(){
        ovalShapeLayer = CAShapeLayer()
        ovalShapeLayer!.fillColor = UIColor.clearColor().CGColor
        ovalShapeLayer!.lineWidth = 8.0
        ovalShapeLayer!.lineCap = kCALineCapRound
        let refreshRadius = UIAdapter.shared.transferWidth(100)
        

        ovalShapeLayer!.path =   UIBezierPath(arcCenter: CGPoint(x: refreshRadius , y: refreshRadius ), radius: refreshRadius - CGFloat(5), startAngle: CGFloat(-M_PI*1/2), endAngle: CGFloat(M_PI*3/2), clockwise: true).CGPath
        
        
        
        
        let values = NSMutableArray()
        let times = [0.0,0.5,1.0]
        
        
        values.addObject(UIColor.greenColor().CGColor)
        values.addObject(UIColor.orangeColor().CGColor)
        
        
        let strokeEndAnimation = CAKeyframeAnimation(keyPath: "strokeColor")
        strokeEndAnimation.values = values as [AnyObject]
        strokeEndAnimation.keyTimes = times
        strokeEndAnimation.calculationMode = kCAAnimationDiscrete
        strokeEndAnimation.removedOnCompletion = false
        strokeEndAnimation.timeOffset = 0;
        strokeEndAnimation.fillMode = kCAFillModeForwards;
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0.0
        animation.toValue = 1.0
        animation.removedOnCompletion = false
        animation.timeOffset = 0
        animation.fillMode = kCAFillModeForwards
        
        
        let strokeAnimationGroup = CAAnimationGroup()
        strokeAnimationGroup.duration = 10
        strokeAnimationGroup.removedOnCompletion = false
        strokeAnimationGroup.animations = [strokeEndAnimation,animation]
        ovalShapeLayer!.addAnimation(strokeAnimationGroup, forKey: nil)
    
        self.joinButton!.layer.addSublayer(ovalShapeLayer!)
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
    
    func joinButtonClick(sender : UIButton){
        for layer in self.joinButton!.layer.sublayers!{
            layer.removeFromSuperlayer()
        }
        setAnimationLayer()
        
        let date = NSDate().dateByAddingTimeInterval(5)
        let note = SignLocalNotification(title: "地狱火堡垒", deadLine: date )
        SendNotification.SendLocalNotifation(note)
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
