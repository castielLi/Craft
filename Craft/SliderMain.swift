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
    var rightMenu : RightMenu?
    var menuIsOpen : Bool = false
    var calenderBackground : UIImageView?
    var detailCell : UIView?
    var originCellFrame : CGRect?
    
    var detailCellTap : UITapGestureRecognizer?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        soundPlay = PlaySound.sharedData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController!.tabBar.hidden = true
        

        let menuButton = UIButton(frame: CGRect(x: 0, y: 0, width: UIAdapter.shared.transferWidth(30), height: UIAdapter.shared.transferHeight(12)) )
        menuButton.setBackgroundImage(UIImage(named: "friend"), forState: UIControlState.Normal)
        menuButton.addTarget(self, action: "MenuClick:", forControlEvents: UIControlEvents.TouchUpInside)
        
        let rightBarButton = UIBarButtonItem(customView: menuButton)
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        let dailyButton = UIButton(frame: CGRect(x: 0, y: 0, width: UIAdapter.shared.transferWidth(30), height: UIAdapter.shared.transferHeight(12)) )
        dailyButton.setBackgroundImage(UIImage(named: "daily"), forState: UIControlState.Normal)
       
        
        
        let leftBarButton = UIBarButtonItem(customView: dailyButton)
        self.navigationItem.leftBarButtonItem = leftBarButton
        
        let activityButton = UIButton(frame: CGRect(x: 0, y: 0, width: UIAdapter.shared.transferWidth(30), height: UIAdapter.shared.transferHeight(18)) )
        activityButton.setBackgroundImage(UIImage(named: "activity"), forState: UIControlState.Normal)
        activityButton.addTarget(self, action: "activityClick:", forControlEvents: UIControlEvents.TouchUpInside)
        self.navigationItem.titleView = activityButton


        
        let alphaAnimation = CABasicAnimation(keyPath: "opacity")
        alphaAnimation.duration = 0.8
        alphaAnimation.fromValue = 0.3
        alphaAnimation.toValue = 1

        self.reviewTable!.layer.addAnimation(alphaAnimation, forKey: nil)
        self.calendar!.layer.addAnimation(alphaAnimation, forKey: nil)
        self.calenderBackground!.layer.addAnimation(alphaAnimation,forKey : nil)
        
        let xAnimation = CABasicAnimation(keyPath: "position.x")
        xAnimation.toValue = self.view!.frame.size.width * 2
        xAnimation.fromValue = -self.view!.frame.size.width / 2
        xAnimation.duration = 20
        xAnimation.repeatCount = Float.infinity
        bloodBackGroundImage!.layer.addAnimation(xAnimation, forKey: "position.x")
        
    }

    
    func MenuClick(sender : UIButton){
        let soundId = soundPlay!.sound.valueForKey(SoundResource.clickEventSound) as! String
        let id = UInt32(soundId)
        AudioServicesPlaySystemSound(id!);
       self.MenuClick()
    }
    
    func activityClick(sender : UIButton){
        let soundId = soundPlay!.sound.valueForKey(SoundResource.clickEventSound) as! String
        let id = UInt32(soundId)
        AudioServicesPlaySystemSound(id!);
       self.tabBarController?.selectedIndex = 1
    }
    

    var backGroundImage : UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //透明导航栏
        self.navigationController!.navigationBar.barStyle = UIBarStyle.BlackTranslucent
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(named: "navigationBackGround"), forBarMetrics: UIBarMetrics.Default)
        
        
        let backButton = UIBarButtonItem()
        self.navigationItem.backBarButtonItem = backButton
        self.navigationItem.backBarButtonItem!.title = ""
        
        self.view.backgroundColor = UIColor.whiteColor()
        
    }
    
    override func initView() {
        setBackGroundImage()
        setCalenderBackground()
        setCalenderActivitiesReview()
        setCalenderView()
        setDetailCellView()
        setRightMenu()
    }
    
    func setCalenderBackground(){
        calenderBackground = UIImageView(frame: CGRectMake(UIAdapter.shared.transferWidth(20) , UIAdapter.shared.transferHeight(100), self.view.frame.width - UIAdapter.shared.transferWidth(40), UIAdapter.shared.transferHeight(290)))
        calenderBackground!.image = UIImage(named: "dailyBackground")
        self.view.addSubview(self.calenderBackground!)
        
    }
    
    func setDetailCellView(){
        detailCell = UIView()
        detailCell!.backgroundColor = Resources.Color.goldenEdge
        detailCell!.layer.cornerRadius = 5
        detailCell!.layer.borderWidth = 2
        detailCell!.layer.borderColor = Resources.Color.goldenEdge.CGColor
        detailCell!.layer.masksToBounds = true
        detailCell!.hidden = true
        self.view!.addSubview(detailCell!)
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

    
    func setCalenderActivitiesReview(){
        
        self.reviewTableSource = ReviewTableSource()
        
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
    
    
    func setBackGroundImage(){
        self.backGroundImage = UIImageView(frame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.height))
        self.backGroundImage!.image = UIImage(named: "MainBackGround")
        self.view.addSubview(backGroundImage!)
        
        self.bloodBackGroundImage = UIImageView(frame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.height))
        self.bloodBackGroundImage!.image = UIImage(named: "blood")
        self.view.addSubview(self.bloodBackGroundImage!)
    }
    
    
    func setCalenderView(){
         self.calendar = CalendarView(frame: CGRectMake(0, UIAdapter.shared.transferHeight(100)  , self.view.frame.size.width, self.view.frame.size.height - 64 - UIAdapter.shared.transferHeight(80) ))
         self.view.addSubview(self.calendar!)
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
    
    func MenuClick(){
        if !self.menuIsOpen {

            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.rightMenu!.frame.origin.x = UIScreen.mainScreen().bounds.width - UIAdapter.shared.transferWidth(50) - 5
            })
            
        }else{

            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.rightMenu!.frame.origin.x = UIScreen.mainScreen().bounds.width + UIAdapter.shared.transferWidth(50)
            })
            
        }
        self.menuIsOpen = !self.menuIsOpen
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
