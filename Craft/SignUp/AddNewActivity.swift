//
//  AddNewActivity.swift
//  Craft
//
//  Created by castiel on 16/4/13.
//  Copyright © 2016年 castiel. All rights reserved.
//

import UIKit

class AddNewActivityController: ViewControllerBase ,UIGestureRecognizerDelegate{
    
    
    let searchAllType = "SELECT apName,apCode FROM RaidType"
    let searchActivity = "SELECT apdName,apdCode FROM Raid where typeCode=?"
    let searchLevel = "SELECT aplName,aplCode FROM RaidLevel where raidCode=?"
    
    var soundPlay :PlaySound?
    var activitiesView : UIImageView?
    var blankTap : UITapGestureRecognizer?
    var activityMain : UIScrollView?
    var typeDropDownTap : UITapGestureRecognizer?
    var activityDropDownTap : UITapGestureRecognizer?
    var detailDropDownTap : UITapGestureRecognizer?
    var selfDutyInfoTap : UITapGestureRecognizer?
    
    var createButton : UIButton?
    var cancelButton : UIButton?
    
    
    var typeSelected : DropDownSelectView?
    var activitySelected : DropDownSelectView?
    var detailSelected : DropDownSelectView?
    
    var typeSelectedValue:String?
    var activitySelectedValue : String?
    var detailSelectedValue: String?
    
    
    var timeView : CreateActivityTime?
    var timeTap : UITapGestureRecognizer?
    var contentView : UITextView?
    
    var dutyView : currentDutyView?
    var inviteButton : UIButton?
    var inviteTable: UITableView?
    
    var typeArray : NSMutableArray?
    var activityArray: NSMutableArray?
    var levelArray : NSMutableArray?
    var instance : FMDBHelper?
    
    var typeCode : String?
    var activityCode : String?
    var levelCode : String?
    var currentUserInfo : currentUserInformation?
    
    var year : String?
    var month : String?
    var day : String?
    
    var beginHour : String?
    var beginMin : String?
    var endHour : String?
    var endMin : String?
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        soundPlay = PlaySound.sharedData()
        typeArray = NSMutableArray()
        activityArray = NSMutableArray()
        levelArray = NSMutableArray()
        instance = FMDBHelper.sharedData() as! FMDBHelper
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let center = NSNotificationCenter.defaultCenter()
        center.addObserver(self,
                           selector: "inviteListDisappear:", name: "dismissInviteDialog", object: nil)
        
        self.navigationController!.setNavigationBarHidden(true, animated: false)
        
        let animation = CABasicAnimation(keyPath: "position.x")
        animation.removedOnCompletion = false
        animation.timingFunction = CAMediaTimingFunction( name: kCAMediaTimingFunctionEaseOut)
        animation.fromValue = -UIAdapter.shared.transferWidth(300)
        
        self.activitiesView!.layer.addAnimation(animation, forKey: nil)
        self.activityMain!.layer.addAnimation(animation, forKey: nil)
        self.createButton!.layer.addAnimation(animation, forKey: nil)
        self.cancelButton!.layer.addAnimation(animation, forKey: nil)
        
        self.addGestureForDropdowns()
        self.addTimeTapGesture()
        self.addSelfDutyGesture()
        initArrayData()
    }

    func inviteListDisappear(sender : NSNotification){
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            
            let swishinId = self.soundPlay!.sound.valueForKey(SoundResource.swishinSound) as! String
            let swishinid = UInt32(swishinId)
            AudioServicesPlaySystemSound(swishinid!);
            
            self.activitiesView!.frame.origin.x += UIAdapter.shared.transferWidth(290)
            self.activityMain!.frame.origin.x += UIAdapter.shared.transferWidth(290)
            self.cancelButton!.frame.origin.x += UIAdapter.shared.transferWidth(290)
            self.createButton!.frame.origin.x += UIAdapter.shared.transferWidth(290)
        })
    }
    
    
    func initArrayData(){
       self.showProgress()
       
       typeArray = instance!.DatabaseSearchValuesWithParameters(["apName","apCode"], query: searchAllType, values: nil)
       self.closeProgress()
    }
    
    func initActivityData(typeCode:String){
        self.showProgress()
        activitySelected!.displayLabel!.text = "请选择"
        detailSelected!.displayLabel!.text = "请选择"
        activityArray = instance!.DatabaseSearchValuesWithParameters(["apdName","apdCode"], query: searchActivity, values: [typeCode])
        if(activityArray!.count < 1){
           activitySelected!.displayLabel!.text = "无"
           activitySelected!.userInteractionEnabled = false
           detailSelected!.displayLabel!.text = "无"
           detailSelected!.userInteractionEnabled = false
        }else{
            activitySelected!.userInteractionEnabled = true
            detailSelected!.userInteractionEnabled = true
        }
        self.closeProgress()
    }
    
    func initLevelData(raidCode:String){
        self.showProgress()
        detailSelected!.displayLabel!.text = "请选择"
        levelArray = instance!.DatabaseSearchValuesWithParameters(["aplName","aplCode"], query: searchLevel, values: [raidCode])
        if(levelArray!.count < 1){
            detailSelected!.displayLabel!.text = "无"
            detailSelected!.userInteractionEnabled = false
        }else{
            activitySelected!.userInteractionEnabled = true
            detailSelected!.userInteractionEnabled = true
        }
        self.closeProgress()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.clearColor()
        // Do any additional setup after loading the view.
    }
    
    
    override func initView() {
        setActivitiesView()
        setActivityTabel()
        setTabButton()
        setTapForBackgroundView()
        
        setDropDown()
        setTime()
        setContent()
        setSelfDutyView()
        setDutyView()
        setInviteTable()
        setInviteButton()
    }
    
    func setActivityTabel(){
        self.activityMain = UIScrollView()
        self.activityMain!.backgroundColor = UIColor.clearColor()
        self.activityMain!.contentSize = CGSize(width: self.activityMain!.frame.width, height: UIAdapter.shared.transferHeight(520))
        self.view.addSubview(activityMain!)
        
        self.activityMain!.mas_makeConstraints{ make in
            make.right.equalTo()(self.activitiesView!).with().offset()(-UIAdapter.shared.transferWidth(23))
            make.left.equalTo()(self.activitiesView!).with().offset()(UIAdapter.shared.transferWidth(18))
            make.top.equalTo()(self.activitiesView!.mas_top).with().offset()(UIAdapter.shared.transferHeight(27))
            make.bottom.equalTo()(self.activitiesView!.mas_bottom).with().offset()(UIAdapter.shared.transferHeight(-50))
        }
    }
    
    func setDropDown(){
        typeSelected = DropDownSelectView(frame: CGRect(x: UIAdapter.shared.transferWidth(1), y: UIAdapter.shared.transferHeight(3), width: (UIAdapter.shared.transferWidth(250) * 0.3 - UIAdapter.shared.transferWidth(1)) , height: UIAdapter.shared.transferHeight(20)))
        self.activityMain!.addSubview(typeSelected!)
        
        
        
        
        activitySelected = DropDownSelectView(frame: CGRect(x: UIAdapter.shared.transferWidth(76), y: UIAdapter.shared.transferHeight(3), width: (UIAdapter.shared.transferWidth(250) * 0.4 - UIAdapter.shared.transferWidth(1) ), height: UIAdapter.shared.transferHeight(20)))
        self.activityMain!.addSubview(activitySelected!)
        
        detailSelected = DropDownSelectView(frame: CGRect(x: UIAdapter.shared.transferWidth(250) * 0.7 + UIAdapter.shared.transferWidth(1), y: UIAdapter.shared.transferHeight(3), width: UIAdapter.shared.transferWidth(250) * 0.29, height: UIAdapter.shared.transferHeight(20)))
        self.activityMain!.addSubview(detailSelected!)
    
    }
    
    func setTime(){
         self.timeView = CreateActivityTime(frame: CGRect(x: UIAdapter.shared.transferWidth(1), y: UIAdapter.shared.transferHeight(24), width: UIAdapter.shared.transferWidth(250) - UIAdapter.shared.transferWidth(2) , height: UIAdapter.shared.transferHeight(52)))
         self.timeView!.userInteractionEnabled = true
         self.activityMain!.addSubview(self.timeView!)
    }
    
    func setContent(){
        self.contentView = UITextView(frame: CGRect(x: UIAdapter.shared.transferWidth(2), y: UIAdapter.shared.transferHeight(24 + 54), width: UIAdapter.shared.transferWidth(250) - UIAdapter.shared.transferWidth(4), height: UIAdapter.shared.transferHeight(70)))
        self.contentView!.backgroundColor = UIColor(red: 13/255, green: 10/255, blue: 9/255, alpha: 1)
        self.contentView!.textColor = UIColor.whiteColor()
        self.contentView!.font = UIAdapter.shared.transferFont(13)
        self.activityMain!.addSubview(self.contentView!)
    }
    
    func setDutyView(){
     
        self.dutyView = currentDutyView(frame: CGRect(x: UIAdapter.shared.transferWidth(50), y:UIAdapter.shared.transferHeight(24 + 54 + 74 + 50) , width: UIAdapter.shared.transferWidth(150), height: UIAdapter.shared.transferHeight(50)))
        self.activityMain!.addSubview(self.dutyView!)
        self.dutyView!.tankLabel?.text = "0"
        self.dutyView!.damageLabel?.text = "1"
        self.dutyView!.healLabel?.text = "0"
    }
    
    func setSelfDutyView(){
       currentUserInfo = currentUserInformation(frame: CGRect(x: UIAdapter.shared.transferWidth(1), y:UIAdapter.shared.transferHeight(24 + 54 + 74) , width: UIAdapter.shared.transferWidth(250) - UIAdapter.shared.transferWidth(2), height: UIAdapter.shared.transferHeight(40)))
        currentUserInfo!.userInteractionEnabled = true
        self.activityMain!.addSubview(currentUserInfo!)
    }
    
    func setInviteTable(){
        self.inviteTable = UITableView(frame: CGRect(x: UIAdapter.shared.transferWidth(2), y: UIAdapter.shared.transferHeight(24 + 54 + 74 + 50 + 10 + 40), width: UIAdapter.shared.transferWidth(246), height: 44 * 5))
        self.inviteTable!.delegate = self
        self.inviteTable!.dataSource = self
        self.inviteTable!.separatorStyle = UITableViewCellSeparatorStyle.None
        self.inviteTable!.tableFooterView = UIView()
        self.activityMain!.addSubview(self.inviteTable!)
    }
    
    func setInviteButton(){
       self.inviteButton = UIButton()
       self.inviteButton!.setImage(UIImage(named: "inviteButton"), forState: UIControlState.Normal)
       self.activityMain!.addSubview(self.inviteButton!)
        self.inviteButton!.mas_makeConstraints{make in
           make.top.equalTo()(self.inviteTable!.mas_bottom).with().offset()(15)
           make.height.equalTo()(UIAdapter.shared.transferHeight(22))
           make.width.equalTo()(UIAdapter.shared.transferWidth(120))
           make.centerX.equalTo()(self.inviteTable!)
        }
       
        self.inviteButton!.addTarget(self, action: "inviteFriendClick:", forControlEvents: UIControlEvents.TouchUpInside)
    }

    func inviteFriendClick(sender : UIButton){
       self.displayInviteFriendList()
        
    }
    
    func setTabButton(){
        createButton = UIButton()
        createButton!.setImage(UIImage(named: "createActivity"), forState: UIControlState.Highlighted)
        createButton!.setImage(UIImage(named: "createActivity"), forState: UIControlState.Normal)
        createButton!.backgroundColor = UIColor.blackColor()
        self.view.addSubview(createButton!)
        
        createButton!.mas_makeConstraints{make in
            make.top.equalTo()(self.activityMain!.mas_bottom).with().offset()(UIAdapter.shared.transferHeight(17))
            
            make.left.equalTo()(self.activityMain!)
            make.bottom.equalTo()(self.activitiesView!).with().offset()(-UIAdapter.shared.transferHeight(8))
            make.right.equalTo()(self.activitiesView!.mas_left).with().offset()(self.activitiesView!.frame.width / 2 - 10)
        }
        
        cancelButton = UIButton()
        cancelButton!.setImage(UIImage(named: "cancelCreate"), forState: UIControlState.Normal)
        cancelButton!.setImage(UIImage(named: "cancelCreate"), forState: UIControlState.Highlighted)
        cancelButton!.backgroundColor = UIColor.blackColor()
        self.view.addSubview(cancelButton!)
        
        cancelButton!.mas_makeConstraints{make in
            make.top.equalTo()(self.activityMain!.mas_bottom).with().offset()(UIAdapter.shared.transferHeight(17))
            make.right.equalTo()(self.activityMain!)
            make.bottom.equalTo()(self.activitiesView!).with().offset()(-UIAdapter.shared.transferHeight(8))
            make.left.equalTo()(self.activitiesView!.mas_right).with().offset()(-(self.activitiesView!.frame.width / 2 - 10))
        }
    }

    func setTapForBackgroundView(){
        self.blankTap = UITapGestureRecognizer(target: self, action: "BlankSpaceTap:")
        self.blankTap!.numberOfTapsRequired = 1
        self.blankTap!.delegate = self
        self.view.addGestureRecognizer(self.blankTap!)
    }
    
    func BlankSpaceTap(sender : UITapGestureRecognizer){
        
        UIView.animateWithDuration(0.4, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.activitiesView!.frame.origin.x = -UIAdapter.shared.transferWidth(300)
            self.activityMain!.frame.origin.x = -UIAdapter.shared.transferWidth(270)
            self.cancelButton!.frame.origin.x = -UIAdapter.shared.transferWidth(140)
            self.createButton!.frame.origin.x = -UIAdapter.shared.transferWidth(250)
        }) { (success) -> Void in
            if success {
                self.dismissViewControllerAnimated(false, completion: { () -> Void in
                    NSNotificationCenter.defaultCenter().postNotificationName("dismissAcitivtiesDialog", object: self)
                })
                
            }
        }
    }

    
    func setActivitiesView(){
        self.activitiesView = UIImageView(frame: CGRect(x: 0, y: 64 + UIAdapter.shared.transferHeight(15), width: UIAdapter.shared.transferWidth(290), height: UIAdapter.shared.transferHeight(370)))
        self.activitiesView!.userInteractionEnabled = true

        let path = NSBundle.mainBundle().pathForResource("create_activity_main", ofType: "png")
        self.activitiesView!.image = UIImage(contentsOfFile: path!)
        
        self.view.addSubview(self.activitiesView!)
        
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        
        let point = touch.locationInView(gestureRecognizer.view)
        
        if CGRectContainsPoint(self.activitiesView!.frame, point){
            return false
        }
        return true
    }


    func displayInviteFriendList(){
        
        UIView.animateWithDuration(0.4, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.activitiesView!.frame.origin.x = -UIAdapter.shared.transferWidth(290)
            
        }) { (success) -> Void in
            if success {
                
                let swishinId = self.soundPlay!.sound.valueForKey(SoundResource.swishinSound) as! String
                let swishinid = UInt32(swishinId)
                AudioServicesPlaySystemSound(swishinid!);
                
                
                let invite = inviteMain(nibName: nil, bundle: nil)
                let inviteNav = UINavigationController(rootViewController: invite)
                inviteNav.modalPresentationStyle = UIModalPresentationStyle.OverFullScreen
                self.presentViewController(inviteNav, animated: false, completion: nil)
            }
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
