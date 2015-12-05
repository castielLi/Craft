//
//  LoginService.swift
//  Craft
//
//  Created by castiel on 15/12/5.
//  Copyright © 2015年 castiel. All rights reserved.
//

import Foundation
import SwiftyJSON

class LoginService{
    
    var _restService:RESTService?
    
    init()
    {
        _restService = RESTService.sharedInstance();
    }
    
    func checkUpdate(handler:((result:ApiResult,data:AnyObject?) -> Void)?){
        
        //需要补充应用程序的id
        //       _restService!.performGET("http://itunes.apple.com/lookup?id=", parameters: nil , completionHandler : {(result:ApiResult,data:AnyObject?) in
        //
        //        })
    }
    
    
    func login(phoneNumber:String,pwd:String,handler:((result:ApiResult) -> Void)?)
    {
        let parameters = ["phoneNumber":phoneNumber,"Password":pwd.md5]
        
        _restService!.alamofirePost("/Account/Login",parameters: parameters,completionHandler:{(result:ApiResult,data:AnyObject?) in
            if(result.success!)
            {
                let token: AnyObject = data!.objectForKey("AccessToken")!
                self._restService!.setHeader(token as! String)
                if token.count > 0 {
                    
                }
                print(self._restService!.getHeader())
               
            }else{
                handler!(result: result)
            }
        })
    }
    
}