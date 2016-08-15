//
//  MyActivities.swift
//  Craft
//
//  Created by castiel on 16/2/23.
//  Copyright © 2016年 castiel. All rights reserved.
//

import UIKit

class MyActivities: ViewControllerBase ,UIGestureRecognizerDelegate , UITableViewDataSource, UITableViewDelegate,SignUpServiceDelegate{
    
    var service : SignUpService?
    var activityId : String?
    var activitiesView : UIImageView?
    var button : UIButton?
    var blankTap : UITapGestureRecognizer?
    var dataModel : ActivityDetailModel?
    
    
    var playerSelected : Int?
    var applySelected : Int?
    
    var scroll : UIScrollView?
    var table : UITableView?
    
    var raidDropdown : UIButton?
    var raidTitle : UITextView?
    var raidContent : UITextView?
    var activityDetailView : activityDetail?
    var selectedIndex : Int = 2;
    
    var applyList : UIButton?
    var playerList : UIButton?
    var invite : UIButton?
    var buttonListBackground : UIImageView?
    
    
    var playerListSource : NSMutableArray?
    var applylistSource : NSMutableArray?
    
    var soundPlay : PlaySound?
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        soundPlay = PlaySound.sharedData()
        service = SignUpService()
        service!.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let center = NSNotificationCenter.defaultCenter()
        center.addObserver(self,
                           selector: "inviteListDialogDisappear:", name: "dismissAcitivtiesDialogFromDetail", object: nil)
        
        self.navigationController!.setNavigationBarHidden(true, animated: false)

        let animation = CASpringAnimation(keyPath: "position.x")
        animation.damping = 12
        animation.stiffness = 100
        animation.mass = 1
        animation.initialVelocity = 0
        animation.duration = animation.settlingDuration
        animation.removedOnCompletion = false
        animation.timingFunction = CAMediaTimingFunction( name: kCAMediaTimingFunctionEaseOut)
        animation.fromValue = -UIAdapter.shared.transferWidth(150)

        self.activitiesView!.layer.addAnimation(animation, forKey: nil)
        
    }
    
    func inviteListDialogDisappear(sender : NSNotification){
        let swishinId = self.soundPlay!.sound.valueForKey(SoundResource.swishinSound) as! String
        let swishinid = UInt32(swishinId)
        AudioServicesPlaySystemSound(swishinid!);
        
       UIView.animateWithDuration(0.4) {
        self.activitiesView!.frame.origin.x += UIAdapter.shared.transferWidth(300)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.clearColor()
        
             // Do any additional setup after loading the view.
    }
    
    override func initView() {
        setActivitiesView()
        setScroll()
        setActivityDetail()
        setButtonList()
        setRaidMember()
        setTapForBackgroundView()
    }
   
    
    func setTapForBackgroundView(){
         self.blankTap = UITapGestureRecognizer(target: self, action: #selector(MyActivities.BlankSpaceTap(_:)))
         self.blankTap!.numberOfTapsRequired = 1
         self.blankTap!.delegate = self
         self.view.addGestureRecognizer(self.blankTap!)
    }
    
    func BlankSpaceTap(sender : UITapGestureRecognizer){
    
        UIView.animateWithDuration(0.4, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.activitiesView!.frame.origin.x = -UIAdapter.shared.transferWidth(300)
            }) { (success) -> Void in
                if success {
                   self.dismissViewControllerAnimated(false, completion: { () -> Void in
                      NSNotificationCenter.defaultCenter().postNotificationName("dismissAcitivtiesDialog", object: self)
                   })
                    
                }
        }
    }
    
    
    func setScroll(){
        
        self.scroll = UIScrollView(frame: CGRect(x: 0, y: 0, width: UIAdapter.shared.transferWidth(240), height: UIAdapter.shared.transferHeight(300)))
        self.scroll!.showsVerticalScrollIndicator = false
        self.scroll!.showsHorizontalScrollIndicator = false
        self.activitiesView!.addSubview(self.scroll!)
        
        self.scroll!.contentSize = CGSize(width: UIAdapter.shared.transferWidth(240), height: UIAdapter.shared.transferHeight(150) + CGFloat(playerListSource!.count + 1) * CGFloat(50))
        
        
        self.scroll?.mas_makeConstraints{ make in
           make.top.equalTo()(self.activitiesView!.mas_top).with().offset()(UIAdapter.shared.transferHeight(32))
           make.bottom.equalTo()(self.activitiesView!).with().offset()( -UIAdapter.shared.transferHeight(51) )
           make.left.equalTo()(self.activitiesView!).with().offset()(UIAdapter.shared.transferWidth(19))
           make.right.equalTo()(self.activitiesView!).with().offset()(UIAdapter.shared.transferWidth(-19))
        }
    }

    
    
    func setRaidMember(){
           self.table = UITableView(frame: CGRect(x: 0, y: UIAdapter.shared.transferHeight(150), width: UIAdapter.shared.transferWidth(240), height: 500))
           self.table!.backgroundColor = UIColor.clearColor()
           self.table!.scrollEnabled = false
           self.table!.separatorStyle = UITableViewCellSeparatorStyle.None
           self.scroll!.addSubview(self.table!)
           self.table!.delegate = self
           self.table!.dataSource = self
        
    }
    
    func setActivitiesView(){
        let path = NSBundle.mainBundle().pathForResource("activityDetailBackground", ofType: "png")
        
        self.activitiesView = UIImageView(frame: CGRect(x: 0, y: 64 + UIAdapter.shared.transferHeight(15), width: UIAdapter.shared.transferWidth(280), height: UIAdapter.shared.transferHeight(380)))
        self.activitiesView!.userInteractionEnabled = true
        self.activitiesView!.image = UIImage(contentsOfFile: path!)
        self.activitiesView!.layer.cornerRadius = 5
        self.activitiesView!.layer.masksToBounds = true
        self.view.addSubview(self.activitiesView!)
    }
    
    func setActivityDetail(){
        activityDetailView = activityDetail(frame: CGRect(x: 0, y: 0, width: UIAdapter.shared.transferWidth(240), height: UIAdapter.shared.transferHeight(130)))
        self.scroll!.addSubview(activityDetailView!)
        activityDetailView!.level!.text = dataModel!.activity.aplName
        activityDetailView!.content!.text = dataModel!.activity.detail
        activityDetailView!.name!.text = dataModel!.activity.title
        activityDetailView!.type!.text = dataModel!.activity.apName
        
        let timeStamp = NSString(string :dataModel!.activity.startDate)
        let timeInterval:NSTimeInterval = NSTimeInterval(timeStamp.doubleValue) / 1000
        let startDate = NSDate(timeIntervalSince1970: timeInterval)
        
        let endTimeStamp = NSString(string :dataModel!.activity.startDate)
        let endTimeInterval:NSTimeInterval = NSTimeInterval(timeStamp.doubleValue) / 1000
        let endDate =  NSDate(timeIntervalSince1970: endTimeInterval)

        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let time = dateFormatter.stringFromDate(startDate)
        activityDetailView!.time!.text = time
        
        
        var timeFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let startTime = dateFormatter.stringFromDate(endDate)
        let endTime = dateFormatter.stringFromDate(endDate)
        
        let now = NSDate()
        let dtime = now.timeIntervalSinceDate(startDate)
        
        activityDetailView!.startTime!.text = startTime
        activityDetailView!.endTime!.text = endTime

    }

    
    func setButtonList(){
       buttonListBackground = UIImageView(frame: CGRect(x: 0, y: UIAdapter.shared.transferHeight(130), width: UIAdapter.shared.transferWidth(240), height: UIAdapter.shared.transferHeight(20)))
       buttonListBackground!.image = UIImage(named: "buttonlist")
       self.scroll!.addSubview(buttonListBackground!)
        
       applyList = UIButton(frame: CGRect(x: 0, y: UIAdapter.shared.transferHeight(130), width: UIAdapter.shared.transferWidth(80), height: UIAdapter.shared.transferHeight(20)))
       applyList!.setTitle("申请列表 3", forState: UIControlState.Normal)
       applyList!.setTitleColor(Resources.Color.dailyColor, forState: UIControlState.Normal)
       applyList!.titleLabel?.font = UIFont(name: "KaiTi",size: UIAdapter.shared.transferHeight(9))
       applyList!.addTarget(self, action: "applyListClick:", forControlEvents: UIControlEvents.TouchUpInside)
       applyList!.titleLabel?.textAlignment = NSTextAlignment.Center
       self.scroll!.addSubview(applyList!)
        
        playerList = UIButton(frame: CGRect(x: UIAdapter.shared.transferWidth(80), y: UIAdapter.shared.transferHeight(130), width: UIAdapter.shared.transferWidth(80), height: UIAdapter.shared.transferHeight(20)))
        playerList!.setTitle("成员列表 \(playerListSource!.count)", forState: UIControlState.Normal)
        playerList!.setTitleColor(Resources.Color.dailyColor, forState: UIControlState.Normal)
        playerList!.titleLabel?.font = UIFont(name: "KaiTi",size: UIAdapter.shared.transferHeight(9))
        playerList!.addTarget(self, action: "playerListClick:", forControlEvents: UIControlEvents.TouchUpInside)
        playerList!.titleLabel?.textAlignment = NSTextAlignment.Center
         self.scroll!.addSubview(playerList!)
        
        invite = UIButton(frame: CGRect(x: UIAdapter.shared.transferWidth(160), y: UIAdapter.shared.transferHeight(130), width: UIAdapter.shared.transferWidth(80), height: UIAdapter.shared.transferHeight(20)))
        invite!.setTitle("邀请", forState: UIControlState.Normal)
        invite!.setTitleColor(Resources.Color.dailyColor, forState: UIControlState.Normal)
        invite!.titleLabel?.font = UIFont(name: "KaiTi",size: UIAdapter.shared.transferHeight(9))
        invite!.addTarget(self, action: "invitePlayer:", forControlEvents: UIControlEvents.TouchUpInside)
        invite!.titleLabel?.textAlignment = NSTextAlignment.Center
        self.scroll!.addSubview(invite!)
    }
    
    func invitePlayer(sender : UIButton){
    
        let swishinId = self.soundPlay!.sound.valueForKey(SoundResource.clickEventSound) as! String
        let swishinid = UInt32(swishinId)
        AudioServicesPlaySystemSound(swishinid!);
        
       displayInviteFriendList()
    }
    
    func playerListClick(sender: UIButton){
        let swishinId = self.soundPlay!.sound.valueForKey(SoundResource.clickEventSound) as! String
        let swishinid = UInt32(swishinId)
        AudioServicesPlaySystemSound(swishinid!);
        
        selectedIndex = 2
        self.showProgress()
        self.service!.getActivityDetail(self.activityId!)
    }
    
    func GetActivityDetailFinish(result: ApiResult!, response: AnyObject!, activityId: String!) {
        self.closeProgress()
        if(result.state){
           playerListSource = (result.data as! ActivityDetailModel).activityUser
            if self.table!.indexPathForSelectedRow != nil{
           self.table!.deselectRowAtIndexPath(self.table!.indexPathForSelectedRow!, animated: false)
            }
           self.table!.reloadData()
           self.scroll!.contentSize = CGSize(width: UIAdapter.shared.transferWidth(240), height: UIAdapter.shared.transferHeight(150) + CGFloat(playerListSource!.count + 1) * CGFloat(50))
        }else{
           MsgBoxHelper.show("错误", message: result.message!)
        }
    }
    
    func applyListClick(sender : UIButton){
       
        let swishinId = self.soundPlay!.sound.valueForKey(SoundResource.clickEventSound) as! String
        let swishinid = UInt32(swishinId)
        AudioServicesPlaySystemSound(swishinid!);
        
        selectedIndex = 1
        self.showProgress()
        self.service!.getApplyList(self.activityId!)
        
    }

    func GetApplylistDidFinish(result: ApiResult!, response: AnyObject!) {
        self.closeProgress()
        if(result.state){
            applylistSource = result.data as! NSMutableArray
            if self.table!.indexPathForSelectedRow != nil{
            self.table!.deselectRowAtIndexPath(self.table!.indexPathForSelectedRow!, animated: false)
            }
            self.table!.reloadData()
            self.scroll!.contentSize = CGSize(width: UIAdapter.shared.transferWidth(240), height: UIAdapter.shared.transferHeight(150) + CGFloat(applylistSource!.count + 1) * CGFloat(60))
        }else{
            MsgBoxHelper.show("错误", message: result.message!)
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {

        let point = touch.locationInView(gestureRecognizer.view)
        
        if CGRectContainsPoint(self.activitiesView!.frame, point){
            return false
        }
        return true
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if selectedIndex == 2{
            return self.playerListSource!.count
        }
        return self.applylistSource!.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if selectedIndex == 2{
            if tableView.indexPathForSelectedRow == indexPath{
                return 80
            }
            return 50
        }else{
            if tableView.indexPathForSelectedRow == indexPath{
                return 90
            }
  
            return 60
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if selectedIndex == 2{
        var cell = tableView.dequeueReusableCellWithIdentifier("cell") as? playerListCell
        if(cell == nil) {
            
            cell = playerListCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cell" ,height: 50 ,width: self.table!.frame.width)
            cell!.footer!.infoClick = self.infoClick
            cell!.footer!.addClick = self.addClick
            cell!.footer!.chatClick = self.chatClick
            cell!.footer!.kickClick = self.kickClick
            cell!.footer!.releaseClick = self.releaseClick
        }
            
        let joinType = self.playerListSource![indexPath.row].valueForKey("joinType") as! Int
            if(joinType == 0){
               cell!.responseIcon!.hidden = true
            }else if(joinType == 1){
               cell!.responseIcon!.hidden = false
               cell!.responseIcon!.image = UIImage(named: "assist")
            }
            
        let professionType = self.playerListSource![indexPath.row].valueForKey("professionType") as! Int
            if(professionType == 0){
               cell!.dutyIcon!.setBackgroundImage(UIImage(named: "tank"), forState: UIControlState.Normal)
            }else if(professionType == 1){
               cell!.dutyIcon!.setBackgroundImage(UIImage(named: "heal"), forState: UIControlState.Normal)
            }else{
               cell!.dutyIcon!.setBackgroundImage(UIImage(named: "damage"), forState: UIControlState.Normal)
            }
            
        let profression = self.playerListSource![indexPath.row].valueForKey("professionId") as! Int
            let image = ProfessionHelper.getProfressionImage(professionType, profression: profression)
            cell!.jobIcon!.setBackgroundImage(image, forState: UIControlState.Normal)
            
        cell!.name!.text = self.playerListSource![indexPath.row].valueForKey("userName") as! String
        cell!.account!.text = self.playerListSource![indexPath.row].valueForKey("email") as! String
        
        cell!.selectionStyle = UITableViewCellSelectionStyle.None
        cell?.backgroundColor = UIColor.clearColor()
            
            if indexPath != tableView.indexPathForSelectedRow{
                cell!.footer!.hidden = true
                cell!.backgroundImage!.image = UIImage(named: "player_cell")
            }else{
                cell!.footer!.hidden = false
            }

        return cell!
        }else{
            var cell = tableView.dequeueReusableCellWithIdentifier("cell") as? applyListCell
            if(cell == nil) {
                
                cell = applyListCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cell" ,height: 60 , width: self.table!.frame.width)
                cell!.footer!.infoClick = self.infoClick
                cell!.footer!.inviteClick = self.inviteClick
                cell!.footer!.chatClick = self.chatClick
                cell!.footer!.refusesClick = self.refusesClick
            }

            
            let professionType = self.applylistSource![indexPath.row].valueForKey("professionType") as! Int
            if(professionType == 0){
                cell!.dutyIcon!.setBackgroundImage(UIImage(named: "tank"), forState: UIControlState.Normal)
            }else if(professionType == 1){
                cell!.dutyIcon!.setBackgroundImage(UIImage(named: "heal"), forState: UIControlState.Normal)
            }else{
                cell!.dutyIcon!.setBackgroundImage(UIImage(named: "damage"), forState: UIControlState.Normal)
            }
            
            let profression = self.applylistSource![indexPath.row].valueForKey("professionId") as! Int
            let image = ProfessionHelper.getProfressionImage(professionType, profression: profression)
            cell!.jobIcon!.setBackgroundImage(image, forState: UIControlState.Normal)
            
            cell!.name!.text = self.applylistSource![indexPath.row].valueForKey("userName") as! String
            cell!.account!.text = self.applylistSource![indexPath.row].valueForKey("email") as! String
            cell!.content!.text = self.applylistSource![indexPath.row].valueForKey("content") as! String
            cell!.honorNum!.text = "\(self.applylistSource![indexPath.row].valueForKey("jifen") as! Int)"
            
            if indexPath != tableView.indexPathForSelectedRow{
               cell!.footer!.hidden = true
               cell!.backgroundImage!.image = UIImage(named: "player_cell")
            }else{
               cell!.footer!.hidden = false
            }
            
            cell?.backgroundColor = UIColor.clearColor()
            cell!.selectionStyle = UITableViewCellSelectionStyle.None

            return cell!
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if selectedIndex == 2{
        var cell = tableView.cellForRowAtIndexPath(indexPath) as! playerListCell
        cell.backgroundImage!.image = UIImage(named: "cell_selected")
        tableView.beginUpdates()
        cell.footer!.hidden = false
        tableView.endUpdates()
        }else{
            var cell = tableView.cellForRowAtIndexPath(indexPath) as! applyListCell
            cell.backgroundImage!.image = UIImage(named: "cell_selected")
            tableView.beginUpdates()
            cell.footer!.hidden = false
            tableView.endUpdates()

        }
        let size = self.scroll!.contentSize
        self.scroll!.contentSize = CGSize(width: size.width, height: size.height + 30)
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
        
        if selectedIndex == 2{
        var cell = tableView.cellForRowAtIndexPath(indexPath) as! playerListCell
        cell.footer!.hidden = true
        cell.backgroundImage!.image = UIImage(named: "player_cell")
        
        tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.None)
        }else{
            var cell = tableView.cellForRowAtIndexPath(indexPath) as! applyListCell
            cell.footer!.hidden = true
            cell.backgroundImage!.image = UIImage(named: "player_cell")
            
            tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.None)
        }
        let size = self.scroll!.contentSize
        self.scroll!.contentSize = CGSize(width: size.width, height: size.height - 30)
    }
    
    func displayInviteFriendList(){
        
        UIView.animateWithDuration(0.4, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.activitiesView!.frame.origin.x = -UIAdapter.shared.transferWidth(300)
            
        }) { (success) -> Void in
            if success {
                
                let swishinId = self.soundPlay!.sound.valueForKey(SoundResource.swishinSound) as! String
                let swishinid = UInt32(swishinId)
                AudioServicesPlaySystemSound(swishinid!);
                
                
                let invite = inviteMain(nibName: nil, bundle: nil)
                invite.fromDetail = true;
                let inviteNav = UINavigationController(rootViewController: invite)
                inviteNav.modalPresentationStyle = UIModalPresentationStyle.OverFullScreen
                self.presentViewController(inviteNav, animated: false, completion: nil)
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
