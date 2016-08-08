//
//  ProfessionHelper.swift
//  Craft
//
//  Created by castiel on 16/8/7.
//  Copyright © 2016年 castiel. All rights reserved.
//

import UIKit

class ProfessionHelper {
    
    static func getProfessionTypeImage(type : Int)->UIImage{
        switch type {
        case 0:
            return UIImage(named: "zs")!
        case 1:
            return UIImage(named: "qs")!
        default:
            return UIImage(named: "dk")!
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
            return UIImage(named: "dk")!
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
    
    static func getDistranceDpsProfessionImage(type : Int)->UIImage{
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
            return UIImage(named: "dk")!
            //恶魔猎手
        }
    }
    
    static func getDpsProfessionImage(type : Int)->UIImage{
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
