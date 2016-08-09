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
        let path = NSBundle.mainBundle().pathForResource("MyActivity", ofType: "png")
        self.activityMainView!.image = UIImage(contentsOfFile: path!)
        self.addSubview(self.activityMainView!)
        
        setSearchTextField()
        setSearchButton()
        setAddNewButton()
        setActivityTabel()
        setTabButton()
    }
    
    func setSearchTextField(){
        searchTextField = UITextField()
        searchTextField!.textColor = UIColor.whiteColor()
        searchTextField!.font = UIFont(name: "KaiTi", size: UIAdapter.shared.transferHeight(12))
        self.addSubview(searchTextField!)
        
        self.searchTextField!.mas_makeConstraints{ make in
           make.top.equalTo()(self.activityMainView!).with().offset()(UIAdapter.shared.transferHeight(27))
           make.right.equalTo()(self.activityMainView!).with().offset()(UIAdapter.shared.transferWidth(-110))
           make.bottom.equalTo()(self.activityMainView!.mas_top).with().offset()(UIAdapter.shared.transferHeight(45))
           make.left.equalTo()(self.activityMainView!).with().offset()(UIAdapter.shared.transferWidth(22))
        }
    }
    
    func setSearchButton(){
            searchButton = UIButton()
            searchButton!.setImage(UIImage(named: "search"), forState: UIControlState.Normal)
            self.addSubview(searchButton!)
            
            self.searchButton!.mas_makeConstraints{ make in
                make.top.equalTo()(self.searchTextField!).with().offset()(1)
                make.right.equalTo()(self.searchTextField!).with().offset()(UIAdapter.shared.transferWidth(25))
                make.bottom.equalTo()(self.searchTextField!).with().offset()(-1)
                make.left.equalTo()(self.searchTextField!.mas_right)
            }
    }
    
    func setAddNewButton(){
        addNewActivity = UIButton()
        addNewActivity!.setImage(UIImage(named: "create"), forState: UIControlState.Normal)
        self.activityMainView!.addSubview(addNewActivity!)
        
        self.addNewActivity!.mas_makeConstraints{ make in
            make.top.equalTo()(self.searchButton!)
            make.right.equalTo()(self.activityMainView!.mas_right).with().offset()(-UIAdapter.shared.transferWidth(23))
            make.bottom.equalTo()(self.searchButton!)
            make.left.equalTo()(self.searchButton!.mas_right).with().offset()(UIAdapter.shared.transferWidth(12))
        }
    }
    
    func setActivityTabel(){
       self.activityTabel = UITableView()
       self.activityTabel!.backgroundColor = UIColor.blackColor()
       self.addSubview(activityTabel!)
    
        self.activityTabel!.mas_makeConstraints{ make in
          make.right.equalTo()(self.addNewActivity!)
            make.left.equalTo()(self.searchTextField!)
            make.top.equalTo()(self.searchTextField!.mas_bottom)
            make.bottom.equalTo()(self.activityMainView!.mas_bottom).with().offset()(UIAdapter.shared.transferHeight(-50))
        }
    }
    
    func setTabButton(){
        MyActivityButton = UIButton()
        MyActivityButton!.setImage(UIImage(named: "myActivity_selected"), forState: UIControlState.Highlighted)
        MyActivityButton!.setImage(UIImage(named: "myActivity_selected"), forState: UIControlState.Normal)
        MyActivityButton!.backgroundColor = UIColor.blackColor()
        self.addSubview(MyActivityButton!)
        
        MyActivityButton!.mas_makeConstraints{make in
            make.top.equalTo()(self.activityTabel!.mas_bottom).with().offset()(UIAdapter.shared.transferHeight(17))

           make.left.equalTo()(self.activityTabel!)
           make.bottom.equalTo()(self.activityMainView!).with().offset()(-UIAdapter.shared.transferHeight(8))
           make.right.equalTo()(self.activityMainView!.mas_left).with().offset()(self.frame.width / 2 - 10)
        }
        
        searchActivityButton = UIButton()
        searchActivityButton!.setImage(UIImage(named: "searchActivity"), forState: UIControlState.Normal)
        searchActivityButton!.setImage(UIImage(named: "searchActivity_selected"), forState: UIControlState.Highlighted)
        searchActivityButton!.backgroundColor = UIColor.blackColor()
        self.addSubview(searchActivityButton!)
        
        searchActivityButton!.mas_makeConstraints{make in
            make.top.equalTo()(self.activityTabel!.mas_bottom).with().offset()(UIAdapter.shared.transferHeight(17))
            make.right.equalTo()(self.activityTabel!)
            make.bottom.equalTo()(self.activityMainView!).with().offset()(-UIAdapter.shared.transferHeight(8))
            make.left.equalTo()(self.activityMainView!.mas_right).with().offset()(-(self.frame.width / 2 - 10))
        }
    }

    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
