

//
//  HttpRequest.h
//  NovaiOS
//
//  Created by hecq on 16/3/13.
//  Copyright © 2016年 hecq. All rights reserved.
//

@import AFNetworking;
#import "ApiResult.h"
#import <MJExtension/MJExtension.h>

@interface UploadParam : NSObject
/**
 *  图片的二进制数据
 */
@property (nonatomic, strong) NSData *data;
/**
 *  服务器对应的参数名称
 */
@property (nonatomic, copy) NSString *name;
/**
 *  文件的名称(上传到服务器后，服务器保存的文件名)
 */
@property (nonatomic, copy) NSString *filename;
/**
 *  文件的MIME类型(image/png,image/jpg等)
 */
@property (nonatomic, copy) NSString *mimeType;
@end
@class UploadParam;

/**
 *  网络请求类型
 */
typedef NS_ENUM(NSUInteger,HttpRequestType) {
    /**
     *  get请求
     */
    HttpRequestTypeGet = 0,
    /**
     *  post请求
     */
    HttpRequestTypePost
};

@interface RestService : NSObject


@property (nonatomic,copy)void(^TokenInvalidBlock)();

+(instancetype) getInstance;

-(void)setHeader:(NSDictionary *)headers;
//+(void)setBaseUrl:(NSString *)baseUrl;

-(ApiResult *)getNetworkFailResult;
-(ApiResult *)getSuccessResult;
-(NSString *)getUrl:(NSString *)resource;

/**
 *  发送get请求
 *
 *  @param URLString  请求的网址字符串
 *  @param parameters 请求的参数
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
- (void)get:(NSString *)resource
              parameters:(id)parameters
                 callback:(void (^)(ApiResult *result, id responseObject))callback;

/**
 *  发送post请求
 *
 *  @param URLString  请求的网址字符串
 *  @param parameters 请求的参数
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
-(void)post:(NSString *)resource
  parameters:(id)parameters
     callback:(void (^)(ApiResult *result, id responseObject))callback;

//初始化baseurl
+(void)configBaseUrl:(NSString*)baseUrl;

//设置当前afnetwork对象是否需要加accesstoken 供后台验证
+(void)setNeedAuthentication:(BOOL)authentication;


/**
 *  发送网络请求
 *
 *  @param URLString   请求的网址字符串
 *  @param parameters  请求的参数
 *  @param type        请求的类型
 *  @param resultBlock 请求的结果
 */
- (void)request:(NSString *)URLString
                  parameters:(id)parameters
                        type:(HttpRequestType)type
                     success:(void (^)(id responseObject))success
                     failure:(void (^)(NSError *error))failure;

/**
 *  上传图片
 *
 *  @param URLString   上传图片的网址字符串
 *  @param parameters  上传图片的参数
 *  @param uploadParam 上传图片的信息
 *  @param success     上传成功的回调
 *  @param failure     上传失败的回调
 */

-(void)setAccessToekn:(NSString*)accessToken;

-(NSString*)getAccessToekn;

- (void)upload:(NSString *)URLString
    parameters:(id)parameters
   uploadParam:(UploadParam *)uploadParam
      callback:(void (^)(ApiResult *result,id))callback;

@end

