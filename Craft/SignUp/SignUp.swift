//
//  SignUp.swift
//  Craft
//
//  Created by castiel on 15/11/7.
//  Copyright © 2015年 castiel. All rights reserved.
//

import UIKit
import AVFoundation

class SignUp: ViewControllerBase ,RCIMClientReceiveMessageDelegate,UITextViewDelegate,SignUpServiceDelegate{

    var service : SignUpService?
    
    //datasource for activity
    var myActivitiesDatasource : NSArray?
    
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
    var dHeight : CGFloat?
    var firstTimeEnter : Bool = true;
    var textViewInitialHeight: CGFloat = 0
    
    
    var chatDetail:NSMutableArray = ["麦迪文说:卡德加你这个坑爹的学徒，老子正虚弱着的时候给我来了一套爆发，也不留心给老子祛除下debuff","卡德加说：.......就是不想","安度因罗萨说:好样的小伙子,我看好你！","杜隆坦说:我来拯救我的人民！我的世界正在消亡,我们必须联手打败古尔丹,他那黑暗魔法迟早会给我的人民带来灭亡","黑手说:你尽然背叛自己的同类,你以后别想模装备了"]
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        soundPlay = PlaySound.sharedData()
        RCIMClient.sharedRCIMClient().setReceiveMessageDelegate(self, object: nil)
        service = SignUpService()
        service!.delegate = self
    }
    
    func GetMyActivityDidFinish(result: ApiResult!, response: AnyObject!) {
        self.closeProgress()
        if(result.state){
            myActivitiesDatasource = result.data as? NSArray
            self.activityMainView!.activityTabel!.delegate = self
            self.activityMainView!.activityTabel!.dataSource = self
            self.activityMainView!.activityTabel!.reloadData()
        }else{
           MsgBoxHelper.show("", message: result.message!)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
         self.tabBarController!.tabBar.hidden = true
        
        if !self.firstTime{
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
        
        
        
        
        //通过http获取数据
        self.showProgress()
        self.service!.getAllMyActivities("1")
        }else{
           self.firstTime = false
        }
        
        
    }
    
    func showCurrentView(sender : NSNotification){
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
       self.worldChat!.enterText!.delegate = self
       self.view.addSubview(self.worldChat!)
        
       self.worldChat!.worldChatDetail!.tag = 1
       self.worldChat!.worldChatDetail!.delegate = self
       self.worldChat!.worldChatDetail!.dataSource = self
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
       self.activityMainView!.activityTabel!.tag = 2
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
        
        self.showProgress()
        self.service!.getAllActivities("1")
        
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
        
        self.showProgress()
        self.service!.getAllMyActivities("1")
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
    
    func displayActivityDetail(activityId : String){
        self.showProgress()
        self.service!.getActivityDetail(activityId)
    }
    
    func GetActivityDetailFinish(result: ApiResult!, response: AnyObject!,activityId:String) {
        self.closeProgress()
        if (result.state){
        
        UIView.animateWithDuration(0.4, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.activityMainView!.frame.origin.x = -UIAdapter.shared.transferWidth(290)
            
        }) { (success) -> Void in
            if success {
                
                let swishinId = self.soundPlay!.sound.valueForKey(SoundResource.swishinSound) as! String
                let swishinid = UInt32(swishinId)
                AudioServicesPlaySystemSound(swishinid!);
                
                
                let activitiesView = MyActivities(nibName: nil, bundle: nil)
                activitiesView.dataModel = result.data as! ActivityDetailModel
                activitiesView.playerListSource = (result.data as! ActivityDetailModel).activityUser
                activitiesView.activityId = activityId
                let activitiesNav = UINavigationController(rootViewController: activitiesView)
                activitiesNav.modalPresentationStyle = UIModalPresentationStyle.OverFullScreen
                self.presentViewController(activitiesNav, animated: false, completion: nil)
            }
          }
        }else{
           MsgBoxHelper.show("错误", message: result.message!)
        }
    }
    
    
   
    
    func tableScrollToBottom() {
//        if self.data.count > 0 {
//            self.detailTable?.scrollToRowAtIndexPath(NSIndexPath(forRow: self.data.count - 1, inSection: 0), atScrollPosition: .Bottom, animated: true)
//        }
    }
    
    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        if !self.completeState{
        self.showDetailOfWorldChat()
        }
        return true
    }
    
    func textViewDidChange(textView: UITextView) {
        // Caculate the size which best fits the specified size.
        // This height is just the height of textView which best fits its content.
        var height = textView.sizeThatFits(CGSizeMake(self.worldChat!.enterText!.frame
            .width, CGFloat(MAXFLOAT))).height
        // Compare with the original height, if bigger than original value, use current height, otherwise, use original value.
        height = height > self.textViewInitialHeight ? height : self.textViewInitialHeight
        // Here i set the max height for textView is 80.
        if height <= uiah(40) {
            // Get how much the textView grows at height dimission
            let heightDiff = height - self.worldChat!.enterText!.frame.height
            var currentDHeight : CGFloat = 0
            if (dHeight != nil){
                currentDHeight = heightDiff - dHeight!
            }
            UIView.animateWithDuration(0.05, animations: {
                
                
                if !self.firstTimeEnter && currentDHeight>0{
                    
                    self.worldChat!.enterForm!.frame = CGRectMake(self.worldChat!.enterForm!.frame.origin.x , self.worldChat!.enterForm!.frame.origin.y - heightDiff, self.worldChat!.enterForm!.frame.width, height + uiah(7))
                    
                    self.worldChat!.enterForm!.setNeedsLayout()
                    
//                    self.detailTable?.frame = CGRectMake(self.detailTable!.frame.origin.x, self.detailTable!.frame.origin.y, self.detailTable!.frame.width, self.detailTable!.frame.height - heightDiff)
                    
                    self.firstTimeEnter = true
                }else{
                    self.dHeight = heightDiff
                    self.firstTimeEnter = false
                }
                }, completion: {
                    finished in
                    dispatch_async(dispatch_get_main_queue(), {
                        self.tableScrollToBottom()
                    })
            })
        }
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n"){
            
            let model = ChatMessageModel()
            model.type = "chatroom"
            model.userName = "hello world"
            model.userId = "1"
            
            let para = model.currentModelToJsonString()
            print(para)
            
            let message = RCTextMessage(content: textView.text)
            message.extra = para
            RCIMClient.sharedRCIMClient().sendMessage(RCConversationType.ConversationType_PRIVATE, targetId: "1", content: message, pushContent: nil, success: { (messageId) in
                print("发送成功")
                }, error: { (error, messageId) in
                    print("发送失败")
            })
            
            textView.resignFirstResponder()
            textView.text = ""
        }
        return true
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
