//
//  SliderMain.swift
//  Craft
//
//  Created by castiel on 15/11/15.
//  Copyright © 2015年 castiel. All rights reserved.
//

import UIKit

class SliderMain: ViewControllerBase , MainMenuProtocol , UIGestureRecognizerDelegate{

    var soundPlay :PlaySound?
    var calendar : CalendarView?
    var reviewTable : UITableView?
    var bloodBackGroundImage : UIImageView?
    var reviewTableSource : ReviewTableSource?
    var calenderBackground : UIImageView?
    var dailyBackground : UIImageView?
    var originCellFrame : CGRect?
    var dailyDetail : DailyDetail?
    
    var showTimerSwipe : UISwipeGestureRecognizer?
    var showActivitySwipe : UISwipeGestureRecognizer?
    var showChatSwipe : UISwipeGestureRecognizer?
    

    weak var sign : SignUp?
    
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        soundPlay = PlaySound.sharedData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController!.navigationItem.setHidesBackButton(true, animated: false)
        let unreadCount = RCIMClient.sharedRCIMClient().getTotalUnreadCount()

       let chatButton = ChatNavigationView(frame: CGRect(x: 0, y: 0, width: UIAdapter.shared.transferWidth(30) + 5, height: UIAdapter.shared.transferHeight(12) + 20) )
        chatButton.chat!.setBackgroundImage(UIImage(named: "friend"), forState: UIControlState.Normal)
        chatButton.count!.text = "\(unreadCount)"
        chatButton.chat!.addTarget(self, action: "ChatClick:", forControlEvents: UIControlEvents.TouchUpInside)
        
        let rightBarButton = UIBarButtonItem(customView: chatButton)
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        let dailyButton = UIButton(frame: CGRect(x: 0, y: 0, width: UIAdapter.shared.transferWidth(30), height: UIAdapter.shared.transferHeight(12)) )
        dailyButton.setBackgroundImage(UIImage(named: "daily"), forState: UIControlState.Normal)
       
        
        
        let leftBarButton = UIBarButtonItem(customView: dailyButton)
        self.navigationItem.leftBarButtonItem = leftBarButton
        
        let activityButton = UIButton(frame: CGRect(x: 0, y: 0, width: UIAdapter.shared.transferWidth(30), height: UIAdapter.shared.transferHeight(18)) )
        activityButton.setBackgroundImage(UIImage(named: "activity"), forState: UIControlState.Normal)
        activityButton.addTarget(self, action: "activityClick:", forControlEvents: UIControlEvents.TouchUpInside)
        self.navigationItem.titleView = activityButton

        self.registerViewsGesture()
        
        let alphaAnimation = CABasicAnimation(keyPath: "opacity")
        alphaAnimation.duration = 0.8
        alphaAnimation.fromValue = 0.3
        alphaAnimation.toValue = 1

        self.reviewTable!.layer.addAnimation(alphaAnimation, forKey: nil)
        self.calendar!.layer.addAnimation(alphaAnimation, forKey: nil)
        self.calenderBackground!.layer.addAnimation(alphaAnimation,forKey : nil)
    }

    var backGroundImage : UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //透明导航栏
        self.navigationController!.navigationBar.barStyle = UIBarStyle.BlackTranslucent
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(named: "navigationBackGround"), forBarMetrics: UIBarMetrics.Default)
        
        self.view.backgroundColor = UIColor.clearColor()
        
    }
    
    override func initView() {
        setCalenderBackground()
        setCalenderActivitiesReview()
        setCalenderView()
        setDailyDetail()
    }
    
    func setDailyDetail(){
        self.dailyDetail = DailyDetail(frame: CGRectMake(UIAdapter.shared.transferWidth(30) , UIAdapter.shared.transferHeight(100), self.view.frame.width - UIAdapter.shared.transferWidth(60), UIAdapter.shared.transferHeight(290)))
        self.view.addSubview(self.dailyDetail!)
        self.dailyDetail!.alpha = 0
        self.dailyDetail!.hidden = true
    }
    
    func setCalenderBackground(){
        calenderBackground = UIImageView(frame: CGRectMake(UIAdapter.shared.transferWidth(30) , UIAdapter.shared.transferHeight(100), self.view.frame.width - UIAdapter.shared.transferWidth(60), UIAdapter.shared.transferHeight(290)))
        let path = NSBundle.mainBundle().pathForResource("dailyBackground", ofType: "png")
        calenderBackground!.image = UIImage(contentsOfFile: path!)
        self.view.addSubview(self.calenderBackground!)
    }
    
    func setCalenderActivitiesReview(){
        
        self.reviewTableSource = ReviewTableSource()
        self.reviewTableSource!._selectedCell = self.goUserSetting
        
        self.reviewTable = UITableView(frame: CGRect(x: UIAdapter.shared.transferWidth(50) , y: 10, width: self.view.frame.size.width - UIAdapter.shared.transferWidth(100) , height: UIAdapter.shared.transferHeight(200)))
        self.reviewTable!.dataSource = self.reviewTableSource!
        self.reviewTable!.scrollEnabled = false
        self.reviewTable!.delegate = self.reviewTableSource!
        self.reviewTable!.showsVerticalScrollIndicator = false
        self.reviewTable!.backgroundColor = UIColor.clearColor()
        self.reviewTable!.separatorStyle = UITableViewCellSeparatorStyle.None
        self.reviewTable!.pagingEnabled = true
        self.view!.addSubview(reviewTable!)
    }
    
    func setCalenderView(){
         self.calendar = CalendarView(frame: CGRectMake(0, UIAdapter.shared.transferHeight(100)  , self.view.frame.size.width, self.view.frame.size.height - 64 - UIAdapter.shared.transferHeight(80) ))
         self.view.addSubview(self.calendar!)
        self.calendar!.cellSelectedBlock = self.dailySelected
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    func PushNewController(vc : UIViewController){
       self.navigationController!.pushViewController(vc, animated: true)
    }
    
    func ChooseTab(selectIndex : Int){
       self.tabBarController!.selectedIndex =  selectIndex
    }

    
    func dailySelected( activities : NSArray){
        
        UIView.animateWithDuration(0.5, animations: {
            self.calenderBackground!.frame = CGRectMake(UIAdapter.shared.transferWidth(40), UIAdapter.shared.transferHeight(100), self.view.frame.width - UIAdapter.shared.transferWidth(80), UIAdapter.shared.transferHeight(200))
                self.dailyDetail!.hidden = false
                self.calendar!.hidden = true
            }) { (success) in
               
                UIView.animateWithDuration(0.7, animations: {
                    
                    self.dailyDetail!.alpha = 1
                })
        }
        
    }
    
    func dailyDeSelected( activities : NSArray){
        
        UIView.animateWithDuration(0.5, animations: {
            self.calenderBackground = UIImageView(frame: CGRectMake(UIAdapter.shared.transferWidth(30) , UIAdapter.shared.transferHeight(100), self.view.frame.width - UIAdapter.shared.transferWidth(60), UIAdapter.shared.transferHeight(290)))
            self.dailyDetail!.hidden = true
            self.calendar!.hidden = false
        }) { (success) in
            
            UIView.animateWithDuration(0.7, animations: {
               
                self.dailyDetail!.alpha = 0
            })
           
        }

    }
    
    func goUserSetting(){
        let userSetting = UserSetting(nibName: nil, bundle: nil)
        self.navigationController?.pushViewController(userSetting, animated: false)
    }

    
//    override func viewDidDisappear(animated: Bool) {
//        super.viewDidDisappear(animated)
//        self.reviewTable = nil
//        self.calendar!.collectionView = nil
//        self.reviewTableSource = nil
//        self.calendar = nil
//        self.sign = nil
//        self.calenderBackground!.removeFromSuperview()
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
