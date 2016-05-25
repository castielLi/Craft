//
//  RestService.swift
//  MagicDoor
//
//  Created by Novasoftware_Mac on 8/3/15.
//  Copyright (c) 2015 novasoftware. All rights reserved.
//
import Foundation
import AFNetworking

private let _sharedService: RESTService = { RESTService() }()
let _baseUrl = "162.243.241.80:8080/wow/api"
//let _baseUrl = "http://10.10.120.95:86/api"


class RESTService {
    class func sharedInstance() -> RESTService {
        return _sharedService
    }
    
    var access_token:String?
    var configuration:NSURLSessionConfiguration?

    init()
    {
        configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        configuration!.timeoutIntervalForResource = 15 // seconds
        
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
    
    func alamofirePost(resource: String, parameters: [String: AnyObject]?, completionHandler: ((result:ApiResult,data:AnyObject?) -> Void)?) {
        
        let handler = completionHandler
        let url = getUrl(resource)
        
        configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        configuration!.timeoutIntervalForResource = 15 // seconds

        let manage = AFURLSessionManager(sessionConfiguration: configuration!)
        
        
        let request = AFJSONRequestSerializer().requestWithMethod("POST", URLString: url, parameters: parameters!)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let dataTask = manage.dataTaskWithRequest(request) { (response, responseObject, error) -> Void in
            if ((error) != nil) {
                print(error)
            } else {
                print(responseObject)
            }
        }
        dataTask.resume()
   }
}



