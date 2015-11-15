//
//  ChooseSide.swift
//  Craft
//
//  Created by castiel on 15/11/7.
//  Copyright © 2015年 castiel. All rights reserved.
//

import UIKit

class ChooseSide: ViewControllerBase {
    
    
    var sideCollection : UICollectionView?
    var source : ChooseSideCollectionSource?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor =  UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        // Do any additional setup after loading the view.
    }
    
    override func initView() {
        setSideCollection()
    }
    
    override func onLoad() {
        self.source = ChooseSideCollectionSource()
        self.source!._onRowSelected = self.sideSelected
        source!._itemsImages = ["tribe","alliance"]
        self.sideCollection!.dataSource = self.source!
        self.sideCollection!.delegate = self.source!
        self.sideCollection!.reloadData()
    }
    
    func setSideCollection(){
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: (self.view.frame.width - UIAdapter.shared.transferWidth(60)) / 2 , height: UIAdapter.shared.transferHeight(150))
        flowLayout.scrollDirection = .Vertical
        flowLayout.minimumInteritemSpacing = 0
        let collectViewCGRect = CGRectMake(UIAdapter.shared.transferWidth(30), 64 + UIAdapter.shared.transferHeight(100), self.view.frame.width - UIAdapter.shared.transferWidth(60), UIAdapter.shared.transferHeight(150))
        self.sideCollection = UICollectionView(frame: collectViewCGRect, collectionViewLayout: flowLayout)
        self.sideCollection!.backgroundColor = UIColor.clearColor()
        self.sideCollection!.registerClass(ChooseSideCollectionCell.self,
            forCellWithReuseIdentifier: "cell")
        self.sideCollection!.backgroundColor = UIColor.clearColor()
        self.view!.addSubview(sideCollection!)
    
    }
    
    func sideSelected(side : Int){
        
        self.dismissViewControllerAnimated(false) { () -> Void in
             NSNotificationCenter.defaultCenter().postNotificationName("AfterChooseSide", object: self)
        }
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
