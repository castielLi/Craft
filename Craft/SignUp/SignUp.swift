//
//  SignUp.swift
//  Craft
//
//  Created by castiel on 15/11/7.
//  Copyright © 2015年 castiel. All rights reserved.
//

import UIKit
import AVFoundation

class SignUp: ViewControllerBase ,RCIMClientReceiveMessageDelegate{

    var soundPlay :PlaySound?
    var firstTime : Bool = true
    var backGroundImage : UIImageView?
    var bloodBackGroundImage : UIImageView?
    var backGroundImageNumber : Int = 1
    var timer:NSTimer?
    var verifyRequestCount : Int = 5
    var timeView : TimerView?
    var shapeLayer : CAShapeLayer?
    
    var activityMainView : ActivityMainView?
    var mainMenuProtocal : MainMenuProtocol?
    var ovalShapeLayer: CAShapeLayer?
    
    //display views
    var showTimerSwipe : UISwipeGestureRecognizer?
    var showActivitySwipe : UISwipeGestureRecognizer?
    var showDailySwipe : UISwipeGestureRecognizer?
    var showChatSwipe : UISwipeGestureRecognizer?
    
    var displayWorldChat : UITapGestureRecognizer?
    
    var timerVisible : Bool = false
    var activityVisible : Bool = false
    var chatVisible : Bool = false
    var dailyVisible : Bool = false
    
    
    //chat 
    var worldChat : WorldChat?
    var completeState : Bool = false
    
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        soundPlay = PlaySound.sharedData()
        RCIMClient.sharedRCIMClient().setReceiveMessageDelegate(self, object: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
         self.tabBarController!.tabBar.hidden = true
        
        let unreadCount = RCIMClient.sharedRCIMClient().getTotalUnreadCount()
        
        let nc = NSNotificationCenter.defaultCenter()
        nc.addObserver(self, selector: "showCurrentView:", name: "loginDisappear", object: nil)
        
        
        let center = NSNotificationCenter.defaultCenter()
        center.addObserver(self,
        selector: "activitiesDialogDisappear:", name: "dismissAcitivtiesDialog", object: nil)
        self._hasNotification = true
        
        let chatButton = ChatNavigationView(frame: CGRect(x: 0, y: 0, width: UIAdapter.shared.transferWidth(30) + 5, height: UIAdapter.shared.transferHeight(12) + 20) )
        chatButton.chat!.setBackgroundImage(UIImage(named: "friend"), forState: UIControlState.Normal)
        chatButton.count!.text = "\(unreadCount)"
        chatButton.chat!.addTarget(self, action: "ChatClick:", forControlEvents: UIControlEvents.TouchUpInside)

        
        let rightBarButton = UIBarButtonItem(customView: chatButton)
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        
        let calendarButton = UIButton(frame: CGRect(x: 0, y: 0, width: UIAdapter.shared.transferWidth(30), height: UIAdapter.shared.transferHeight(12)) )
        calendarButton.setBackgroundImage(UIImage(named: "daily"), forState: UIControlState.Normal)

        calendarButton.addTarget(self, action: "calenderClick:", forControlEvents: UIControlEvents.TouchUpInside)
        
        
        let leftBarButton = UIBarButtonItem(customView: calendarButton)
        self.navigationItem.leftBarButtonItem = leftBarButton
        
        
        let activityButton = UIButton(frame: CGRect(x: 0, y: 0, width: UIAdapter.shared.transferWidth(30), height: UIAdapter.shared.transferHeight(18)) )
        activityButton.setBackgroundImage(UIImage(named: "activity"), forState: UIControlState.Normal)
        
        self.navigationItem.titleView = activityButton
        
        self.registerGesture()

        self.joinCurrentChatRoom()
    }
    
    func showCurrentView(sender : NSNotification){
        if self.firstTime {
            self.tabBarController?.tabBar.hidden = true
//            self.navigationController?.setNavigationBarHidden(true, animated: false)
            UIView.animateWithDuration(1, animations: { () -> Void in
                self.view.alpha = 1
                self.timeView!.alpha = 1
                self.setCircleRing()
                self.setAnimationLayer()
                }, completion: { (finished) -> Void in
                    self.view.layer.removeAllAnimations()
                    self.tabBarController?.tabBar.hidden = true
//                    self.navigationController?.setNavigationBarHidden(false, animated: true) 
            })
        }
        self.firstTime = false
    }


    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
       
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.alpha = 0
       
        
        self.navigationController!.navigationBar.barStyle = UIBarStyle.BlackTranslucent
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(named: "navigationBackGround"), forBarMetrics: UIBarMetrics.Default)
        
        
        self.timerVisible = true
        
        // Do any additional setup after loading the view.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func initView() {
        setBackGround()
        setTimerView()
        setWorldChat()
        setActivityMainView()
    }
    
    func setWorldChat(){
       self.worldChat = WorldChat(frame: CGRect(x: UIAdapter.shared.transferWidth(15), y: UIAdapter.shared.transferHeight(100) + UIAdapter.shared.transferWidth(200), width: self.view.frame.width - UIAdapter.shared.transferWidth(30), height: self.view.frame.height - (UIAdapter.shared.transferHeight(110) + UIAdapter.shared.transferWidth(200) + 64)))
       self.view.addSubview(self.worldChat!)
    }
    
    func setBackGround(){
        self.backGroundImage = UIImageView(frame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.height))
        let path = NSBundle.mainBundle().pathForResource("MainBackGround", ofType: "png")
        self.backGroundImage!.image = UIImage(contentsOfFile: path!)
        self.backGroundImageNumber += 1
        self.view.addSubview(self.backGroundImage!)
        
        
        self.bloodBackGroundImage = UIImageView(frame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.height))
        let bloodPath = NSBundle.mainBundle().pathForResource("blood", ofType: "png")
        self.bloodBackGroundImage!.image = UIImage(contentsOfFile: bloodPath!)
        self.view.addSubview(self.bloodBackGroundImage!)
    }
    
    func setTimerView(){
        self.timeView = TimerView(frame: CGRectMake( (self.view.frame.width - UIAdapter.shared.transferWidth(200)) / 2 ,
            UIAdapter.shared.transferHeight(80) ,UIAdapter.shared.transferWidth(200), UIAdapter.shared.transferWidth(200)))
        self.view.addSubview(self.timeView!)
        self.timeView!.joinButton!.addTarget(self, action: "joinButtonClick:", forControlEvents: UIControlEvents.TouchUpInside)
        self.timeView!.alpha = 0
    }
    
    
    func setActivityMainView(){
       self.activityMainView = ActivityMainView(frame: CGRect(x: -UIAdapter.shared.transferWidth(290), y:  UIAdapter.shared.transferHeight(15), width: UIAdapter.shared.transferWidth(290), height: UIAdapter.shared.transferHeight(370)))
        
       self.view.addSubview(self.activityMainView!)
       self.activityMainView!.hidden = true
       self.activityMainView!.activityTabel!.delegate = self
       self.activityMainView!.activityTabel!.dataSource = self
       self.activityMainView!.activityTabel!.separatorStyle = UITableViewCellSeparatorStyle.None
       self.activityMainView!.activityTabel!.showsVerticalScrollIndicator = false
       self.activityMainView!.activityTabel!.showsHorizontalScrollIndicator = false
        
        
       self.activityMainView!.searchButton!.addTarget(self, action: "searchButtonClick:", forControlEvents: UIControlEvents.TouchUpInside)
        
       self.activityMainView!.searchActivityButton!.addTarget(self, action: "searchActivityClick:", forControlEvents: UIControlEvents.TouchUpInside)
        
       self.activityMainView!.MyActivityButton!.addTarget(self, action: "myActivityClick:", forControlEvents: UIControlEvents.TouchUpInside)

       self.activityMainView!.addNewActivity!.addTarget(self, action: "AddNewActivity:", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func searchActivityClick(sender : UIButton){
        
        let soundId = soundPlay!.sound.valueForKey(SoundResource.clickEventSound) as! String
        let id = UInt32(soundId)
        AudioServicesPlaySystemSound(id!);
        
        sender.setImage(UIImage(named: "searchActivity_selected"), forState: UIControlState.Normal)
        self.activityMainView!.MyActivityButton!.setImage(UIImage(named: "myActivity"), forState: UIControlState.Normal)
    }
    
    func searchButtonClick(sender : UIButton){
        let soundId = soundPlay!.sound.valueForKey(SoundResource.clickEventSound) as! String
        let id = UInt32(soundId)
        AudioServicesPlaySystemSound(id!);
    }
    
    func myActivityClick(sender : UIButton){
        
        let soundId = soundPlay!.sound.valueForKey(SoundResource.clickEventSound) as! String
        let id = UInt32(soundId)
        AudioServicesPlaySystemSound(id!);
        
        sender.setImage(UIImage(named: "myActivity_selected"), forState: UIControlState.Normal)
        self.activityMainView!.searchActivityButton!.setImage(UIImage(named: "searchActivity"), forState: UIControlState.Normal)
    }
    
    
    func setCircleRing(){
        
        let refreshRadius = UIAdapter.shared.transferWidth(100)
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: refreshRadius , y: refreshRadius ), radius: refreshRadius - CGFloat(10), startAngle: CGFloat(-M_PI*1/2), endAngle: CGFloat(M_PI*3/2), clockwise: true)

        
        shapeLayer = CAShapeLayer()
        shapeLayer!.path = circlePath.CGPath
        
        //change the fill color
        shapeLayer!.fillColor = UIColor.clearColor().CGColor
        //you can change the stroke color
        shapeLayer!.strokeColor = UIColor(red: 58/255, green: 54/255, blue: 55/255, alpha: 0.5).CGColor
        //you can change the line width
        shapeLayer!.lineWidth = 8.0
        
        self.timeView!.joinButton!.layer.addSublayer(shapeLayer!)
    
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

    
        func joinButtonClick(sender : UIButton){
            
            let soundId = soundPlay!.sound.valueForKey(SoundResource.clickEventSound) as! String
            let id = UInt32(soundId)
            AudioServicesPlaySystemSound(id!);
            
            for layer in self.timeView!.joinButton!.layer.sublayers!{
                layer.removeFromSuperlayer()
            }
            setCircleRing()
            setAnimationLayer()
    
            let date = NSDate().dateByAddingTimeInterval(5)
            let note = LocalNotification(title: "地狱火堡垒", deadLine: date , activityId: 1 )
            SendNotification.SendLocalNotifation(note)
            
//            SendNotification.RemoveNotificationFromUUID(1)
        }
    
    
    func AddNewActivity(sender : UIButton){
        
        let soundId = soundPlay!.sound.valueForKey(SoundResource.clickEventSound) as! String
        let id = UInt32(soundId)
        AudioServicesPlaySystemSound(id!);
        
        let swishinId = soundPlay!.sound.valueForKey(SoundResource.swishinSound) as! String
        let swishinid = UInt32(swishinId)
        AudioServicesPlaySystemSound(swishinid!);
        
        UIView.animateWithDuration(0.4, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.activityMainView!.frame.origin.x = -UIAdapter.shared.transferWidth(300)
            }) { (success) -> Void in
                if success {
                    let activitiesView = AddNewActivityController(nibName: nil, bundle: nil)
                    let activitiesNav = UINavigationController(rootViewController: activitiesView)
                    activitiesNav.modalPresentationStyle = UIModalPresentationStyle.OverFullScreen
                    self.presentViewController(activitiesNav, animated: false, completion: nil)
                }
        }
    }
    
    func activitiesDialogDisappear(sender : NSNotification){
        
        let soundId = soundPlay!.sound.valueForKey(SoundResource.swishout) as! String
        let id = UInt32(soundId)
        AudioServicesPlaySystemSound(id!);
        
        UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 100, initialSpringVelocity: 5, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            
            self.activityMainView!.frame.origin.x = 0
            
            }, completion: nil)
    }
    
    func displayActivityDetail(){
        
        UIView.animateWithDuration(0.4, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.activityMainView!.frame.origin.x = -UIAdapter.shared.transferWidth(280)
            
        }) { (success) -> Void in
            if success {
                
                let swishinId = self.soundPlay!.sound.valueForKey(SoundResource.swishinSound) as! String
                let swishinid = UInt32(swishinId)
                AudioServicesPlaySystemSound(swishinid!);

                
                let activitiesView = MyActivities(nibName: nil, bundle: nil)
                let activitiesNav = UINavigationController(rootViewController: activitiesView)
                activitiesNav.modalPresentationStyle = UIModalPresentationStyle.OverFullScreen
                self.presentViewController(activitiesNav, animated: false, completion: nil)
            }
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
