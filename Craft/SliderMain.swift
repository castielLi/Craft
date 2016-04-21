//
//  SliderMain.swift
//  Craft
//
//  Created by castiel on 15/11/15.
//  Copyright © 2015年 castiel. All rights reserved.
//

import UIKit

class SliderMain: ViewControllerBase , MainMenuProtocol{

    var calendar : CalendarView?
    var reviewTable : UITableView?
    var reviewTableSource : ReviewTableSource?
    var rightMenu : RightMenu?
    var menuIsOpen : Bool = false
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController!.tabBar.hidden = true
        

        let menuButton = UIButton(frame: CGRect(x: 0, y: 0, width: UIAdapter.shared.transferWidth(40), height: UIAdapter.shared.transferHeight(20)) )
        menuButton.setTitle("Menu", forState: UIControlState.Normal)
        menuButton.titleLabel!.textColor = UIColor.whiteColor()
        menuButton.addTarget(self, action: "MenuClick:", forControlEvents: UIControlEvents.TouchUpInside)
        
        let rightBarButton = UIBarButtonItem(customView: menuButton)
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        let activityButton = UIButton(frame: CGRect(x: 0, y: 0, width: UIAdapter.shared.transferWidth(40), height: UIAdapter.shared.transferHeight(20)) )
        activityButton.setTitle("activity", forState: UIControlState.Normal)
        activityButton.titleLabel!.textColor = UIColor.whiteColor()
        activityButton.addTarget(self, action: "activityClick:", forControlEvents: UIControlEvents.TouchUpInside)
        
        
        let leftBarButton = UIBarButtonItem(customView: activityButton)
        self.navigationItem.leftBarButtonItem = leftBarButton

        
        let alphaAnimation = CABasicAnimation(keyPath: "opacity")
        alphaAnimation.duration = 0.8
        alphaAnimation.fromValue = 0.3
        alphaAnimation.toValue = 1

        self.reviewTable!.layer.addAnimation(alphaAnimation, forKey: nil)
        self.calendar!.layer.addAnimation(alphaAnimation, forKey: nil)
        
    }

    
    func MenuClick(sender : UIButton){
       self.MenuClick()
    }
    
    func activityClick(sender : UIButton){
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
        setCalenderActivitiesReview()
        setCalenderView()
        setRightMenu()
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
        
        self.reviewTable = UITableView(frame: CGRect(x: UIAdapter.shared.transferWidth(20) , y: UIAdapter.shared.transferHeight(30) + 64, width: self.view.frame.size.width - UIAdapter.shared.transferWidth(40) , height: UIAdapter.shared.transferHeight(100)))
        self.reviewTable!.dataSource = self.reviewTableSource!
        self.reviewTable!.delegate = self.reviewTableSource!
        self.reviewTable!.showsVerticalScrollIndicator = false
        self.reviewTable!.backgroundColor = UIColor.clearColor()
        self.reviewTable!.separatorStyle = UITableViewCellSeparatorStyle.None
        self.reviewTable!.pagingEnabled = true
        self.view!.addSubview(reviewTable!)
//        self.reviewTable!.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.6 , 0.6)
//        self.reviewTable!.alpha = 0
    }
    
    
    func setBackGroundImage(){
        self.backGroundImage = UIImageView(frame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.height))
        self.backGroundImage!.image = UIImage(named: "LoginBackGround")
        self.view.addSubview(backGroundImage!)
    }
    
    
    func setCalenderView(){
         self.calendar = CalendarView(frame: CGRectMake(0, UIAdapter.shared.transferHeight(130) + 64, self.view.frame.size.width, UIAdapter.shared.transferHeight(160)))
         self.view.addSubview(self.calendar!)
//         self.calendar!.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.6 , 0.6)          
//         self.calendar!.alpha = 0
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



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
