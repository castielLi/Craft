//
//  SignUp.swift
//  Craft
//
//  Created by castiel on 15/11/7.
//  Copyright © 2015年 castiel. All rights reserved.
//

import UIKit

class SignUp: ViewControllerBase , UITableViewDelegate , UITableViewDataSource {

    var firstTime : Bool = true
    var backGroundImage : UIImageView?
    var bloodBackGroundImage : UIImageView?
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
         self.tabBarController!.tabBar.hidden = true
        let nc = NSNotificationCenter.defaultCenter()
        nc.addObserver(self, selector: "showCurrentView:", name: "loginDisappear", object: nil)
        
        
        let center = NSNotificationCenter.defaultCenter()
        center.addObserver(self,
        selector: "activitiesDialogDisappear:", name: "dismissAcitivtiesDialog", object: nil)
        self._hasNotification = true
        
        let menuButton = UIButton(frame: CGRect(x: 0, y: 0, width: UIAdapter.shared.transferWidth(40), height: UIAdapter.shared.transferHeight(20)) )
        menuButton.setTitle("Menu", forState: UIControlState.Normal)
        menuButton.titleLabel!.textColor = UIColor.whiteColor()
        menuButton.addTarget(self, action: "MenuClick:", forControlEvents: UIControlEvents.TouchUpInside)
        
        let rightBarButton = UIBarButtonItem(customView: menuButton)
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        
        let calendarButton = UIButton(frame: CGRect(x: 0, y: 0, width: UIAdapter.shared.transferWidth(40), height: UIAdapter.shared.transferHeight(20)) )
        calendarButton.setTitle("calendar", forState: UIControlState.Normal)
        calendarButton.titleLabel!.textColor = UIColor.whiteColor()
        calendarButton.addTarget(self, action: "calenderClick:", forControlEvents: UIControlEvents.TouchUpInside)

        
        let leftBarButton = UIBarButtonItem(customView: calendarButton)
        self.navigationItem.leftBarButtonItem = leftBarButton

        
        self.addTimerSwipe()
        self.addActivitySwipe()
        
        
        let animation = CASpringAnimation(keyPath: "position.x")
        animation.damping = 12
        animation.stiffness = 100
        animation.mass = 1
        animation.initialVelocity = 0
        animation.duration = animation.settlingDuration
        animation.removedOnCompletion = false
        animation.timingFunction = CAMediaTimingFunction( name: kCAMediaTimingFunctionEaseOut)
        animation.fromValue = -UIAdapter.shared.transferWidth(150)
        
        self.timeView!.layer.addAnimation(animation, forKey: nil)
        self.activityMainView!.layer.addAnimation(animation, forKey: nil)
        
        let xAnimation = CABasicAnimation(keyPath: "position.x")
        xAnimation.toValue = self.view!.frame.size.width * 2
        xAnimation.fromValue = -self.view!.frame.size.width / 2
        xAnimation.duration = 20
        xAnimation.repeatCount = Float.infinity
        bloodBackGroundImage!.layer.addAnimation(xAnimation, forKey: "position.x")
        
    }
    
    func showCurrentView(sender : NSNotification){
        if self.firstTime {
            self.tabBarController?.tabBar.hidden = true
            self.navigationController?.setNavigationBarHidden(true, animated: false)
            UIView.animateWithDuration(1, animations: { () -> Void in
                self.view.alpha = 1
                self.timeView!.alpha = 1
                self.setCircleRing()
                self.setAnimationLayer()
                }, completion: { (finished) -> Void in
                    self.view.layer.removeAllAnimations()
                    self.tabBarController?.tabBar.hidden = true
                    self.navigationController?.setNavigationBarHidden(false, animated: true) 
            })
        }
        self.firstTime = false
    }

    func calenderClick(sender : UIButton){
        self.tabBarController?.selectedIndex = 0
    }
    
    func MenuClick(sender : UIButton){
        self.MenuClick()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
       
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.alpha = 0
        let loginView = LoginController(nibName: nil, bundle: nil)
        let loginNav = UINavigationController(rootViewController: loginView)
        self.tabBarController?.presentViewController(loginNav, animated: false, completion: nil)
        
        self.navigationController!.navigationBar.barStyle = UIBarStyle.BlackTranslucent
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(named: "navigationBackGround"), forBarMetrics: UIBarMetrics.Default)
        
        
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
        
  
        self.rightMenu!.chatRoom?.addTarget(self, action: "chatRoomClick:", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.rightMenu!.setting!.addTarget(self, action: "settingClick:", forControlEvents: UIControlEvents.TouchUpInside)
        
    }
    
    func chatRoomClick(sender :UIButton){
        let chat = ChatContactList()
        self.navigationController?.pushViewController(chat, animated: true)
    }
    
    func settingClick(sender :UIButton){
        let chat = ChatContactList()
        self.navigationController?.pushViewController(chat, animated: true)
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
        self.backGroundImage!.image = UIImage(named: "MainBackGround")
        self.backGroundImageNumber += 1
        self.view.addSubview(self.backGroundImage!)
        
        
        self.bloodBackGroundImage = UIImageView(frame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.height))
        self.bloodBackGroundImage!.image = UIImage(named: "blood")
        self.view.addSubview(self.bloodBackGroundImage!)
        
        
        
        //变幻背景图片
        
//        self.verifyRequestCount = 5
//        self.timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "updateTimer:", userInfo: nil, repeats: true)
        
       
    }
    
    func setTimerView(){
        self.timeView = TimerView(frame: CGRectMake( (self.view.frame.width - UIAdapter.shared.transferWidth(200)) / 2 ,
            (self.view.frame.height - UIAdapter.shared.transferWidth(200)) - 88 ,UIAdapter.shared.transferWidth(200), UIAdapter.shared.transferWidth(200)))
        self.view.addSubview(self.timeView!)
        self.timeView!.joinButton!.addTarget(self, action: "joinButtonClick:", forControlEvents: UIControlEvents.TouchUpInside)
        self.timeView!.alpha = 0
    }
    
    
    func setActivityMainView(){
       self.activityMainView = ActivityMainView(frame: CGRect(x: -UIAdapter.shared.transferWidth(240), y: 64 + UIAdapter.shared.transferHeight(15), width: UIAdapter.shared.transferWidth(290), height: UIAdapter.shared.transferHeight(370)))
        
       self.view.addSubview(self.activityMainView!)
       self.activityMainView!.hidden = true
       self.activityMainView!.activityTabel!.delegate = self
       self.activityMainView!.activityTabel!.dataSource = self
       self.activityMainView!.activityTabel!.separatorStyle = UITableViewCellSeparatorStyle.None
       self.activityMainView!.activityTabel!.showsVerticalScrollIndicator = false
       self.activityMainView!.activityTabel!.showsHorizontalScrollIndicator = false
        
       self.activityMainView!.searchActivityButton!.addTarget(self, action: "searchActivityClick:", forControlEvents: UIControlEvents.TouchUpInside)
        
       self.activityMainView!.MyActivityButton!.addTarget(self, action: "myActivityClick:", forControlEvents: UIControlEvents.TouchUpInside)

       self.activityMainView!.addNewActivity!.addTarget(self, action: "AddNewActivity:", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func searchActivityClick(sender : UIButton){
        sender.setImage(UIImage(named: "searchActivity_selected"), forState: UIControlState.Normal)
        self.activityMainView!.MyActivityButton!.setImage(UIImage(named: "myActivity"), forState: UIControlState.Normal)
    }
    
    func myActivityClick(sender : UIButton){
        sender.setImage(UIImage(named: "myActivity_selected"), forState: UIControlState.Normal)
        self.activityMainView!.searchActivityButton!.setImage(UIImage(named: "searchActivity"), forState: UIControlState.Normal)
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
        if self.view.frame.origin.x > 0 {
            return
        }
        
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
    
    
        func joinButtonClick(sender : UIButton){
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
        
        UIView.animateWithDuration(0.4, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.activityMainView!.frame.origin.x = -UIAdapter.shared.transferWidth(240)
            
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
        UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 100, initialSpringVelocity: 5, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            
            self.activityMainView!.frame.origin.x = 0
            
            }, completion: nil)
    }

    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("activityItemCell") as? ActivityItemCell
        
        if cell == nil{
            cell = ActivityItemCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "activityItemCell", cellHeight: UIAdapter.shared.transferHeight(65),cellWidth: self.activityMainView!.activityTabel!.bounds.width )
        }
        
        cell!.backgroundImage!.image = UIImage(named: "activityItem")
        cell!.iconImage!.image = UIImage(named: "challenge")
        cell!.raidName!.text = "纳克萨玛斯"
        cell!.dutyPart!.damageLabel!.text = "13"
        cell!.dutyPart!.tankLabel!.text = "3"
        cell!.dutyPart!.healLabel!.text = "4"
        cell!.contentLabel!.text = "老1-老4,来熟练工，不墨迹 老1-老4,来熟练工，不墨迹 老1-老4,来熟练工，不墨迹"
        cell!.leadName!.text = "伊莎贝拉殿下"
        
        if indexPath.row % 3 == 0 {
//           cell!.timePart!.firstPart!.text = "27"
//           cell!.timePart!.midPart!.font = UIFont(name: "DINAlternate-Bold", size: UIAdapter.shared.transferHeight(20))
//           cell!.timePart!.midPart!.text = "days"
            cell!.timePart!.firstPart?.text = "165"
            cell!.timePart!.midPart!.text = ":"
            cell!.timePart!.midPart!.font = UIFont(name: "DB LCD Temp", size: UIAdapter.shared.transferHeight(20))
            cell!.timePart!.secondPart!.text = "43"
        }else{
        cell!.timePart!.firstPart?.text = "07"
        cell!.timePart!.midPart!.text = ":"
        cell!.timePart!.midPart!.font = UIFont(name: "DB LCD Temp", size: UIAdapter.shared.transferHeight(20))
        cell!.timePart!.secondPart!.text = "43"
        }
        
//        cell!.textLabel?.text = "hello world"
        
        cell!.selectionStyle = UITableViewCellSelectionStyle.None
        return cell!
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UIAdapter.shared.transferHeight(65)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! ActivityItemCell
        cell.backgroundImage!.image = UIImage(named: "activityItem_click")
        displayActivityDetail()
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! ActivityItemCell
        cell.backgroundImage!.image = UIImage(named: "activityItem")
    }
    
    //table animation
//    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
//        
//        var rotation = CATransform3DMakeRotation( CGFloat(0.3 * M_PI) , 0.0, 0.5, 0.0);
//        rotation.m34 = 1.0 / -600;
//        
//        
//        //2. Define the initial state (Before the animation)
//        //        cell.layer.shadowColor = UIColor.blackColor().CGColor
//        //        cell.layer.shadowOffset = CGSizeMake(10, 10);
//        
//        cell.layer.transform = rotation;
//        cell.layer.anchorPoint = CGPointMake(0.5, 0.5);
//        
//        
//        UIView.beginAnimations("rotation", context: nil)
//        UIView.setAnimationDuration(0.8)
//        //3. Define the final state (After the animation) and commit the animation
//        cell.layer.transform = CATransform3DIdentity;
//        cell.alpha = 1;
//        cell.layer.shadowOffset = CGSizeMake(0, 0);
//        UIView.commitAnimations()
//    }

    
    
    func displayActivityDetail(){
        UIView.animateWithDuration(0.4, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.activityMainView!.frame.origin.x = -UIAdapter.shared.transferWidth(280)
            
        }) { (success) -> Void in
            if success {
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
