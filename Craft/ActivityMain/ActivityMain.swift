//
//  ActivityMain.swift
//  Craft
//
//  Created by castiel on 15/11/28.
//  Copyright © 2015年 castiel. All rights reserved.
//

import UIKit

class ActivityMain: ViewControllerBase {
    
    var usertable : UITableView?
    var userTableSource : ActivityUserTableSource?

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let backButton = UIBarButtonItem()
        self.navigationItem.backBarButtonItem = backButton
        self.navigationItem.backBarButtonItem?.title = ""
        
        
        // Do any additional setup after loading the view.
    }
    
    override func initView() {
        setUserBaseInfoTable()
    }
    
    override func onLoad() {
        self.userTableSource = ActivityUserTableSource()
        self.usertable!.delegate = self.userTableSource!
        self.usertable!.dataSource = self.userTableSource!
        self.usertable!.reloadData()
    }
    
    func setUserBaseInfoTable(){
        self.usertable = UITableView(frame: CGRectMake(0, 84, self.view.frame.width, UIAdapter.shared.transferHeight(60)))
        self.view.addSubview(usertable!)
        self.usertable!.scrollEnabled = false
        self.usertable!.tableFooterView = UIView()
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
