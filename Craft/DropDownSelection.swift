//
//  DropDownSelection.swift
//  Craft
//
//  Created by castiel on 16/4/22.
//  Copyright © 2016年 castiel. All rights reserved.
//

import UIKit

class DropDownSelection: ViewControllerBase {
    
    var mainView : UIView?

    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView = UIView(frame: CGRect(x: UIAdapter.shared.transferWidth(20) , y: UIAdapter.shared.transferHeight(100), width: self.view.frame.size.width - UIAdapter.shared.transferWidth(40) , height: UIAdapter.shared.transferHeight(250)))

        self.view.addSubview(self.mainView!)
                
        let beffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        let view = UIVisualEffectView(effect: beffect)
        
        view.frame = self.mainView!.bounds
        self.mainView!.addSubview(view)

        
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
