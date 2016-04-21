//
//  AcitvityMainView.swift
//  Craft
//
//  Created by castiel on 16/3/26.
//  Copyright © 2016年 castiel. All rights reserved.
//

import UIKit

class ActivityMainView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    var activityMainView : UIImageView?
    
    var searchTextField : UITextField?
    var searchButton : UIButton?
    
    var addNewActivity : UIButton?
    
    var searchActivityButton : UIButton?
    var MyActivityButton : UIButton?
    var activityTabel : UITableView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.activityMainView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        self.activityMainView!.userInteractionEnabled = true
        self.activityMainView!.backgroundColor = UIColor(red: 30/255, green: 69/255, blue: 102/255, alpha: 1)
        self.activityMainView!.alpha = 0.7
        self.activityMainView!.layer.cornerRadius = 5
        self.activityMainView!.layer.borderWidth = 2
        self.activityMainView!.layer.borderColor = UIColor.grayColor().CGColor
        self.activityMainView!.layer.masksToBounds = true
        self.addSubview(self.activityMainView!)
        
        setSearchTextField()
        setSearchButton()
        setAddNewButton()
        setActivityTabel()
        setTabButton()
    }
    
    func setSearchTextField(){
        searchTextField = UITextField()
        searchTextField!.layer.borderWidth = 1
        searchTextField!.layer.borderColor = UIColor.lightGrayColor().CGColor
        searchTextField!.layer.masksToBounds = true
        searchTextField!.placeholder = "查找活动"
        self.addSubview(searchTextField!)
        
        self.searchTextField!.mas_makeConstraints{ make in
           make.top.equalTo()(self.activityMainView!).with().offset()(UIAdapter.shared.transferHeight(20))
           make.right.equalTo()(self.activityMainView!).with().offset()(UIAdapter.shared.transferWidth(-50))
           make.bottom.equalTo()(self.activityMainView!.mas_top).with().offset()(UIAdapter.shared.transferHeight(45))
           make.left.equalTo()(self.activityMainView!).with().offset()(UIAdapter.shared.transferWidth(20))
        }
    }
    
    func setSearchButton(){
            searchButton = UIButton()
            searchButton!.setTitle("X", forState: UIControlState.Normal)
            searchButton!.backgroundColor = UIColor.blackColor()
            self.addSubview(searchButton!)
            
            self.searchButton!.mas_makeConstraints{ make in
                make.top.equalTo()(self.searchTextField!)
                make.right.equalTo()(self.activityMainView!).with().offset()(UIAdapter.shared.transferWidth(-30))
                make.bottom.equalTo()(self.searchTextField!)
                make.left.equalTo()(self.searchTextField!.mas_right)
            }
    }
    
    func setAddNewButton(){
        addNewActivity = UIButton()
        
        addNewActivity!.backgroundColor = UIColor.blackColor()
        addNewActivity!.setTitle("A", forState: UIControlState.Normal)
        self.activityMainView!.addSubview(addNewActivity!)
        
        self.addNewActivity!.mas_makeConstraints{ make in
            make.top.equalTo()(self.searchTextField!)
            make.right.equalTo()(self.activityMainView!.mas_right)
            make.bottom.equalTo()(self.searchTextField!)
            make.left.equalTo()(self.searchButton!.mas_right)
        }
    }
    
    func setActivityTabel(){
       self.activityTabel = UITableView()
       self.activityTabel!.backgroundColor = UIColor.lightGrayColor()
       self.addSubview(activityTabel!)
    
        self.activityTabel!.mas_makeConstraints{ make in
          make.right.equalTo()(self.activityMainView!).with().offset()(UIAdapter.shared.transferWidth(-20))
            make.left.equalTo()(self.activityMainView!).with().offset()(UIAdapter.shared.transferWidth(20))
            make.top.equalTo()(self.searchTextField!.mas_bottom).with().offset()(UIAdapter.shared.transferHeight(10))
            make.bottom.equalTo()(self.searchTextField!.mas_bottom).with().offset()(UIAdapter.shared.transferHeight(250))
        }
    }
    
    func setTabButton(){
        MyActivityButton = UIButton()
        MyActivityButton!.setTitle("我的团队", forState: UIControlState.Normal)
        MyActivityButton!.backgroundColor = UIColor.blackColor()
        self.addSubview(MyActivityButton!)
        
        MyActivityButton!.mas_makeConstraints{make in
            make.top.equalTo()(self.activityTabel!.mas_bottom).with().offset()(UIAdapter.shared.transferHeight(10))

           make.left.equalTo()(self.activityMainView!).with().offset()(UIAdapter.shared.transferWidth(40))
           make.bottom.equalTo()(self.activityMainView!).with().offset()(-UIAdapter.shared.transferHeight(5))
           make.right.equalTo()(self.activityMainView!.mas_left).with().offset()(self.frame.width / 2)
        }
        
        searchActivityButton = UIButton()
        searchActivityButton!.setTitle("搜索团队", forState: UIControlState.Normal)
        searchActivityButton!.backgroundColor = UIColor.blackColor()
        self.addSubview(searchActivityButton!)
        
        searchActivityButton!.mas_makeConstraints{make in
            make.top.equalTo()(self.activityTabel!.mas_bottom).with().offset()(UIAdapter.shared.transferHeight(10))
            make.right.equalTo()(self.activityMainView!).with().offset()(UIAdapter.shared.transferWidth(-40))
            make.bottom.equalTo()(self.activityMainView!).with().offset()(-UIAdapter.shared.transferHeight(5))
            make.left.equalTo()(self.activityMainView!.mas_right).with().offset()(-(self.frame.width / 2))
        }
    }

    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
