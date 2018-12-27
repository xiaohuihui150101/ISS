//
//  RTNetworkManager.h
//  ISS
//
//  Created by isoft on 2018/12/17.
//  Copyright © 2018 isoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


#ifndef RTNetworkManager_h
#define RTNetworkManager_h

//请求成功
typedef void (^RTNetWordSuccess)(NSURLSessionDataTask * task, id responseObject);
//请求失败
typedef void (^RTNetWordFailure)(NSURLSessionDataTask * task, NSError * error);

typedef void (^RTNetWordResult)(id data, NSError *error);
//上传的进度
typedef void (^RTUploadProgress)(float progress);
//下载的进度
typedef void (^RTDownloadProgress)(float progress);

#endif

NS_ASSUME_NONNULL_BEGIN

@interface RTNetworkManager : NSObject

+ (NSURLSessionDataTask *)GET:(NSString *)hostString params:(NSDictionary *)params success:(RTNetWordSuccess)success failure:(RTNetWordFailure)failure;

+ (NSURLSessionDataTask *)POST:(NSString *)hostString params:(NSDictionary *)params success:(RTNetWordSuccess)success failure:(RTNetWordFailure)failure;

+ (void)uploadImages:(NSArray *)imageArray
           urlString:(NSString *)urlString
              params:(NSDictionary *)params
         targetWidth:(float)width
        successBlock:(RTNetWordSuccess)successBlock
         failurBlock:(RTNetWordFailure)failureBlock
            progress:(RTUploadProgress)progress;

//+ (void)downloadFileWithSavaPath:(NSString *)savePath
//                       urlString:(NSString *)urlString
//                          result:(RTNetWordResult)resultBlock
//                        progress:(RTDownloadProgress)progress;

/**
 *  取消所有的网络请求
 */
+ (void)cancelAllRequest;

/**
 *  取消指定的url请求
 *
 *  @param requestType 该请求的请求类型
 *  @param string      该请求的完整url
 */

+ (void)cancelHttpRequestWithRequestType:(NSString *)requestType requestUrlString:(NSString *)string;

/**
 上传文件接口
 @param url 服务器地址
 @param parameters 字典 token
 @param fileData 要上传的数据
 @param name 服务器参数名称 @"file"
 @param fileName 文件名称 图片:xxx.jpg,xxx.png 视频:video.mp4
 @param mimeType 文件类型 图片:image/jpeg,image/png 视频:mp4->video/mpeg4  可参考网上对照表
 @param progress 上传进度
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)upLoadToUrlString:(NSString *)url parameters:(NSDictionary *)parameters fileData:(NSData *)fileData name:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType progress:(void (^)(NSProgress *progress))progress success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

@end


@interface RTNetworkManager (RAC)

/// RAC Post请求
+ (RACSignal *)rac_POST:(NSString *)hostString params:(NSDictionary *)params;

/// RAC Get请求
+ (RACSignal *)rac_GET:(NSString *)hostString params:(NSDictionary *)params;

+ (RACSignal *)rac_GET:(NSString *)urlString dict:(NSDictionary *)params;

//http://51mofo.com/movision/app/discover2/hot_range?pageNo=1&pageSize=10&type=0&title=0
+ (RACSignal *)discoverHotRangeDict:(NSDictionary *)dict;

@end


NS_ASSUME_NONNULL_END
