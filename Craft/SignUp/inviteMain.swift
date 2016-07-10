//
//  inviteMain.swift
//  Craft
//
//  Created by castiel on 16/7/10.
//  Copyright © 2016年 castiel. All rights reserved.
//

import UIKit

class inviteMain: ViewControllerBase {

    var inviteMainView : UIImageView?
    var inviteList : UITableView?
    var inviteButton : UIButton?
    var cancelButton : UIButton?
    
    var searchTextField : UITextField?
    var searchButton : UIButton?
    
    
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

    
    
//    func setTabButton(){
//        inviteButton = UIButton()
//        inviteButton!.setImage(UIImage(named: "createActivity"), forState: UIControlState.Highlighted)
//        inviteButton!.setImage(UIImage(named: "createActivity"), forState: UIControlState.Normal)
//        inviteButton!.backgroundColor = UIColor.blackColor()
//        self.view.addSubview(inviteButton!)
//        
//        inviteButton!.mas_makeConstraints{make in
//            make.top.equalTo()(self.activityMain!.mas_bottom).with().offset()(UIAdapter.shared.transferHeight(17))
//            
//            make.left.equalTo()(self.activityMain!)
//            make.bottom.equalTo()(self.activitiesView!).with().offset()(-UIAdapter.shared.transferHeight(8))
//            make.right.equalTo()(self.activitiesView!.mas_left).with().offset()(self.activitiesView!.frame.width / 2 - 10)
//        }
//        
//        cancelButton = UIButton()
//        cancelButton!.setImage(UIImage(named: "cancelCreate"), forState: UIControlState.Normal)
//        cancelButton!.setImage(UIImage(named: "cancelCreate"), forState: UIControlState.Highlighted)
//        cancelButton!.backgroundColor = UIColor.blackColor()
//        self.view.addSubview(cancelButton!)
//        
//        cancelButton!.mas_makeConstraints{make in
//            make.top.equalTo()(self.activityMain!.mas_bottom).with().offset()(UIAdapter.shared.transferHeight(17))
//            make.right.equalTo()(self.activityMain!)
//            make.bottom.equalTo()(self.activitiesView!).with().offset()(-UIAdapter.shared.transferHeight(8))
//            make.left.equalTo()(self.activitiesView!.mas_right).with().offset()(-(self.activitiesView!.frame.width / 2 - 10))
//        }
//    }


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
