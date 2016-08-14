//
//  ProfessionHelper.swift
//  Craft
//
//  Created by castiel on 16/8/7.
//  Copyright © 2016年 castiel. All rights reserved.
//

import UIKit

class ProfessionHelper {
    
    static func getProfressionImage(type : Int, profression : Int)->UIImage{
        if(type == 0){
           return getTankProfessionImage(profression)
        }else if(type == 1){
           return getHealProfessionImage(profression)
        }else if (type == 2){
           return getDpsProfessionImage(profression)
        }else{
           return getDistranceDpsProfessionImage(profression)
        }
    }
    

    static func getTankProfessionImage(type : Int)->UIImage{
        switch type {
        case 1:
            return UIImage(named: "zs")!
        case 2:
            return UIImage(named: "qs")!
        case 3:
            return UIImage(named: "dk")!
        case 6:
            return UIImage(named: "d")!
        case 8:
            return UIImage(named: "ws")!
        default:
            return UIImage(named: "dh")!
            //恶魔猎手
        }
    }
    
    static func getHealProfessionImage(type : Int)->UIImage{
        switch type {
        case 2:
            return UIImage(named: "qs")!
        case 4:
            return UIImage(named: "sm")!
        case 8:
            return UIImage(named: "ws")!
        case 11:
            return UIImage(named: "ms")!
        default:
            return UIImage(named: "d")!
        }
    }
    
    static func getDpsProfessionImage(type : Int)->UIImage{
        switch type {
        case 1:
            return UIImage(named: "zs")!
        case 2:
            return UIImage(named: "qs")!
        case 3:
            return UIImage(named: "dk")!
        case 4:
            return UIImage(named: "sm")!
        case 6:
            return UIImage(named: "d")!
        case 7:
            return UIImage(named: "dz")!
        case 8:
            return UIImage(named: "ws")!
        default:
            return UIImage(named: "dh")!
            //恶魔猎手
        }
    }
    
    static func getDistranceDpsProfessionImage(type : Int)->UIImage{
        switch type {
        case 4:
            return UIImage(named: "sm")!
        case 5:
            return UIImage(named: "lr")!
        case 6:
            return UIImage(named: "d")!
        case 11:
            return UIImage(named: "ms")!
        case 12:
            return UIImage(named: "ss")!
        default:
            return UIImage(named: "fs")!
        }
    }

}
