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
    var timeView : TimerView?
    var activityMainView : ActivityMainView?
    var panGesture : UIPanGestureRecognizer?

    var menuIsOpen : Bool = false
    var TimerLimit : UIButton?
    var collectionOfStone : UIButton?
    var mainMenuProtocal : MainMenuProtocol?
    var ovalShapeLayer: CAShapeLayer?
    
    var disappearTimerSwipe : UISwipeGestureRecognizer?
    var disappearActivitySwipe : UISwipeGestureRecognizer?
    var timerVisible : Bool = false
    var activityVisible : Bool = false
    
    var rightMenu : RightMenu?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
 
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let center = NSNotificationCenter.defaultCenter()
        center.addObserver(self,
            selector: Selector("activitiesDialogDisappear:"), name: "dismissAcitivtiesDialog", object: nil)
        self._hasNotification = true
        
        
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        setCircleRing()
        setAnimationLayer()
    }
    
       
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.grayColor()
        // Do any additional setup after loading the view.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func initView() {
        setBackGround()
        setRightMenu()
        setTimerView()
        setActivityMainView()
        setTimerLimit()
        setStone()
    }
    
    func setRightMenu(){
        self.rightMenu = RightMenu(frame: CGRect(x: UIScreen.mainScreen().bounds.width + UIAdapter.shared.transferWidth(50) , y: (UIScreen.mainScreen().bounds.height - UIAdapter.shared.transferHeight(70)) / 2, width: UIAdapter.shared.transferWidth(50), height: UIAdapter.shared.transferHeight(70)))
        self.view.addSubview(self.rightMenu!)
        
    }
    
    
    func setTimerLimit(){
        TimerLimit = UIButton()
        TimerLimit!.bounds.size = CGSize(width: UIAdapter.shared.transferWidth(15), height: UIAdapter.shared.transferWidth(15))
        TimerLimit!.layer.cornerRadius = UIAdapter.shared.transferWidth(15/2)
        TimerLimit!.layer.masksToBounds = true
        TimerLimit!.setBackgroundImage(UIImage(named: "Chat"), forState: UIControlState.Normal)
        TimerLimit!.addTarget(self, action: "TimerLimitClick:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(self.TimerLimit!)
        
        self.TimerLimit!.mas_makeConstraints{ make in
           make.left.equalTo()(self.view).with().offset()(UIAdapter.shared.transferWidth(15))
           make.top.equalTo()(self.view!.mas_bottom).with().offset()(-44 - UIAdapter.shared.transferWidth(15))
        }
    }
    
    func setStone(){
        collectionOfStone = UIButton()
        collectionOfStone!.bounds.size = CGSize(width: UIAdapter.shared.transferWidth(15), height: UIAdapter.shared.transferWidth(15))
        collectionOfStone!.layer.cornerRadius = UIAdapter.shared.transferWidth(15/2)
        collectionOfStone!.layer.masksToBounds = true
        collectionOfStone!.setBackgroundImage(UIImage(named: "Chat"), forState: UIControlState.Normal)
        collectionOfStone!.addTarget(self, action: "StoneClick:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(self.collectionOfStone!)
        
        self.collectionOfStone!.mas_makeConstraints{ make in
            make.right.equalTo()(self.view!.mas_right).with().offset()(UIAdapter.shared.transferWidth(-15))
            make.top.equalTo()(self.view!.mas_bottom).with().offset()(-44 - UIAdapter.shared.transferWidth(15))
        }
    }

    
    func setBackGround(){
        self.backGroundImage = UIImageView(frame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.height))
        self.backGroundImage!.image = UIImage(named: "MainBackGround\(self.backGroundImageNumber)")
        self.backGroundImageNumber += 1
        self.view.addSubview(self.backGroundImage!)
        
        self.verifyRequestCount = 5
        self.timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "updateTimer:", userInfo: nil, repeats: true)
        
       
    }
    
    func setTimerView(){
        self.timeView = TimerView(frame: CGRectMake( (self.view.frame.width - UIAdapter.shared.transferWidth(200)) / 2 ,
            (self.view.frame.height - UIAdapter.shared.transferWidth(200)) - 88 ,UIAdapter.shared.transferWidth(200), UIAdapter.shared.transferWidth(200)))
        self.view.addSubview(self.timeView!)
    }
    
    
    func setActivityMainView(){
       self.activityMainView = ActivityMainView(frame: CGRect(x: -UIAdapter.shared.transferWidth(240), y: 64 + UIAdapter.shared.transferHeight(15), width: UIAdapter.shared.transferWidth(240), height: UIAdapter.shared.transferHeight(300)))
        
       self.view.addSubview(self.activityMainView!)
       self.activityMainView!.hidden = true
        
       self.activityMainView!.testButton!.addTarget(self, action: "testButtonClick:", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    
    func setCircleRing(){
        
        let refreshRadius = UIAdapter.shared.transferWidth(100)
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: refreshRadius , y: refreshRadius ), radius: refreshRadius - CGFloat(10), startAngle: CGFloat(-M_PI*1/2), endAngle: CGFloat(M_PI*3/2), clockwise: true)

        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.CGPath
        
        //change the fill color
        shapeLayer.fillColor = UIColor.clearColor().CGColor
        //you can change the stroke color
        shapeLayer.strokeColor = UIColor(red: 58/255, green: 54/255, blue: 55/255, alpha: 0.5).CGColor
        //you can change the line width
        shapeLayer.lineWidth = 8.0
        
        self.timeView!.joinButton!.layer.addSublayer(shapeLayer)
    
    }
    
    func setAnimationLayer(){
        ovalShapeLayer = CAShapeLayer()
        ovalShapeLayer!.fillColor = UIColor.clearColor().CGColor
        ovalShapeLayer!.lineWidth = 8.0
        ovalShapeLayer!.lineCap = kCALineCapRound
        let refreshRadius = UIAdapter.shared.transferWidth(100)
        

        ovalShapeLayer!.path =   UIBezierPath(arcCenter: CGPoint(x: refreshRadius , y: refreshRadius ), radius: refreshRadius - CGFloat(10), startAngle: CGFloat(-M_PI*1/2), endAngle: CGFloat(M_PI*3/2), clockwise: true).CGPath
        
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
    
        self.timeView!.joinButton!.layer.addSublayer(ovalShapeLayer!)
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
    
    
    func TimerLimitClick(sender : UIButton){
       
//        let chat = ChatContactList()
//        self.mainMenuProtocal!.PushNewController(chat)
        
        self.displayActivity()
    }
    
    func MenuClick(){
        if !self.menuIsOpen {

//            self.rightMenu!.hidden = false
            
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.rightMenu!.frame.origin.x = UIScreen.mainScreen().bounds.width - UIAdapter.shared.transferWidth(50) - 5
            })
            
        }else{
//
//           self.rightMenu?.hidden = true
            
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.rightMenu!.frame.origin.x = UIScreen.mainScreen().bounds.width + UIAdapter.shared.transferWidth(50)
            })
        
        }
        self.menuIsOpen = !self.menuIsOpen
    }
    
    func StoneClick(sender : UIButton){
//        self.mainMenuProtocal!.ChooseTab(1)
        
        self.displayTimer()
    }
    
    
    func displayTimer(){
       
        UIView.animateWithDuration(0.5, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.timeView!.frame.origin.y = -(self.view.frame.height - UIAdapter.shared.transferWidth(200) - 88 )
            
            }) { (success) -> Void in
                if success {
                    
                    UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 100, initialSpringVelocity: 5, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                        
                        self.activityMainView!.hidden = false
                        self.activityMainView!.frame.origin.x = 0
                        
                        }, completion: nil)
                    
                }
        }   

    }
    
    
    func displayActivity(){
        UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
            self.activityMainView!.frame.origin.x = -UIAdapter.shared.transferWidth(240)
            
            }) { (success) -> Void in
                if success {
                    
                    UIView.animateWithDuration(0.8, delay: 0, usingSpringWithDamping: 100, initialSpringVelocity: 18, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                        
                        self.timeView!.frame.origin.y = self.view.frame.height - UIAdapter.shared.transferWidth(200) - 88
                        self.activityMainView!.hidden = true
                        
                        }, completion: nil)
                    
                }
         }
    
    }
    
    
    func testButtonClick(sender : UIButton){
        
        UIView.animateWithDuration(0.4, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.activityMainView!.frame.origin.x = -UIAdapter.shared.transferWidth(240)
            
            }) { (success) -> Void in
                if success {
                    let activitiesView = MyActivities(nibName: nil, bundle: nil)
                    let activitiesNav = UINavigationController(rootViewController: activitiesView)
                    activitiesNav.modalPresentationStyle = UIModalPresentationStyle.OverFullScreen
                    self.presentViewController(activitiesNav, animated: false, completion: nil)
                }
        }
    }
    
    func activitiesDialogDisappear(sender : NSNotification){
        UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 100, initialSpringVelocity: 5, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            
            self.activityMainView!.frame.origin.x = 0
            
            }, completion: nil)
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
