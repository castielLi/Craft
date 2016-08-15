//
//  ActivityDetailFooterEvent.swift
//  Craft
//
//  Created by castiel on 16/8/8.
//  Copyright © 2016年 castiel. All rights reserved.
//

import Foundation

extension MyActivities{
   
    func chatClick(indexPath:Int){
       print("chat")
    }
    
    func infoClick(indexPath : Int){
       print("info")
    }
    
    func addClick(indexPath : Int){
       print("add")
    }
    
    func inviteClick(indexPath : Int){
        print("invite")
        
        self.showProgress()
        
        let activityId = dataModel!.activity!.activityId
        let requestUserId = applylistSource![indexPath].valueForKey("userId") as! String
        self.service!.applyRequest(activityId, requestUserId: requestUserId,index: "\(indexPath)")
        
        
    }
    
    func refusesClick(indexPath : Int){
        print("refuses")
        
        self.showProgress()
        
        let activityId = dataModel!.activity!.activityId
        let requestUserId = applylistSource![indexPath].valueForKey("userId") as! String
        self.service!.refuseRequest(activityId, requestUserId: requestUserId,index: "\(indexPath)")
    }
    
    func DealApplyRequestFinish(result: ApiResult!, response: AnyObject!, index: String!) {
        self.closeProgress()
        if(result.state){
            MsgBoxHelper.show("", message: "操作成功")
            self.applylistSource!.removeObject(applylistSource![ Int(index)! ])
            self.table!.reloadData()
        }else{
            MsgBoxHelper.show("", message: "操作失败")
        }
    }
    

    
    
    func releaseClick(indexPath : Int , setAssist: Bool){
        print("release")
        
        if setAssist{
           
        }
        
    }
    
    func kickClick(indexPath: Int){
       self.playerListSource!.removeObject(playerListSource![indexPath])
       
//       self.table!.deleteRowsAtIndexPaths([ NSIndexPath(forRow: indexPath, inSection: 0) ], withRowAnimation: UITableViewRowAnimation.Left)
        self.table!.reloadData()
       
    }
    
}