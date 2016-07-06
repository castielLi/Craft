//
//  AddNewActivity.swift
//  Craft
//
//  Created by castiel on 16/4/13.
//  Copyright © 2016年 castiel. All rights reserved.
//

import UIKit

class AddNewActivityController: ViewControllerBase ,UIGestureRecognizerDelegate{
    
    var activitiesView : UIImageView?
    var blankTap : UITapGestureRecognizer?
    var activityMain : UIScrollView?
    
    var createButton : UIButton?
    var cancelButton : UIButton?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController!.setNavigationBarHidden(true, animated: false)
        
        let animation = CABasicAnimation(keyPath: "position.x")
//        animation.damping = 12
//        animation.stiffness = 100
//        animation.mass = 1
//        animation.initialVelocity = 0
//        animation.duration = animation.settlingDuration
        animation.removedOnCompletion = false
        animation.timingFunction = CAMediaTimingFunction( name: kCAMediaTimingFunctionEaseOut)
        animation.fromValue = -UIAdapter.shared.transferWidth(300)
        
        self.activitiesView!.layer.addAnimation(animation, forKey: nil)
        self.activityMain!.layer.addAnimation(animation, forKey: nil)
        self.createButton!.layer.addAnimation(animation, forKey: nil)
        self.cancelButton!.layer.addAnimation(animation, forKey: nil)

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
    }
    
    func setActivityTabel(){
        self.activityMain = UIScrollView()
        self.activityMain!.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(activityMain!)
        
        self.activityMain!.mas_makeConstraints{ make in
            make.right.equalTo()(self.activitiesView!).with().offset()(-UIAdapter.shared.transferWidth(23))
            make.left.equalTo()(self.activitiesView!).with().offset()(UIAdapter.shared.transferWidth(18))
            make.top.equalTo()(self.activitiesView!.mas_top).with().offset()(UIAdapter.shared.transferHeight(27))
            make.bottom.equalTo()(self.activitiesView!.mas_bottom).with().offset()(UIAdapter.shared.transferHeight(-50))
        }
    }

    
    func setTabButton(){
        createButton = UIButton()
        createButton!.setImage(UIImage(named: "myActivity_selected"), forState: UIControlState.Highlighted)
        createButton!.setImage(UIImage(named: "myActivity_selected"), forState: UIControlState.Normal)
        createButton!.backgroundColor = UIColor.blackColor()
        self.view.addSubview(createButton!)
        
        createButton!.mas_makeConstraints{make in
            make.top.equalTo()(self.activityMain!.mas_bottom).with().offset()(UIAdapter.shared.transferHeight(17))
            
            make.left.equalTo()(self.activityMain!)
            make.bottom.equalTo()(self.activitiesView!).with().offset()(-UIAdapter.shared.transferHeight(8))
            make.right.equalTo()(self.activitiesView!.mas_left).with().offset()(self.activitiesView!.frame.width / 2 - 10)
        }
        
        cancelButton = UIButton()
        cancelButton!.setImage(UIImage(named: "searchActivity"), forState: UIControlState.Normal)
        cancelButton!.setImage(UIImage(named: "searchActivity_selected"), forState: UIControlState.Highlighted)
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
