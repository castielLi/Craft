//
//  UserSetting.swift
//  Craft
//
//  Created by castiel on 16/4/19.
//  Copyright © 2016年 castiel. All rights reserved.
//

import UIKit

class UserSetting: ViewControllerBase,UITableViewDelegate,UITableViewDataSource {
    
    var soundPlay :PlaySound?
    var rightMenu : RightMenu?
    var backgroundImage : UIImageView?
    var menuIsOpen : Bool = false
    var table : UITableView?
    var iconImage : UIImageView?
    var changeIcon : UIButton?
    var backButton : UIButton?
    
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
        
        self.backgroundImage!.layer.addAnimation(alphaAnimation, forKey: nil)
        self.iconImage!.layer.addAnimation(alphaAnimation, forKey: nil)
        
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
        self.navigationController?.popViewControllerAnimated(false)
    }



    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = Resources.Color.bloodBackgournd
        self.navigationController!.navigationBar.barStyle = UIBarStyle.BlackTranslucent
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(named: "navigationBackGround"), forBarMetrics: UIBarMetrics.Default)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func initView() {
        setBackground()
        initIcon()
        setRightMenu()
        setTable()
        setBackButton()
    }
    
    func setBackground(){
       self.backgroundImage = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width , height: self.view.frame.height - 64 ))
        self.backgroundImage!.image = UIImage(named: "userSettingBackground")
        self.view.addSubview(self.backgroundImage!)
    }
    
    func initIcon(){
        iconImage = UIImageView()
        iconImage!.image = UIImage(named: "icon")
        iconImage!.layer.cornerRadius = UIAdapter.shared.transferWidth(25)
        iconImage!.layer.masksToBounds = true
        self.view.addSubview(iconImage!)
        
        self.iconImage!.mas_makeConstraints{ make in
           make.top.equalTo()(self.view).with().offset()(UIAdapter.shared.transferHeight(20))
           make.centerX.equalTo()(self.view)
           make.width.equalTo()(UIAdapter.shared.transferWidth(100))
            make.height.equalTo()(UIAdapter.shared.transferWidth(100))
        }
        
        let iconRange = CALayer()
        iconRange.frame = CGRectMake(0, 0, UIAdapter.shared.transferWidth(100), UIAdapter.shared.transferWidth(100))
        iconRange.contents = UIImage(named: "iconWidth")!.CGImage
        self.iconImage!.layer.addSublayer(iconRange)
        
        self.changeIcon = UIButton()
        self.changeIcon!.setTitle("更换头像", forState: UIControlState.Normal)
        self.changeIcon!.setTitleColor(Resources.Color.dailyColor, forState: UIControlState.Normal)
        self.changeIcon!.titleLabel!.font = UIFont(name: "TimesNewRomanPS-BoldMT", size: 17)
        self.changeIcon!.titleLabel!.textAlignment = NSTextAlignment.Center
        self.changeIcon!.backgroundColor = UIColor.clearColor()
        self.view.addSubview(self.changeIcon!)
        
        self.changeIcon!.mas_makeConstraints{ make in
            make.top.equalTo()(self.iconImage!.mas_bottom).with().offset()(UIAdapter.shared.transferHeight(10))
            make.centerX.equalTo()(self.view)
            make.width.equalTo()(UIAdapter.shared.transferWidth(70))
            make.height.equalTo()(UIAdapter.shared.transferHeight(20))
        }
    }
    
    
    func setTable(){
        table = UITableView(frame: CGRect(x: 30, y: UIAdapter.shared.transferWidth(100) + UIAdapter.shared.transferHeight(70)  , width: self.view.frame.width - 60 , height: 50 * 5))
        self.view.addSubview(table!)
        self.table!.delegate = self
        self.table!.dataSource = self
        self.table!.separatorStyle = UITableViewCellSeparatorStyle.None
        self.table!.backgroundColor = UIColor.clearColor()
    }
    
    func setBackButton(){
        backButton = UIButton()
        backButton?.setImage(UIImage(named: "backbutton"), forState: UIControlState.Normal)
        backButton!.addTarget(self, action: "backButtonClick:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(backButton!)
        
        self.backButton!.mas_makeConstraints{ make in
           make.top.equalTo()(self.table!.mas_bottom).with().offset()(UIAdapter.shared.transferHeight(20))
           make.bottom.equalTo()(self.table!.mas_bottom).with().offset()(UIAdapter.shared.transferHeight(47))
           make.centerX.equalTo()(self.view)
           make.width.equalTo()(UIAdapter.shared.transferWidth(100))
        }
    }
    
    func setRightMenu(){
        self.rightMenu = RightMenu(frame: CGRect(x: UIScreen.mainScreen().bounds.width + UIAdapter.shared.transferWidth(50) , y: (UIScreen.mainScreen().bounds.height - UIAdapter.shared.transferHeight(70)) / 2, width: UIAdapter.shared.transferWidth(50), height: UIAdapter.shared.transferHeight(70)))
        self.view.addSubview(self.rightMenu!)
        
        self.rightMenu!.chatRoom?.addTarget(self, action: "chatRoomClick:", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.rightMenu!.setting!.addTarget(self, action: "settingClick:", forControlEvents: UIControlEvents.TouchUpInside)
        
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

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("userSettingCell") as? TableViewBaseCell
        
        if(cell == nil) {
            
            cell = TableViewBaseCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "userSettingCell", cellHeight: UIAdapter.shared.transferHeight(100) , lineColor: Resources.Color.goldenEdge)
            
            cell!.backgroundColor = UIColor.clearColor()
            cell!.textLabel!.font = UIFont(name: "TimesNewRomanPS-BoldMT", size: 15)
            cell!.textLabel?.textColor = Resources.Color.dailyColor
            
        }
        
        
        
        switch indexPath.row {
        case 0:
            cell!.textLabel?.text = "用户名"
            cell!.detailTextLabel!.text = "伊莎贝拉殿下"
        case 1:
            cell!.textLabel?.text = "绑定战网"
            cell!.detailTextLabel!.text = "sanctimony@126.com"
        case 2:
            cell!.textLabel?.text = "绑定手机"
            cell!.detailTextLabel!.text = "15023201329"
        case 3:
            cell!.textLabel?.text = "修改密码"
        case 4:
            cell!.textLabel?.text = "切换阵营"
        default:
            break
        }
        
        cell!.backgroundColor = UIColor.clearColor()
        cell!.selectionStyle = UITableViewCellSelectionStyle.None
        
        cell!.setTopLineHide()
        cell!.setBottomLineHide()
        return cell!
    }
    
    func backButtonClick(sender : UIButton){
        let soundId = soundPlay!.sound.valueForKey(SoundResource.clickEventSound) as! String
        let id = UInt32(soundId)
        AudioServicesPlaySystemSound(id!);
            self.navigationController?.popViewControllerAnimated(false)

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
