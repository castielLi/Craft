//
//  ChatRoom.swift
//  Craft
//
//  Created by castiel on 16/2/4.
//  Copyright © 2016年 castiel. All rights reserved.
//

import UIKit

class ChatRoom: ViewControllerBase , UITextViewDelegate ,RCIMClientReceiveMessageDelegate{

    
    var data: [ChatMessage] = [ChatMessage]()
    
    var soundPlay :PlaySound?
    
    var backgroundImage : UIImageView?
    var selectDialog : UIImageView?
    weak var sign : SignUp?
    
    // chat detail
    var chatDetailView : UIImageView?
    var enterText : UITextView?
    var detailTable : UITableView?
    
    
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

    
    //conversation List 
    var conversationList : NSArray?
    var selectedIndex : Int?
    
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        soundPlay = PlaySound.sharedData()
        selectedIndex = 1
        RCIMClient.sharedRCIMClient().setReceiveMessageDelegate(self, object: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let unreadCount = RCIMClient.sharedRCIMClient().getTotalUnreadCount()
        let chatButton = ChatNavigationView(frame: CGRect(x: 0, y: 0, width: UIAdapter.shared.transferWidth(30) + 5, height: UIAdapter.shared.transferHeight(12) + 20) )
        chatButton.chat!.setBackgroundImage(UIImage(named: "friend"), forState: UIControlState.Normal)
        chatButton.count!.text = "\(unreadCount)"

        
        let rightBarButton = UIBarButtonItem(customView: chatButton)
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
        insertTestData()
        setDialog()
        setChatTabButtons()
        setChatlistView()
        setChatDetailView()
    }
    
    func setDialog(){
        self.selectDialog = UIImageView(frame: CGRect(x: self.view.frame.width - UIAdapter.shared.transferWidth(290)  , y: UIAdapter.shared.transferHeight(15), width: UIAdapter.shared.transferWidth(290), height: UIAdapter.shared.transferHeight(370)))
        self.selectDialog!.userInteractionEnabled = true
        let path = NSBundle.mainBundle().pathForResource("chatBackground", ofType: "png")
        self.selectDialog!.image = UIImage(contentsOfFile: path!)
        self.view.addSubview(self.selectDialog!)
    }
    
    func setChatTabButtons(){
        chatlist = UIButton()
        chatlist!.tag = 1
        chatlist!.setBackgroundImage(UIImage(named: "chatlist"), forState: UIControlState.Normal)
        chatlist!.addTarget(self, action: "chatTabButtonClick:", forControlEvents: UIControlEvents.TouchUpInside)
        self.selectDialog!.addSubview(chatlist!)
        
        self.chatlist!.mas_makeConstraints{ make in
           make.top.equalTo()(self.selectDialog!.mas_top).with().offset()(UIAdapter.shared.transferHeight(3))
           make.left.equalTo()(self.selectDialog!.mas_left).with().offset()(UIAdapter.shared.transferWidth(3))
           make.width.equalTo()(UIAdapter.shared.transferWidth(72))
           make.height.equalTo()(UIAdapter.shared.transferHeight(38))
        }
        
        friend = UIButton()
        friend!.tag = 2
        friend!.addTarget(self, action: "chatTabButtonClick:", forControlEvents: UIControlEvents.TouchUpInside)
        friend!.setBackgroundImage(UIImage(named: "contact"), forState: UIControlState.Normal)
        self.selectDialog!.addSubview(friend!)
        
        self.friend!.mas_makeConstraints{ make in
            make.top.equalTo()(self.selectDialog!.mas_top).with().offset()(UIAdapter.shared.transferHeight(3))
            make.left.equalTo()(self.chatlist!.mas_right)
            make.width.equalTo()(UIAdapter.shared.transferWidth(72))
            make.height.equalTo()(UIAdapter.shared.transferHeight(38))
        }
        
        union = UIButton()
        union!.addTarget(self, action: "chatTabButtonClick:", forControlEvents: UIControlEvents.TouchUpInside)
        union!.setBackgroundImage(UIImage(named: "union"), forState: UIControlState.Normal)
        self.selectDialog!.addSubview(union!)
        
        self.union!.mas_makeConstraints{ make in
            make.top.equalTo()(self.selectDialog!.mas_top).with().offset()(UIAdapter.shared.transferHeight(3))
            make.left.equalTo()(self.friend!.mas_right)
            make.width.equalTo()(UIAdapter.shared.transferWidth(72))
            make.height.equalTo()(UIAdapter.shared.transferHeight(38))
        }
        
        news = UIButton()
        news!.addTarget(self, action: "chatTabButtonClick:", forControlEvents: UIControlEvents.TouchUpInside)
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
        
        self.conversationList = RCIMHelper.RetrunConversationList()
        
        print(conversationList)
        
        chatListView = UITableView(frame: CGRect(x: self.view.frame.width - UIAdapter.shared.transferWidth(301)  , y: UIAdapter.shared.transferHeight(49), width: UIAdapter.shared.transferWidth(254), height: UIAdapter.shared.transferHeight(277)))
        chatListView!.backgroundColor = UIColor.clearColor()
        chatListView!.delegate = self
        chatListView!.dataSource = self
        chatListView!.tag = 1
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
        let path = NSBundle.mainBundle().pathForResource("chatDetailBackground", ofType: "png")
        chatDetailView!.image = UIImage(contentsOfFile: path!)
        self.view.addSubview(chatDetailView!)
        
        self.detailTable = UITableView(frame: CGRectMake( -UIAdapter.shared.transferWidth(210) , UIAdapter.shared.transferHeight(53)  , UIAdapter.shared.transferWidth(210), UIAdapter.shared.transferHeight(263)))
        self.detailTable?.delegate = self
        self.detailTable?.dataSource = self

        self.detailTable?.registerClass(ChatTextCell.self, forCellReuseIdentifier: "textMessageCell")
        self.detailTable?.registerClass(ChatVoiceCell.self, forCellReuseIdentifier: "voiceMessageCell")
        self.detailTable?.separatorStyle = .None
        self.detailTable!.tag = 2
        self.detailTable!.backgroundColor = UIColor.clearColor()
        self.view!.addSubview(self.detailTable!)
        
        enterText = UITextView()
        enterText!.textColor = UIColor.whiteColor()
        enterText!.font = UIFont.systemFontOfSize(15)
        enterText!.backgroundColor = UIColor.clearColor()
        enterText!.returnKeyType = UIReturnKeyType.Send
        enterText!.delegate = self
        self.view!.addSubview(enterText!)
        
        self.enterText!.mas_makeConstraints{ make in
           make.bottom.equalTo()(self.chatDetailView!.mas_bottom).with().offset()(UIAdapter.shared.transferHeight(-10))
           make.left.equalTo()(self.chatDetailView!.mas_left).with().offset()(UIAdapter.shared.transferWidth(13))
           make.right.equalTo()(self.chatDetailView!.mas_left).with().offset()(UIAdapter.shared.transferWidth(175))
           make.height.equalTo()(UIAdapter.shared.transferHeight(15))
        }
    }
    
    
    func chatTabButtonClick(sender : UIButton){
        self.selectedIndex = sender.tag
        self.chatListView?.reloadData()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n"){
            
            let message = RCTextMessage(content: textView.text)
            message.extra = "{\"hello\":\"helloworld\"}"
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
    
    private func insertTestData() {
        let message1 = ChatTextMessage(ownerType: .Mine, messageType: .Text, portrait: UIImage(contentsOfFile: NSBundle.mainBundle().pathForResource("10", ofType: "jpeg")!)!)
        message1.text = "This is a long text for testing attributedText, here i will insert some emojis : 🙂😎😚😶😝. Is this will be correct?"
        let message2 = ChatTextMessage(ownerType: .Other, messageType: .Text, portrait: UIImage(contentsOfFile: NSBundle.mainBundle().pathForResource("10", ofType: "jpeg")!)!)
        message2.text = "This is another long text for testing attributedText, here i will insert some emojis : 🙂😎😚😶😝. Is this will be correct?"
        let message3 = ChatVoiceMessage(ownerType: .Mine, messageType: .Voice, portrait: UIImage(contentsOfFile: NSBundle.mainBundle().pathForResource("10", ofType: "jpeg")!)!, voiceSecs: 5)
        let message4 = ChatVoiceMessage(ownerType: .Other, messageType: .Voice, portrait: UIImage(contentsOfFile: NSBundle.mainBundle().pathForResource("10", ofType: "jpeg")!)!, voiceSecs: 45)
        let message5 = ChatVoiceMessage(ownerType: .Mine, messageType: .Voice, portrait: UIImage(contentsOfFile: NSBundle.mainBundle().pathForResource("10", ofType: "jpeg")!)!, voiceSecs: 100)
        let message6 = ChatVoiceMessage(ownerType: .Other, messageType: .Voice, portrait: UIImage(contentsOfFile: NSBundle.mainBundle().pathForResource("10", ofType: "jpeg")!)!, voiceSecs: 60)
        let message7 = ChatVoiceMessage(ownerType: .Other, messageType: .Voice, portrait: UIImage(contentsOfFile: NSBundle.mainBundle().pathForResource("10", ofType: "jpeg")!)!, voiceSecs: 0)
        self.data.append(message1)
        self.data.append(message2)
        self.data.append(message3)
        self.data.append(message4)
        self.data.append(message5)
        self.data.append(message6)
        self.data.append(message1)
        self.data.append(message2)
        self.data.append(message7)
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
