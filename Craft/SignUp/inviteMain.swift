//
//  inviteMain.swift
//  Craft
//
//  Created by castiel on 16/7/10.
//  Copyright © 2016年 castiel. All rights reserved.
//

import UIKit

class inviteMain: ViewControllerBase , UIGestureRecognizerDelegate{

    var inviteMainView : UIImageView?
    var inviteList : UITableView?
    var inviteButton : UIButton?
    var cancelButton : UIButton?
    
    var searchTextField : UITextField?
    var searchButton : UIButton?
    var blankTap : UITapGestureRecognizer?
    var fromDetail : Bool?
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController!.setNavigationBarHidden(true, animated: false)
        
        let animation = CABasicAnimation(keyPath: "position.y")
//        animation.removedOnCompletion = false
//        animation.fillMode = kCAFillModeForwards
        animation.timingFunction = CAMediaTimingFunction( name: kCAMediaTimingFunctionEaseOut)
        animation.fromValue = -UIAdapter.shared.transferHeight(370)
        
        self.inviteMainView!.layer.addAnimation(animation, forKey: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func initView() {
        setbackgroundImage()
        setSearchTextField()
        setSearchButton()
        setTapForBackgroundView()
        setTable()
        setTabButton()
    }
    
    func setTable(){
        self.inviteList = UITableView(frame: CGRect(x: UIAdapter.shared.transferWidth(20), y: UIAdapter.shared.transferHeight(32 + 19), width: UIAdapter.shared.transferWidth(250), height: UIAdapter.shared.transferHeight(370 - 50 - 32 - 19)))
        self.inviteList!.delegate = self
        self.inviteList!.dataSource = self
        self.inviteList!.separatorStyle = UITableViewCellSeparatorStyle.None
        self.inviteList!.tableFooterView = UIView()
        self.inviteList!.backgroundColor = UIColor.clearColor()
        self.inviteList!.showsVerticalScrollIndicator = false
        self.inviteList!.showsHorizontalScrollIndicator = false
        self.inviteMainView!.addSubview(inviteList!)
    }
    
    func setbackgroundImage(){
        inviteMainView = UIImageView(frame: CGRect(x :(self.view.frame.width - UIAdapter.shared.transferWidth(290)) / 2  , y: UIAdapter.shared.transferHeight(15) + 64, width: UIAdapter.shared.transferWidth(290), height: UIAdapter.shared.transferHeight(370)))
        inviteMainView!.layer.cornerRadius = 3
        inviteMainView!.layer.masksToBounds = true
        let path = NSBundle.mainBundle().pathForResource("invite_friend", ofType: "png")
        inviteMainView!.image = UIImage(contentsOfFile: path!)
        self.view.addSubview(inviteMainView!)
        self.inviteMainView!.userInteractionEnabled = true
    }
    
    func setSearchTextField(){
        searchTextField = UITextField(frame: CGRect(x: UIAdapter.shared.transferWidth(20), y: UIAdapter.shared.transferHeight(32), width: UIAdapter.shared.transferWidth(290 - 45), height: UIAdapter.shared.transferHeight(18)))
        searchTextField!.placeholder = "查找活动"
        searchTextField!.textColor = UIColor.whiteColor()
        searchTextField!.font = UIAdapter.shared.transferFont(13)
        searchTextField!.backgroundColor = UIColor(red: 13/255, green: 10/255, blue: 9/255, alpha: 1)
        self.inviteMainView!.addSubview(searchTextField!)
        

    }
    
    func setSearchButton(){
        searchButton = UIButton(frame: CGRect(x: UIAdapter.shared.transferWidth(246), y: UIAdapter.shared.transferHeight(32), width: UIAdapter.shared.transferWidth(26), height: UIAdapter.shared.transferHeight(19)))
        searchButton!.setImage(UIImage(named: "search"), forState: UIControlState.Normal)
        self.inviteMainView!.addSubview(searchButton!)

    }



    
    
    func setTabButton(){
        inviteButton = UIButton(frame : CGRect(x:UIAdapter.shared.transferWidth(20), y: UIAdapter.shared.transferHeight(370 - 50 + 17), width: UIAdapter.shared.transferWidth(125) - 10, height: UIAdapter.shared.transferHeight(25)))
        inviteButton!.setImage(UIImage(named: "createActivity"), forState: UIControlState.Highlighted)
        inviteButton!.setImage(UIImage(named: "createActivity"), forState: UIControlState.Normal)
        inviteButton!.backgroundColor = UIColor.blackColor()
        self.inviteMainView!.addSubview(inviteButton!)
        
        
        cancelButton = UIButton(frame : CGRect(x: UIAdapter.shared.transferWidth(145) + 10, y: UIAdapter.shared.transferHeight(370 - 50 + 17), width: self.inviteButton!.frame.width, height: self.inviteButton!.frame.height))
        cancelButton!.setImage(UIImage(named: "cancelCreate"), forState: UIControlState.Normal)
        cancelButton!.setImage(UIImage(named: "cancelCreate"), forState: UIControlState.Highlighted)
        cancelButton!.backgroundColor = UIColor.blackColor()
        self.inviteMainView!.addSubview(cancelButton!)
        
//            cancelButton!.mas_makeConstraints{make in
//                make.top.equalTo()(self.activityMain!.mas_bottom).with().offset()(UIAdapter.shared.transferHeight(17))
//                make.right.equalTo()(self.activityMain!)
//                make.bottom.equalTo()(self.activitiesView!).with().offset()(-UIAdapter.shared.transferHeight(8))
//                make.left.equalTo()(self.activitiesView!.mas_right).with().offset()(-(self.activitiesView!.frame.width / 2 - 10))
//        }
    
    }
    
    func setTapForBackgroundView(){
        self.blankTap = UITapGestureRecognizer(target: self, action: "BlankSpaceTap:")
        self.blankTap!.numberOfTapsRequired = 1
        self.blankTap!.delegate = self
        self.view.addGestureRecognizer(self.blankTap!)
    }
    
    func BlankSpaceTap(sender : UITapGestureRecognizer){
        
        UIView.animateWithDuration(0.4, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.inviteMainView!.frame.origin.y = -UIAdapter.shared.transferHeight(370)
//            self.cancelButton!.frame.origin.x = -UIAdapter.shared.transferWidth(140)
//            self.createButton!.frame.origin.x = -UIAdapter.shared.transferWidth(250)
        }) { (success) -> Void in
            if success {
                if (self.fromDetail == nil || !self.fromDetail!){
                    self.dismissViewControllerAnimated(false, completion: { () -> Void in
                        NSNotificationCenter.defaultCenter().postNotificationName("dismissInviteDialog", object: self)
                    })
                }else{
                    self.dismissViewControllerAnimated(false, completion: { () -> Void in
                        NSNotificationCenter.defaultCenter().postNotificationName("dismissAcitivtiesDialogFromDetail", object: self)
                    })
                }
                
            }
        }
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        let point = touch.locationInView(gestureRecognizer.view)
        if (CGRectContainsPoint(self.inviteMainView!.frame, point)){
            return false;
        }
        
        return true;
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
