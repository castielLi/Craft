//
//  MyActivities.swift
//  Craft
//
//  Created by castiel on 16/2/23.
//  Copyright © 2016年 castiel. All rights reserved.
//

import UIKit

class MyActivities: ViewControllerBase ,UIGestureRecognizerDelegate , UITableViewDataSource, UITableViewDelegate{
    
    
    var activitiesView : UIImageView?
    var button : UIButton?
    var blankTap : UITapGestureRecognizer?
    
    
    var scroll : UIScrollView?
    var table : UITableView?
    
    var raidDropdown : UIButton?
    var raidTitle : UITextView?
    var raidContent : UITextView?
    var activityDetailView : activityDetail?
    
    var applyList : UIButton?
    var playerList : UIButton?
    var invite : UIButton?
    var buttonListBackground : UIImageView?
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
//        self.navigationController!.navigationBar.barStyle = UIBarStyle.BlackTranslucent
//        self.navigationController!.navigationBar.setBackgroundImage(UIImage(named: "navigationBackGround"), forBarMetrics: UIBarMetrics.Default)
        
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
        self.scroll!.contentSize = CGSize(width: UIAdapter.shared.transferWidth(240) , height: UIAdapter.shared.transferHeight(500))
        self.scroll!.showsVerticalScrollIndicator = false
        self.scroll!.showsHorizontalScrollIndicator = false
        self.activitiesView!.addSubview(self.scroll!)
        
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
    }

    
    func setButtonList(){
       buttonListBackground = UIImageView(frame: CGRect(x: 0, y: UIAdapter.shared.transferHeight(130), width: UIAdapter.shared.transferWidth(240), height: UIAdapter.shared.transferHeight(20)))
       buttonListBackground!.image = UIImage(named: "buttonlist")
       self.scroll!.addSubview(buttonListBackground!)
        
       applyList = UIButton(frame: CGRect(x: 0, y: UIAdapter.shared.transferHeight(130), width: UIAdapter.shared.transferWidth(80), height: UIAdapter.shared.transferHeight(20)))
       applyList!.setTitle("申请列表 3", forState: UIControlState.Normal)
       applyList!.setTitleColor(Resources.Color.dailyColor, forState: UIControlState.Normal)
       applyList!.titleLabel?.font = UIFont(name: "KaiTi",size: UIAdapter.shared.transferHeight(9))
       applyList!.titleLabel?.textAlignment = NSTextAlignment.Center
       self.scroll!.addSubview(applyList!)
        
        playerList = UIButton(frame: CGRect(x: UIAdapter.shared.transferWidth(80), y: UIAdapter.shared.transferHeight(130), width: UIAdapter.shared.transferWidth(80), height: UIAdapter.shared.transferHeight(20)))
        playerList!.setTitle("成员列表 3/25", forState: UIControlState.Normal)
        playerList!.setTitleColor(Resources.Color.dailyColor, forState: UIControlState.Normal)
        playerList!.titleLabel?.font = UIFont(name: "KaiTi",size: UIAdapter.shared.transferHeight(9))
        playerList!.titleLabel?.textAlignment = NSTextAlignment.Center
         self.scroll!.addSubview(playerList!)
        
        invite = UIButton(frame: CGRect(x: UIAdapter.shared.transferWidth(160), y: UIAdapter.shared.transferHeight(130), width: UIAdapter.shared.transferWidth(80), height: UIAdapter.shared.transferHeight(20)))
        invite!.setTitle("邀请", forState: UIControlState.Normal)
        invite!.setTitleColor(Resources.Color.dailyColor, forState: UIControlState.Normal)
        invite!.titleLabel?.font = UIFont(name: "KaiTi",size: UIAdapter.shared.transferHeight(9))
        invite!.titleLabel?.textAlignment = NSTextAlignment.Center
        self.scroll!.addSubview(invite!)
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
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell")
        if(cell == nil) {
            
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cell")
        }
        
        cell!.imageView!.image = UIImage(named: "alliance")
        cell!.textLabel!.text = "This is test label"
        cell!.detailTextLabel!.text = "This is test description label"
        cell!.backgroundColor = UIColor.clearColor()
        return cell!
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
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
