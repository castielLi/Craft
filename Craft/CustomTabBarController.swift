//
//  CustomTabBarController.swift
//  Craft
//
//  Created by castiel on 16/1/17.
//  Copyright © 2016年 castiel. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {

    var backGroundImage : UIImageView?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func addCustomElements(){
         self.backGroundImage = UIImageView(frame: CGRectMake(0, self.view.frame.height -  60, self.view.frame.width, 60))
         self.backGroundImage!.image = UIImage(named: "")
         self.view.addSubview(self.backGroundImage!)
    }
}
