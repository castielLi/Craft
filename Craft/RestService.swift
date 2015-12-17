//
//  RestService.swift
//  MagicDoor
//
//  Created by Novasoftware_Mac on 8/3/15.
//  Copyright (c) 2015 novasoftware. All rights reserved.
//
import Foundation
import AFNetworking
import XCGLogger
import Alamofire

let _sharedService: RESTService = { RESTService() }()
let _baseUrl = "115.120.172.191/wow"
//let _baseUrl = "http://10.10.120.95:86/api"


class RESTService {
    class func sharedInstance() -> RESTService {
        return _sharedService
    }
    
    var access_token:String?
    var alamofireManager : Alamofire.Manager?
    let log = XCGLogger()
    var configuration:NSURLSessionConfiguration?
    var headers = Alamofire.Manager.sharedInstance.session.configuration.HTTPAdditionalHeaders ?? [:]

    init()
    {
        access_token = ""
        self.headers["Content-Type"] = "application/json"
        self.headers["access_token"] = access_token
        configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        Alamofire.Manager.sharedInstance.session.configuration.HTTPAdditionalHeaders = headers

        configuration!.timeoutIntervalForResource = 15 // seconds
        
        self.alamofireManager = Alamofire.Manager(configuration: configuration!)
        self.alamofireManager!.request(.GET, "http://example.com/")
    }
    
    func setHeader( access_token :String){
        self.access_token = access_token
        self.headers["Content-Type"] = "application/json"
        self.headers["access_token"] = access_token
        Alamofire.Manager.sharedInstance.session.configuration.HTTPAdditionalHeaders = headers
    }
    
    func getHeader() -> NSObject{
        return self.headers
    }
    
    func getUrl(resource:String)->String
    {
        return _baseUrl + resource
    }
    
    func getNetWorkFailResult()->ApiResult{
    
        let apiresult = ApiResult()
        apiresult.success = false
        apiresult.message = "网络请求失败"
        return apiresult
    }
    
    func getUploadFailResult()->ApiResult{
        
        let apiresult = ApiResult()
        apiresult.success = false
        apiresult.message = "没有找到相关的文件"
        return apiresult
    }
    
    func getApiResult(success:Bool,message:String?)->ApiResult
    {
        let apiResult = ApiResult()
        apiResult.success = success
        apiResult.message = message
        return apiResult
    }
    
    func performGET(resource: String, parameters:NSDictionary?, completionHandler: ((result:ApiResult,data:AnyObject?) -> Void)?) {

        let handler = completionHandler
        //var paramDict = pr
        let  afManager = AFHTTPRequestOperationManager()
        afManager.requestSerializer = AFJSONRequestSerializer()
      // afManager.requestSerializer.setValue(access_token, forKey: "access_token")
        let url = getUrl(resource)
        let op =  afManager.GET(url,
            parameters:parameters,
            success: {  (operation: AFHTTPRequestOperation!,responseObject: AnyObject!) in
                
                do {
                    let result: AnyObject! = try NSJSONSerialization.JSONObjectWithData(responseObject as! NSData, options: NSJSONReadingOptions.AllowFragments)
                    
                    let apiResult = result as! ApiResult
                    //处理数据
                    if(!apiResult.success!)
                    {
                        
                        handler!(result: apiResult,data:result)
                    }
                    else
                    {
                        // var tapiResult:T = result as! T;
                        handler!(result: apiResult,data:result);
                    }

                }catch {
                   
                }
        
            },
            failure: {  (operation: AFHTTPRequestOperation?,error: NSError) in
                print("请求错误Error: " + error.localizedDescription)
                let failResult = self.getNetWorkFailResult()
                handler!(result:failResult,data:nil)
                
        })
        
        op!.responseSerializer = AFHTTPResponseSerializer()
        op!.start()
    }
    
    func performPOST(resource: String, parameters: NSDictionary, completionHandler: ((result:ApiResult,data:AnyObject?) -> Void)?) {
      
        
        let handler = completionHandler
        let paramDict = parameters
        let  afManager = AFHTTPRequestOperationManager()
     
       // afManager.
        afManager.requestSerializer = AFJSONRequestSerializer()
       

        
        let url = getUrl(resource)
        let op =  afManager.POST(url,
            parameters:paramDict,
            success: {  (operation: AFHTTPRequestOperation!,responseObject: AnyObject!) in
                do {
                let result: AnyObject! = try NSJSONSerialization.JSONObjectWithData(responseObject as! NSData, options: NSJSONReadingOptions.AllowFragments)
                
                let nsResult = result as! NSDictionary;
                
                var success:Bool = nsResult["Success"] as! Bool
                var message:String? = nsResult["Description"] as? String
                
                let apiResult = self.getApiResult(true,message:message);
                //处理数据
                if(!apiResult.success!)
                {
                    handler!(result: apiResult,data:result)
                }
                else
                {
                    //var tapiResult:T = result as! T
                    
                    handler!(result: apiResult,data:result)
                    }
                }catch {
                
                }
            },
            failure: {  (operation: AFHTTPRequestOperation?,error: NSError!) in
                print("请求错误Error: " + error.localizedDescription)
                let failResult = self.getNetWorkFailResult()
                handler!(result:failResult,data:nil)
                
        })
       
       // log.info(info)
        op!.responseSerializer = AFHTTPResponseSerializer()
        op!.start()
    }
    
    
    func alamofirePost(resource: String, parameters: [String: AnyObject]?, completionHandler: ((result:ApiResult,data:AnyObject?) -> Void)?) {
        
        let handler = completionHandler

        
        var url = getUrl(resource)
        
        self.alamofireManager!
        .request(.POST, url,parameters:parameters , encoding: .JSON , headers: self.headers as! [String: String])
            .validate(contentType: ["application/json"])
            .responseJSON{ json in
                print("res data:",json)
                
//                if(json. == nil)
//                {
//                    var result: AnyObject! = json
//                    var nsResult = result as? NSDictionary;
//                    if(nsResult == nil)
//                    {
//                        var failResult = self.getNetWorkFailResult()
//                        handler!(result:failResult,data:nil)
//                        return
//                    }
//                    
//                    var successData = nsResult!["Success"] as? Bool
//                    if successData == nil{
//                        var failResult = self.getNetWorkFailResult()
//                        handler!(result:failResult,data:nil)
//                    }else{
//                    
//                    var success:Bool = successData!
//                    var message:String? = nsResult!["Description"] as! String?
//                    
//                    var apiResult = self.getApiResult(success,message:message);
//                    //处理数据
//                    if(!apiResult.success!)
//                    {
//                        handler!(result: apiResult,data:result)
//                    }
//                    else
//                    {
//                        //var tapiResult:T = result as! T
//                        
//                        handler!(result: apiResult,data:result)
//                    }
//                  }
//                }
//                else
//                {
//                    var failResult = self.getNetWorkFailResult()
//                    handler!(result:failResult,data:nil)
//                }
//                
                
        }
     
   }
    
    
//    func alamofireUpload (resource: String , fileName : String, fileExtension : String, completionHandler: ((result:ApiResult,data:AnyObject?) -> Void)?){
//        let handler = completionHandler
//
//        var url = getUrl(resource)
//        var paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
//        
//        var getFilePath = paths.stringByAppendingPathComponent("\(fileName).\(fileExtension)")
//        
//        
//        var checkValidation = NSFileManager.defaultManager()
//        
//        if (checkValidation.fileExistsAtPath(getFilePath))
//        {
//            var fileURL  = NSURL(fileURLWithPath: getFilePath)
//            var fileData = NSData(contentsOfURL: fileURL!)
//
//            
//            self.alamofireManager!.upload(.POST, url,
//                multipartFormData: { multipartFormData in
//                multipartFormData.appendBodyPart(data: fileData!, name: "\(fileName)")
//                }
//                ,
//                encodingCompletion: { encodingResult in
//                    switch encodingResult {
//                    case .Success(let upload, _, _):
//                        upload.responseJSON { request, response, json, error in
//                            if(error == nil)
//                            {
//                                var result: AnyObject! = json
//                                var nsResult = result as? NSDictionary;
//                                if(nsResult == nil)
//                                {
//                                    var failResult = self.getNetWorkFailResult()
//                                    handler!(result:failResult,data:nil)
//                                    return
//                                }
//                                
//                                var successData = nsResult!["Success"] as? Bool
//                                if successData == nil{
//                                    var failResult = self.getNetWorkFailResult()
//                                    handler!(result:failResult,data:nil)
//                                }else{
//                                    
//                                    var success:Bool = successData!
//                                    var message:String? = nsResult!["Description"] as! String?
//                                    
//                                    var apiResult = self.getApiResult(success,message:message);
//                                    //处理数据
//                                    if(!apiResult.success!)
//                                    {
//                                        handler!(result: apiResult,data:result)
//                                    }
//                                    else
//                                    {
//                                        //var tapiResult:T = result as! T
//                                        
//                                        handler!(result: apiResult,data:result)
//                                    }
//                                }
//                            }else{
//                                var failResult = self.getNetWorkFailResult()
//                                handler!(result:failResult,data:nil)
//                            }
//
//                        }
//                    case .Failure(let encodingError):
//                        var failResult = self.getUploadFailResult()
//                        handler!(result:failResult,data:nil)
//                    }
//            })
//        }
//        else
//        {
//            var failResult = self.getUploadFailResult()
//            handler!(result:failResult,data:nil)
//        }
//        
//    }
    
}
