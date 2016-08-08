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
        
        self.applylistSource!.removeObject(applylistSource![indexPath])
        
        self.table!.reloadData()
    }
    
    func refusesClick(indexPath : Int){
        print("refuses")
        
        self.applylistSource!.removeObject(applylistSource![indexPath])
        
        self.table!.reloadData()
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