//
//  ChatRoom.swift
//  Craft
//
//  Created by castiel on 16/2/4.
//  Copyright © 2016年 castiel. All rights reserved.
//

import UIKit

class ChatRoom: ViewControllerBase , UITextViewDelegate ,RCIMClientReceiveMessageDelegate{

    static let searchInfoInFriendList = "Select userId,userName,IconUrl, battleAccount,markName FROM FriendList where userId=?"
    
    static let getCurrentUserId = "Select userId FROM Profile"
    
    static let searchInfoInGroupList = "Select groupId,groupName,groupIntro,groupCode FROM GroupList where groupId=?"
    
    var currentUserId : String?
    var data: NSMutableArray?
    var soundPlay :PlaySound?
    var backgroundImage : UIImageView?
    var selectDialog : UIImageView?
    weak var sign : SignUp?
    
    // chat detail
    var chatDetailView : UIImageView?
//    var enterText : UITextView?
    var detailTable : UITableView?
    var enterForm : EnterForm?
    
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
    
    // RT Start
    // UITextView for chat.
    var textViewInitialHeight: CGFloat = 0
    /// Message list for chat.
    var chatContentsList: [String] = [String]()
    var rtAudio = RTAudio.sharedInstance()
    var chatType: RCConversationType?
    var targetId: String?
    
    
    var dHeight : CGFloat?
    var firstTimeEnter : Bool = true;
    var chatListArray : NSMutableArray?
    var friendListArray : NSMutableArray?
    var groupList : NSMutableArray?
    var _fmdbHelper : FMDBHelper?
    
    
    var searchTextfield : UITextField?
    var addButton : UIButton?
    var createGroupButton : UIButton?
    var searchButton : UIButton?
    
    
    var dataChannels: [Dictionary<String, AnyObject>] = [
        ["title": "世界频道", "targetId": "1", "backgroundImage": UIImage(named: "channel_world")!,"type":"chatroom"],
        ["title": "联盟频道", "targetId": "2", "backgroundImage": UIImage(named: "channel_alliance")!,"type":"chatroom"],
        ["title": "部落频道", "targetId": "3", "backgroundImage": UIImage(named: "channel_horde")!,"type":"chatroom"],
        ["title": "副本频道", "targetId": "4", "backgroundImage": UIImage(named: "channel_raid")!,"type":"chatroom"],
        ["title": "战场、竞技场频道", "targetId": "5", "backgroundImage": UIImage(named: "channel_competition")!,"type":"chatroom"],
        ["title": "休闲频道", "targetId": "6", "backgroundImage": UIImage(named: "channel_others_1")!,"type":"chatroom"],
        ["title": "其他频道", "targetId": "7", "backgroundImage": UIImage(named: "channel_others_2")!,"type":"chatroom"],
        ["title": "战友团频道", "targetId": "8", "backgroundImage": UIImage(named: "channel_teammates")!,"type":"chatroom"],
        ["title": "团队频道", "targetId": "9", "backgroundImage": UIImage(named: "channel_night")!,"type":"chatroom"],
    ]
    
    // RT end
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        soundPlay = PlaySound.sharedData()
        selectedIndex = 1
        RCIMClient.sharedRCIMClient().setReceiveMessageDelegate(self, object: nil)
        self.data = NSMutableArray()
        _fmdbHelper = FMDBHelper.sharedData() as! FMDBHelper
        chatListArray = NSMutableArray()
        friendListArray = NSMutableArray()
        groupList = NSMutableArray()
        
        currentUserId = (_fmdbHelper?.DatabaseQueryWithParameters(["userId"], query: ChatRoom.getCurrentUserId, values: nil) as! NSDictionary).valueForKey("userId") as! String
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let unreadCount = RCIMClient.sharedRCIMClient().getUnreadCount([1])
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
        
        
        //初始化聊天记录表数据
        self.initDataForChatList()
        
    }
    
    
    func initDataForChatList(){
        self.conversationList = RCIMHelper.RetrunConversationList()
        print(conversationList)
        self.showProgress()
        
        self.chatListArray = self.getChatListInfoByRCMArray(self.conversationList!)
        self.friendListArray = ChatHelper.getAllFriend()
        self.groupList = ChatHelper.getAllGroup()
        
        for item in self.groupList!{
            self.dataChannels.append(["title": item.valueForKey("groupName") as! String, "targetId": item.valueForKey("groupId") as! String, "backgroundImage": UIImage(named: "channel_competition")!,"type":"group"])
        }
        
        self.closeProgress()
        chatListView!.delegate = self
        chatListView!.dataSource = self
        chatListView!.reloadData()
        
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
        setEnterForm()
//        attachVoiceButton()
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
        union!.tag = 3
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

        chatListView = UITableView(frame: CGRect(x: self.view.frame.width - UIAdapter.shared.transferWidth(301)  , y: UIAdapter.shared.transferHeight(49), width: UIAdapter.shared.transferWidth(254), height: UIAdapter.shared.transferHeight(277)))
        chatListView!.backgroundColor = UIColor.clearColor()

        chatListView!.tag = 11
        chatListView!.showsVerticalScrollIndicator = false
        chatListView!.showsHorizontalScrollIndicator = false
        chatListView!.separatorStyle = UITableViewCellSeparatorStyle.None
        self.selectDialog!.addSubview(chatListView!)
        
        self.searchTextfield = UITextField(frame: CGRect(x: self.view.frame.width - UIAdapter.shared.transferWidth(301), y: UIAdapter.shared.transferHeight(49 + 291), width: UIAdapter.shared.transferWidth(227), height: UIAdapter.shared.transferHeight(16)))
        self.searchTextfield!.backgroundColor = UIColor.clearColor()
        self.searchTextfield!.font = UIFont(name: "KaiTi", size: UIAdapter.shared.transferHeight(16))
        self.searchTextfield!.textColor = Resources.Color.dailyColor
        self.selectDialog!.addSubview(self.searchTextfield!)
        
        self.searchButton = UIButton(frame: CGRect(x: self.view.frame.width - UIAdapter.shared.transferWidth(301) + UIAdapter.shared.transferWidth(227), y: UIAdapter.shared.transferHeight(49 + 291), width: UIAdapter.shared.transferWidth(27), height: UIAdapter.shared.transferHeight(16)))
        self.searchButton!.setImage(UIImage(named: "search"), forState: UIControlState.Normal)
        self.searchButton!.addTarget(self, action: "chatBottomSearchClick:", forControlEvents: UIControlEvents.TouchUpInside)
        self.selectDialog!.addSubview(self.searchButton!)
        
        self.addButton = UIButton(frame: CGRect(x: self.view.frame.width - UIAdapter.shared.transferWidth(301) + UIAdapter.shared.transferWidth(227), y: UIAdapter.shared.transferHeight(49 + 291), width: UIAdapter.shared.transferWidth(35), height: UIAdapter.shared.transferHeight(16)))
        self.addButton!.setImage(UIImage(named: "addfriend"), forState: UIControlState.Normal)
        self.addButton!.addTarget(self, action: "chatBottomAddClick:", forControlEvents: UIControlEvents.TouchUpInside)
        self.selectDialog!.addSubview(self.addButton!)
        self.addButton!.hidden = true
        
        self.createGroupButton = UIButton(frame: CGRect(x: self.view.frame.width - UIAdapter.shared.transferWidth(301) , y: UIAdapter.shared.transferHeight(49 + 291), width: UIAdapter.shared.transferWidth(35), height: UIAdapter.shared.transferHeight(16)))
        self.createGroupButton!.setImage(UIImage(named: "addgroup"), forState: UIControlState.Normal)
        self.selectDialog!.addSubview(self.createGroupButton!)
        self.createGroupButton!.addTarget(self, action: "chatBottomCreateClick:", forControlEvents: UIControlEvents.TouchUpInside)
        self.createGroupButton!.hidden = true
    }
    
    // init chat detail
    func setChatDetailView(){
        print("begin to build detail table")
       chatDetailView = UIImageView(frame: CGRect(x: UIAdapter.shared.transferWidth(-235)  , y: UIAdapter.shared.transferHeight(25), width: UIAdapter.shared.transferWidth(235), height: UIAdapter.shared.transferHeight(320)))
        chatDetailView!.layer.cornerRadius = 3
        chatDetailView!.layer.masksToBounds = true
        let path = NSBundle.mainBundle().pathForResource("chatDetailBackground", ofType: "png")
        chatDetailView!.image = UIImage(contentsOfFile: path!)
        self.view.addSubview(chatDetailView!)
        
           }
    
    func setDetailTable(){
        self.detailTable = UITableView(frame: CGRectMake( UIAdapter.shared.transferWidth(10) , UIAdapter.shared.transferHeight(53)  , UIAdapter.shared.transferWidth(210), UIAdapter.shared.transferHeight(263)))
        
        self.detailTable!.registerClass(ChatTextCell.self, forCellReuseIdentifier: "textMessageCell")
        self.detailTable!.registerClass(ChatVoiceCell.self, forCellReuseIdentifier: "voiceMessageCell")
        self.detailTable!.delegate = self
        self.detailTable!.dataSource = self
        self.detailTable!.separatorStyle = .None
        self.detailTable!.tag = 12
        self.detailTable!.backgroundColor = UIColor.clearColor()
        self.view!.addSubview(self.detailTable!)
        self.tableScrollToBottom()

    }
    
    func setEnterForm(){
        
        enterForm = EnterForm(frame: CGRect(x: UIAdapter.shared.transferWidth(-215)  , y: UIAdapter.shared.transferHeight(25 + 290), width: UIAdapter.shared.transferWidth(212), height: UIAdapter.shared.transferHeight(23)))
        
        self.view.addSubview(enterForm!)
        
        self.enterForm!.enterTextView!.delegate = self
        self.textViewInitialHeight = self.enterForm!.enterTextView!.frame.height
        
        self.enterForm!.switchButton!.addTarget(self, action: "switchClick:", forControlEvents: UIControlEvents.TouchUpInside)
        self.enterForm!.sendButton?.addTarget(self, action: #selector(ChatRoom.tapSend(_:)), forControlEvents: .TouchUpInside)
        
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(ChatRoom.recordVoice(_:)))
        self.enterForm!.soundButton!.addGestureRecognizer(longGesture)

    }
    
    func switchClick(sender : UIButton){
        if self.enterForm!.showEnterTextfield{
            self.enterForm!.switchButton?.setBackgroundImage(UIImage(named: "keyborad"), forState: UIControlState.Normal)
            self.enterForm!.sendButton!.hidden = true
            self.enterForm!.enterTextView!.hidden = true
            self.enterForm!.soundButton!.hidden = false
            self.enterForm!.enterTextView!.text = ""
            changeEnterFormLayout()
       
        }else{
            self.enterForm!.switchButton?.setBackgroundImage(UIImage(named: "switchSound"), forState: UIControlState.Normal)
            self.enterForm!.sendButton!.hidden = false
            self.enterForm!.enterTextView!.hidden = false
            self.enterForm!.soundButton!.hidden = true
        }
        self.enterForm!.showEnterTextfield = !self.enterForm!.showEnterTextfield
    }
    
    func tapSend(sender: UIButton) {
       
        
        self.sendText()
        
        
    }
    
    func chatTabButtonClick(sender : UIButton){
        self.selectedIndex = sender.tag
        self.chatListView?.reloadData()
        changeBottomOpreatorView()
        
    }
    
    func changeBottomOpreatorView(){
        if(selectedIndex == 1){
            self.addButton!.hidden = true
            self.createGroupButton!.hidden = true
            self.searchTextfield!.frame = CGRect(x: self.view.frame.width - UIAdapter.shared.transferWidth(301), y: UIAdapter.shared.transferHeight(49 + 291), width: UIAdapter.shared.transferWidth(227), height: UIAdapter.shared.transferHeight(16))
            self.searchButton!.frame = CGRect(x: self.view.frame.width - UIAdapter.shared.transferWidth(301) + UIAdapter.shared.transferWidth(227), y: UIAdapter.shared.transferHeight(49 + 291), width: UIAdapter.shared.transferWidth(27), height: UIAdapter.shared.transferHeight(16))
        }else if (selectedIndex == 2){
            self.addButton!.hidden = false
            
            self.createGroupButton!.hidden = true
            self.searchTextfield!.frame = CGRect(x: self.view.frame.width - UIAdapter.shared.transferWidth(301), y: UIAdapter.shared.transferHeight(49 + 291), width: UIAdapter.shared.transferWidth(227 - 35), height: UIAdapter.shared.transferHeight(16))
            self.searchButton!.frame = CGRect(x: self.view.frame.width - UIAdapter.shared.transferWidth(301) + UIAdapter.shared.transferWidth(227 - 35), y: UIAdapter.shared.transferHeight(49 + 291), width: UIAdapter.shared.transferWidth(27), height: UIAdapter.shared.transferHeight(16))
            self.addButton!.frame = CGRect(x: self.view.frame.width - UIAdapter.shared.transferWidth(301) + UIAdapter.shared.transferWidth(227 - 35 + 27), y: UIAdapter.shared.transferHeight(49 + 291), width: UIAdapter.shared.transferWidth(35), height: UIAdapter.shared.transferHeight(16))
            
        }else{
            self.addButton!.hidden = false
            self.addButton!.setBackgroundImage(UIImage(named: "addgroup"), forState: UIControlState.Normal)
            self.createGroupButton!.hidden = false
            self.searchTextfield!.frame = CGRect(x: self.view.frame.width - UIAdapter.shared.transferWidth(301 + 32), y: UIAdapter.shared.transferHeight(49 + 291), width: UIAdapter.shared.transferWidth(227 - 35), height: UIAdapter.shared.transferHeight(16))
            self.searchButton!.frame = CGRect(x: self.view.frame.width - UIAdapter.shared.transferWidth(301) + UIAdapter.shared.transferWidth(227 - 35), y: UIAdapter.shared.transferHeight(49 + 291), width: UIAdapter.shared.transferWidth(27), height: UIAdapter.shared.transferHeight(16))
            self.addButton!.frame = CGRect(x: self.view.frame.width - UIAdapter.shared.transferWidth(301) + UIAdapter.shared.transferWidth(227 - 35 + 27), y: UIAdapter.shared.transferHeight(49 + 291), width: UIAdapter.shared.transferWidth(35), height: UIAdapter.shared.transferHeight(16))
        }

    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    private func sendText() {
        guard self.targetId != nil else {
            print("unexpectedly met nil targetId")
            return
        }
        guard self.chatType != nil else {
            print("unexpectedly met nil chattype")
            return
        }
        
        
        let message = RCTextMessage(content: self.enterForm!.enterTextView!.text)
        let model = ChatMessageModel()
        
        var cType = "private"
        
        if self.chatType! == RCConversationType.ConversationType_CHATROOM {
            cType = "chatroom"
        }
        if self.chatType! == RCConversationType.ConversationType_GROUP {
            cType = "group"
        }
        if self.chatType! == RCConversationType.ConversationType_PRIVATE {
            cType = "private"
        }
        
        RCIMClient.sharedRCIMClient().sendMessage(self.chatType!, targetId: self.targetId!, content: message, pushContent: nil, success: { (messageId) in
            print("发送成功")

            
            dispatch_async(dispatch_get_main_queue(), {
                let txtMsg = ChatTextMessage(ownerType: .Mine, messageType: .Text, portrait: UIImage(contentsOfFile: NSBundle.mainBundle().pathForResource("10", ofType: "jpeg")!)!)
                txtMsg.text = self.enterForm!.enterTextView!.text
                self.data!.addObject(txtMsg)
                self.detailTable!.reloadData()
                self.enterForm!.enterTextView!.resignFirstResponder()
                self.enterForm!.enterTextView!.text = ""
                self.tableScrollToBottom()
            });

                      
            }, error: { (error, messageId) in
                print("发送失败")
                self.enterForm!.enterTextView!.resignFirstResponder()
                self.enterForm!.enterTextView!.text = ""
        })
        
        
        self.enterForm!.frame = CGRect(x: self.enterForm!.frame.origin.x  , y: UIAdapter.shared.transferHeight(25 + 290), width: UIAdapter.shared.transferWidth(212), height: UIAdapter.shared.transferHeight(23))
        self.enterForm!.enterTextView!.frame = CGRect(x: self.enterForm!.enterTextView!.frame.origin.x, y: self.enterForm!.enterTextView!.frame.origin.y, width: self.enterForm!.enterTextView!.frame.width, height: UIAdapter.shared.transferHeight(35))
        
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n"){
            self.sendText()
            
        }
        return true
    }
    
    // RT Start
    
    func tableScrollToBottom() {
        if self.data!.count > 0 {
            guard (self.data!.count - 1) != 0 else { return }
            

            
            self.detailTable?.scrollToRowAtIndexPath(NSIndexPath(forRow: self.data!.count - 1, inSection: 0), atScrollPosition: .Top, animated: true)
            

        }
    }
    
    func textViewDidChange(textView: UITextView) {
        // Caculate the size which best fits the specified size.
        // This height is just the height of textView which best fits its content.
        var height = textView.sizeThatFits(CGSizeMake(self.enterForm!.enterTextView!.frame
            .width, CGFloat(MAXFLOAT))).height
        // Compare with the original height, if bigger than original value, use current height, otherwise, use original value.
        height = height > self.textViewInitialHeight ? height : self.textViewInitialHeight
        // Here i set the max height for textView is 80.
        if height <= uiah(40) {
            // Get how much the textView grows at height dimission
            let heightDiff = height - self.enterForm!.enterTextView!.frame.height
            var currentDHeight : CGFloat = 0
            if (dHeight != nil){
             currentDHeight = heightDiff - dHeight!
            }
            UIView.animateWithDuration(0.05, animations: {
                
                
                if !self.firstTimeEnter && currentDHeight>0{
          
                    self.enterForm!.frame = CGRectMake(self.enterForm!.frame.origin.x , self.enterForm!.frame.origin.y - heightDiff, self.enterForm!.frame.width, height + uiah(7))
                    
                    self.enterForm!.setNeedsLayout()

                    self.detailTable?.frame = CGRectMake(self.detailTable!.frame.origin.x, self.detailTable!.frame.origin.y, self.detailTable!.frame.width, self.detailTable!.frame.height - heightDiff)
                    
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
    
    private func changeEnterFormLayout(){
        self.enterForm!.frame = (frame: CGRect(x: self.enterForm!.frame.origin.x  , y: UIAdapter.shared.transferHeight(25 + 290), width: UIAdapter.shared.transferWidth(212), height: UIAdapter.shared.transferHeight(23)))
        
//        self.enterForm!.setNeedsLayout()
        
        self.detailTable!.frame = CGRectMake( self.detailTable!.frame.origin.x , UIAdapter.shared.transferHeight(53)  , UIAdapter.shared.transferWidth(210), UIAdapter.shared.transferHeight(263))
    }
    

    
    func recordVoice(recognizer: UILongPressGestureRecognizer) {
        guard self.targetId != nil else {
            print("unexpectedly met nil targetId")
            return
        }
        guard self.chatType != nil else {
            print("unexpectedly met nil chattype")
            return
        }
        
        
        switch recognizer.state {
        case .Began:
            print("recording...")
            self.rtAudio.startRecording("tmp.wav")
            break
        case .Changed:
            break
        case .Ended:
            print("recorded.")
            self.rtAudio.stopRecording()
            let message = RCVoiceMessage(audio: self.rtAudio.soundData, duration: self.rtAudio.recordedDuration!)
            
            let model = ChatMessageModel()
            var cType = "private"
            if self.chatType! == RCConversationType.ConversationType_CHATROOM {
                cType = "chatroom"
            }
            if self.chatType! == RCConversationType.ConversationType_GROUP {
                cType = "group"
            }
            if self.chatType! == RCConversationType.ConversationType_PRIVATE {
                cType = "private"
            }
            
            model.type = cType
            model.userName = "test"
            model.userId = "1"
            
            message.extra = model.currentModelToJsonString()
            RCIMClient.sharedRCIMClient().sendMessage(self.chatType!, targetId: self.targetId!, content: message, pushContent: nil, success: {
                mesageId in
                print("sent successfully")
                
                let voiceMsg = ChatVoiceMessage(ownerType: .Mine, messageType: .Voice, portrait: UIImage(contentsOfFile: NSBundle.mainBundle().pathForResource("10", ofType: "jpeg")!)!, voiceSecs: self.rtAudio.recordedDuration!)
                
                var path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] + "/tmp.wav"
                let data = NSData(contentsOfFile: path)
                
                voiceMsg.voiceData = data!
                self.data!.addObject(voiceMsg)
                self.detailTable!.reloadData()
                self.tableScrollToBottom()
                }, error: {
                    (error, messageId) in
                    print("sent failed")
            })
            break
        default: break
        }
    }
    
    // RT End
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
