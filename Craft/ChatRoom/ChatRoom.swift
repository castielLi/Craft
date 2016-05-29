//
//  ChatRoom.swift
//  Craft
//
//  Created by castiel on 16/2/4.
//  Copyright © 2016年 castiel. All rights reserved.
//

import UIKit

class ChatRoom: ViewControllerBase {

    var soundPlay :PlaySound?
    
    var backgroundImage : UIImageView?
    var selectDialog : UIImageView?
    weak var sign : SignUp?
    
    // chat detail
    var chatDetailView : UIImageView?
    var enterText : UITextView?
    
    // chat list
    var chatListView : UITableView?
    var chatlist : UIButton?
    var friend : UIButton?
    var union : UIButton?
    var news : UIButton?
    var searchText : UITextField?
    
    var showTimerSwipe : UISwipeGestureRecognizer?
    var showActivitySwipe : UISwipeGestureRecognizer?
    var showDailySwipe : UISwipeGestureRecognizer?
    var tapblank : UITapGestureRecognizer?
    var showChatList : UISwipeGestureRecognizer?
    var chatListDoubleTap : UITapGestureRecognizer?
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        soundPlay = PlaySound.sharedData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let menuButton = UIButton(frame: CGRect(x: 0, y: 0, width: UIAdapter.shared.transferWidth(30), height: UIAdapter.shared.transferHeight(12)) )
        menuButton.setBackgroundImage(UIImage(named: "friend"), forState: UIControlState.Normal)
        
        let rightBarButton = UIBarButtonItem(customView: menuButton)
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        let calendarButton = UIButton(frame: CGRect(x: 0, y: 0, width: UIAdapter.shared.transferWidth(30), height: UIAdapter.shared.transferHeight(12)) )
        calendarButton.setBackgroundImage(UIImage(named: "daily"), forState: UIControlState.Normal)
        
        calendarButton.addTarget(self, action: "calenderClick:", forControlEvents: UIControlEvents.TouchUpInside)
        
        
        let leftBarButton = UIBarButtonItem(customView: calendarButton)
        self.navigationItem.leftBarButtonItem = leftBarButton
        
        
        let activityButton = UIButton(frame: CGRect(x: 0, y: 0, width: UIAdapter.shared.transferWidth(30), height: UIAdapter.shared.transferHeight(18)) )
        activityButton.setBackgroundImage(UIImage(named: "activity"), forState: UIControlState.Normal)
        activityButton.addTarget(self, action: "activityClick:", forControlEvents: UIControlEvents.TouchUpInside)
        self.navigationItem.titleView = activityButton
        
        self.registerViewsGesture()
        
        let animation = CASpringAnimation(keyPath: "position.x")
        animation.damping = 12
        animation.stiffness = 100
        animation.mass = 1
        animation.initialVelocity = 0
        animation.duration = animation.settlingDuration
        animation.removedOnCompletion = false
        animation.timingFunction = CAMediaTimingFunction( name: kCAMediaTimingFunctionEaseOut)
        animation.fromValue = self.view.frame.width
        
        self.selectDialog!.layer.addAnimation(animation, forKey: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController!.navigationBar.barStyle = UIBarStyle.BlackTranslucent
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(named: "navigationBackGround"), forBarMetrics: UIBarMetrics.Default)
        
        self.view.backgroundColor = UIColor.clearColor()
        // Do any additional setup after loading the view.
    }
    
    override func initView() {
        setDialog()
        setChatTabButtons()
        setChatlistView()
        setChatDetailView()
    }
    
    func setDialog(){
        self.selectDialog = UIImageView(frame: CGRect(x: self.view.frame.width - UIAdapter.shared.transferWidth(290)  , y: UIAdapter.shared.transferHeight(15), width: UIAdapter.shared.transferWidth(290), height: UIAdapter.shared.transferHeight(370)))
        self.selectDialog!.userInteractionEnabled = true
        self.selectDialog!.image = UIImage(named: "chatBackground")
        self.view.addSubview(self.selectDialog!)
    }
    
    func setChatTabButtons(){
        chatlist = UIButton()
        chatlist!.setBackgroundImage(UIImage(named: "chatlist"), forState: UIControlState.Normal)
        self.selectDialog!.addSubview(chatlist!)
        
        self.chatlist!.mas_makeConstraints{ make in
           make.top.equalTo()(self.selectDialog!.mas_top).with().offset()(UIAdapter.shared.transferHeight(3))
           make.left.equalTo()(self.selectDialog!.mas_left).with().offset()(UIAdapter.shared.transferWidth(3))
           make.width.equalTo()(UIAdapter.shared.transferWidth(72))
           make.height.equalTo()(UIAdapter.shared.transferHeight(38))
        }
        
        friend = UIButton()
        friend!.setBackgroundImage(UIImage(named: "contact"), forState: UIControlState.Normal)
        self.selectDialog!.addSubview(friend!)
        
        self.friend!.mas_makeConstraints{ make in
            make.top.equalTo()(self.selectDialog!.mas_top).with().offset()(UIAdapter.shared.transferHeight(3))
            make.left.equalTo()(self.chatlist!.mas_right)
            make.width.equalTo()(UIAdapter.shared.transferWidth(72))
            make.height.equalTo()(UIAdapter.shared.transferHeight(38))
        }
        
        union = UIButton()
        union!.setBackgroundImage(UIImage(named: "union"), forState: UIControlState.Normal)
        self.selectDialog!.addSubview(union!)
        
        self.union!.mas_makeConstraints{ make in
            make.top.equalTo()(self.selectDialog!.mas_top).with().offset()(UIAdapter.shared.transferHeight(3))
            make.left.equalTo()(self.friend!.mas_right)
            make.width.equalTo()(UIAdapter.shared.transferWidth(72))
            make.height.equalTo()(UIAdapter.shared.transferHeight(38))
        }
        
        news = UIButton()
        news!.setBackgroundImage(UIImage(named: "news"), forState: UIControlState.Normal)
        self.selectDialog!.addSubview(news!)
        
        self.news!.mas_makeConstraints{ make in
            make.top.equalTo()(self.selectDialog!.mas_top).with().offset()(UIAdapter.shared.transferHeight(3))
            make.left.equalTo()(self.union!.mas_right)
            make.width.equalTo()(UIAdapter.shared.transferWidth(72))
            make.height.equalTo()(UIAdapter.shared.transferHeight(38))
        }
    }
    
    // init chat table
    func setChatlistView(){
        chatListView = UITableView(frame: CGRect(x: self.view.frame.width - UIAdapter.shared.transferWidth(301)  , y: UIAdapter.shared.transferHeight(49), width: UIAdapter.shared.transferWidth(254), height: UIAdapter.shared.transferHeight(277)))
        chatListView!.backgroundColor = UIColor.clearColor()
        chatListView!.delegate = self
        chatListView!.dataSource = self
        chatListView!.showsVerticalScrollIndicator = false
        chatListView!.showsHorizontalScrollIndicator = false
        chatListView!.separatorStyle = UITableViewCellSeparatorStyle.None
        self.selectDialog!.addSubview(chatListView!)
    }
    
    // init chat detail
    func setChatDetailView(){
       chatDetailView = UIImageView(frame: CGRect(x: UIAdapter.shared.transferWidth(-235)  , y: UIAdapter.shared.transferHeight(25), width: UIAdapter.shared.transferWidth(235), height: UIAdapter.shared.transferHeight(320)))
        chatDetailView!.layer.cornerRadius = 3
        chatDetailView!.layer.masksToBounds = true
        chatDetailView!.image = UIImage(named: "chatDetailBackground")
        self.view.addSubview(chatDetailView!)
        
        enterText = UITextView()
        enterText!.textColor = UIColor.whiteColor()
        enterText!.font = UIFont.systemFontOfSize(15)
        enterText!.backgroundColor = UIColor.clearColor()
        enterText!.returnKeyType = UIReturnKeyType.Send
        self.view!.addSubview(enterText!)
        
        self.enterText!.mas_makeConstraints{ make in
           make.bottom.equalTo()(self.chatDetailView!.mas_bottom).with().offset()(UIAdapter.shared.transferHeight(-10))
           make.left.equalTo()(self.chatDetailView!.mas_left).with().offset()(UIAdapter.shared.transferWidth(13))
           make.right.equalTo()(self.chatDetailView!.mas_left).with().offset()(UIAdapter.shared.transferWidth(175))
           make.height.equalTo()(UIAdapter.shared.transferHeight(15))
        }
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
