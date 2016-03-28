//
//  ActivityMain.swift
//  Craft
//
//  Created by castiel on 15/11/28.
//  Copyright © 2015年 castiel. All rights reserved.
//

import UIKit

class ActivityMain: ViewControllerBase {
    
    var usertable : UITableView?
    var userTableSource : ActivityUserTableSource?
    var backgroundImage : UIImageView?
    var signUpPageButton : UIButton?
    
    var selectDialog : UIImageView?
    
    var testButton : UIButton?

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController!.navigationBar.barStyle = UIBarStyle.BlackTranslucent
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(named: "navigationBackGround"), forBarMetrics: UIBarMetrics.Default)
        
        
        let backButton = UIBarButtonItem()
        self.navigationItem.backBarButtonItem = backButton
        self.navigationItem.backBarButtonItem!.title = ""
        
        let center = NSNotificationCenter.defaultCenter()
        center.addObserver(self,
            selector: Selector("activitiesDialogDisappear:"), name: "dismissAcitivtiesDialog", object: nil)
        self._hasNotification = true
        
        
        
        let viewAnimation = CABasicAnimation(keyPath: "position.x")
        viewAnimation.duration = 0.3
        viewAnimation.removedOnCompletion = false
        viewAnimation.timingFunction = CAMediaTimingFunction( name: kCAMediaTimingFunctionEaseOut)
        viewAnimation.fromValue = -UIScreen.mainScreen().bounds.width
        
        self.view!.layer.addAnimation(viewAnimation, forKey: nil)
        
        
        
        let animation = CASpringAnimation(keyPath: "position.x")
        animation.damping = 12
        animation.stiffness = 100
        animation.mass = 1
        animation.initialVelocity = 0
        animation.duration = animation.settlingDuration
        animation.removedOnCompletion = false
        animation.timingFunction = CAMediaTimingFunction( name: kCAMediaTimingFunctionEaseOut)
        animation.fromValue = -UIAdapter.shared.transferWidth(150)
        
        self.selectDialog!.layer.addAnimation(animation, forKey: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let backButton = UIBarButtonItem()
        self.navigationItem.backBarButtonItem = backButton
        self.navigationItem.backBarButtonItem?.title = ""
        
        self.view.backgroundColor = UIColor.blackColor()
        
        // Do any additional setup after loading the view.
    }
    
    override func initView() {
        setBackGroundImage()
        setDialog()
        setTestButton()
        setSignUpPageButton()
    }
    
    override func onLoad() {

    }
    
    func setSignUpPageButton(){
        self.signUpPageButton = UIButton()
        signUpPageButton!.bounds.size = CGSize(width: UIAdapter.shared.transferWidth(15), height: UIAdapter.shared.transferWidth(15))
        signUpPageButton!.layer.cornerRadius = UIAdapter.shared.transferWidth(15/2)
        signUpPageButton!.layer.masksToBounds = true
        signUpPageButton!.setBackgroundImage(UIImage(named: "Chat"), forState: UIControlState.Normal)
        signUpPageButton!.addTarget(self, action: "SignUpPageClick:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(self.signUpPageButton!)
        
        self.signUpPageButton!.mas_makeConstraints{ make in
            make.left.equalTo()(self.view).with().offset()(UIAdapter.shared.transferWidth(15))
            make.top.equalTo()(self.view!.mas_bottom).with().offset()(-44 - UIAdapter.shared.transferWidth(15))
        }
    }
    
    func setDialog(){
        self.selectDialog = UIImageView(frame: CGRect(x: 0, y: 64 + UIAdapter.shared.transferHeight(15), width: UIAdapter.shared.transferWidth(240), height: UIAdapter.shared.transferHeight(300)))
        self.selectDialog!.userInteractionEnabled = true
        self.selectDialog!.backgroundColor = UIColor(red: 30/255, green: 69/255, blue: 102/255, alpha: 1)
        self.selectDialog!.alpha = 0.7
        self.selectDialog!.layer.cornerRadius = 5
        self.selectDialog!.layer.borderWidth = 2
        self.selectDialog!.layer.borderColor = UIColor.grayColor().CGColor
        self.selectDialog!.layer.masksToBounds = true
        self.view.addSubview(self.selectDialog!)
    }
    
    func setBackGroundImage(){
       self.backgroundImage = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
       self.backgroundImage!.image = UIImage(named: "collcetionStone")
       self.view.addSubview(self.backgroundImage!)
    }
    
    func setTestButton(){
        testButton = UIButton()
        testButton!.addTarget(self, action: "testButtonClick:", forControlEvents: UIControlEvents.TouchUpInside)
        testButton!.backgroundColor = UIColor.blackColor()
        testButton!.setTitle("Test Button", forState: UIControlState.Normal)
        self.selectDialog!.addSubview(testButton!)
        
        self.testButton!.mas_makeConstraints{ make in
           make.top.equalTo()(self.selectDialog!.mas_top).with().offset()(100)
           make.centerX.equalTo()(self.selectDialog)
           make.height.equalTo()(40)
           make.width.equalTo()(100)
        }
    }
    
    func testButtonClick(sender : UIButton){
        
        UIView.animateWithDuration(0.4, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.selectDialog!.frame.origin.x = -UIAdapter.shared.transferWidth(300)
            
            }) { (success) -> Void in
                if success {
                    let activitiesView = MyActivities(nibName: nil, bundle: nil)
                    let activitiesNav = UINavigationController(rootViewController: activitiesView)
                    activitiesNav.modalPresentationStyle = UIModalPresentationStyle.OverFullScreen
                    self.presentViewController(activitiesNav, animated: false, completion: nil)
                }
        }
    }
    
    func activitiesDialogDisappear(sender : NSNotification){
        UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 100, initialSpringVelocity: 5, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            
              self.selectDialog!.frame.origin.x = 0
            
            }, completion: nil)
    }
    
    
    func setUserBaseInfoTable(){
        self.usertable = UITableView(frame: CGRectMake(0, 84, self.view.frame.width, UIAdapter.shared.transferHeight(60)))
        self.view.addSubview(usertable!)
        self.usertable!.scrollEnabled = false
        self.usertable!.tableFooterView = UIView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func SignUpPageClick(sender : UIButton){
       self.tabBarController!.selectedIndex = 0
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
