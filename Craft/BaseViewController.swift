//
//  BaseViewController.swift
//  Craft
//
//  Created by castiel on 15/11/7.
//  Copyright © 2015年 castiel. All rights reserved.
//

import Foundation
import SVProgressHUD

class ViewControllerBase:UIViewController
{
    var _action:(()->Void)?
    var _hasNotification : Bool = false
    var _keyBoardIsVisible : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //防止带有导航条的view预留导航条的距离
        self.automaticallyAdjustsScrollViewInsets = false
        initView()
        registerEvents()
        
        let attributes = [
            NSForegroundColorAttributeName : UIColor.whiteColor()
        ]
        
        self.navigationController?.navigationBar.titleTextAttributes = attributes
        
        onLoad()
    }
    
    func initView()
    {
        
    }
    
    func registerEvents()
    {
        
    }
    
    func onLoad()
    {
        
    }
    
    func showProgress()
    {
        self.view.userInteractionEnabled = false
        self.navigationController?.view.userInteractionEnabled = false
        self.tabBarController?.view.userInteractionEnabled = false
        SVProgressHUD.setForegroundColor(UIColor.orangeColor())
        SVProgressHUD.setBackgroundColor(UIColor.clearColor())
        SVProgressHUD.show()
    }
    
    func closeProgress()
    {
        SVProgressHUD.dismiss()
        self.view.userInteractionEnabled = true
        self.navigationController?.view.userInteractionEnabled = true
        self.tabBarController?.view.userInteractionEnabled = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        if self._hasNotification {
            NSNotificationCenter.defaultCenter().removeObserver(self)
        }
    }
}