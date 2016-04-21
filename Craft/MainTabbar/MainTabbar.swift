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
        
        let sliderMain = SliderMain(nibName: nil, bundle: nil)
        let sliderMainNav = UINavigationController(rootViewController: sliderMain)
        sliderMainNav.navigationBar.barTintColor = UIColor.whiteColor()
        
        let signView = SignUp(nibName: nil, bundle: nil)
        let signNav = UINavigationController(rootViewController: signView)
        signNav.navigationBar.barTintColor = UIColor.whiteColor()
        
        
        let controllers = [sliderMainNav,signNav]
        
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
