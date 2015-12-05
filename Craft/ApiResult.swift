//
//  ApiResult.swift
//  MagicDoor
//
//  Created by Novasoftware_Mac on 8/3/15.
//  Copyright (c) 2015 novasoftware. All rights reserved.
//

import Foundation

protocol IApiResult
{
    var success:Bool?{get set}
    var message:String?{get set}
}

class ApiResult:NSObject, IApiResult
{
    
    var success:Bool?
    var message:String?
}