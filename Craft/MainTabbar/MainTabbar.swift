//
//  MainTabbar.swift
//  Craft
//
//  Created by castiel on 15/11/7.
//  Copyright © 2015年 castiel. All rights reserved.
//

import UIKit

class MainTabbar: UITabBarController {

    var panGesture: UIPanGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBar.alpha = 0.5
        
        self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
        
        let messageView = SignUp(nibName: nil, bundle: nil)
        let messageNav = UINavigationController(rootViewController: messageView)
//        messageNav.navigationBar.barTintColor = UIColor.whiteColor()
        
        
        let sliderMain = SliderMain(nibName: nil, bundle: nil)
        let sliderMainNav = UINavigationController(rootViewController: sliderMain)
        sliderMainNav.navigationBar.barTintColor = UIColor.whiteColor()
        
        let settingView = SignUp(nibName: nil, bundle: nil)
        let settingNav = UINavigationController(rootViewController: settingView)
        settingNav.navigationBar.barTintColor = UIColor.whiteColor()
        
        
        let controllers = [messageNav,sliderMainNav,settingNav]
        
        let attributes = [
            NSForegroundColorAttributeName : UIColor(red: 42/255, green: 122/255, blue: 193/255, alpha: 1)
        ]
        
        let messageItem = UITabBarItem(title: "消息", image: nil, tag: 11)
        messageItem.image = UIImage(named: "Account")!.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        messageItem.selectedImage = UIImage(named: "Account_checked")!.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        
        let signUpItem = UITabBarItem(title: "报名", image: nil, tag: 12)
        signUpItem.image = UIImage(named: "Account")!.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        signUpItem.selectedImage = UIImage(named: "Account_checked")!.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        
        let settingItem = UITabBarItem(title: "设置", image: nil, tag: 13)
        settingItem.image = UIImage(named: "Account")!.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        settingItem.selectedImage = UIImage(named:"Account_checked")!.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        
        
        messageView.tabBarItem = messageItem
        sliderMain.tabBarItem = signUpItem
        settingView.tabBarItem = settingItem
        messageItem.setTitleTextAttributes(attributes, forState: UIControlState.Selected)
        signUpItem.setTitleTextAttributes(attributes, forState: UIControlState.Selected)
        settingItem.setTitleTextAttributes(attributes, forState: UIControlState.Selected)
        
        self.tabBar.barTintColor = UIColor.whiteColor()
        self.setViewControllers(controllers, animated: true)
        self.selectedIndex = 1

        // Do any additional setup after loading the view.
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
