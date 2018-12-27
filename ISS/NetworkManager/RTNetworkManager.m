//
//  RTNetworkManager.m
//  ISS
//
//  Created by isoft on 2018/12/17.
//  Copyright © 2018 isoft. All rights reserved.
//

#import "RTNetworkManager.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import <AFNetworking.h>
#import <sys/utsname.h>

#define kTimeOutInterval 15

@implementation RTNetworkManager

+ (AFHTTPSessionManager *)shareSessionManager
{
    static AFHTTPSessionManager *shareManager = nil;
    static dispatch_once_t onceToken;
    mWeakSelf
    dispatch_once(&onceToken, ^{
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL: [NSURL URLWithString:N_HostSiteMain]];
        [manager setSecurityPolicy:[weakSelf customSecurityPolicy]];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"text/html", @"text/plain", @"text/json", @"text/javascript", @"application/json", @"application/xml"]];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.requestSerializer.timeoutInterval = 15;
        shareManager = manager;
    });
    return shareManager;
}

+ (AFSecurityPolicy*)customSecurityPolicy
{
    // /先导入证书
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"avantouch" ofType:@"cer"];//证书的路径
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    
    // AFSSLPinningModeCertificate 使用证书验证模式
    //    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    AFSecurityPolicy *securityPolicy;
    // allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    // 如果是需要验证自建证书，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    
    //validatesDomainName 是否需要验证域名，默认为YES；
    //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
    //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    //如置为NO，建议自己添加对应域名的校验逻辑。
    securityPolicy.validatesDomainName = NO;
    
    securityPolicy.pinnedCertificates = [NSSet setWithObjects:certData, nil];
    
    return securityPolicy;
}

+ (NSURLSessionDataTask *)GET:(NSString *)hostString
                       params:(NSDictionary *)params
                      success:(RTNetWordSuccess)success
                      failure:(RTNetWordFailure)failure
{
    NSString *urlString = [NSString stringWithFormat:@"%@",hostString];
    if ([hostString hasPrefix:@"http"]) {
        
    }else {
        
        urlString = [NSString stringWithFormat:@"%@%@", N_HostSiteMain, hostString];
        
    }
    AFHTTPSessionManager *manager = [self shareSessionManager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    return [manager GET:urlString
             parameters:params
               progress:nil
                success:^(NSURLSessionDataTask * task, id responseObject){
                    NSError *jsonError = nil;
                    NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&jsonError];
                    if ([responseDic isKindOfClass:[NSDictionary class]]) {
                        success(task, responseObject);
                    } else {
                        success(task, responseObject);
                    }
                } failure:failure];
}

+ (NSURLSessionDataTask *)POST:(NSString *)hostString params:(NSDictionary *)params success:(RTNetWordSuccess)success failure:(RTNetWordFailure)failure
{
    NSMutableDictionary *paramsDic = (params?:@{}).mutableCopy;
    NSString *urlString = [NSString stringWithFormat:@"%@",hostString];
    
    if ([hostString hasPrefix:@"http"]) {
    }else {
        urlString = [NSString stringWithFormat:@"%@%@", N_HostSiteMain, hostString];
    }
    AFHTTPSessionManager *manager = [self shareSessionManager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //验证token
    return [manager POST:urlString
              parameters:paramsDic
                progress:nil
                 success:^(NSURLSessionDataTask * task, id responseObject){
                     NSError *jsonError = nil;
                     NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&jsonError];
                     if ([responseDic isKindOfClass:[NSDictionary class]]) {
                         //特殊错误码判断
                         success(task, responseObject);
                     } else {
                         success(task, responseObject);
                     }
                 } failure:failure];
}

#pragma mark - 多图上传
/***
 * 图片上传
 **/
+ (void)uploadImages:(NSArray *)imageArray
           urlString:(NSString *)urlString
              params:(NSDictionary *)params
         targetWidth:(float)width
        successBlock:(RTNetWordSuccess)successBlock
         failurBlock:(RTNetWordFailure)failureBlock
            progress:(RTUploadProgress)progress;
{
    NSString *hostString = [NSString stringWithFormat:@"%@",urlString];
    
    if ([urlString hasPrefix:@"http"]) {
    }else {
        hostString = [NSString stringWithFormat:@"%@%@", N_HostSiteMain, urlString];
        
    }
    //1.创建管理者对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"text/html", @"text/plain", @"text/json", @"text/javascript", @"application/json", @"application/xml"]];
    
    
    [manager POST:hostString parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSUInteger i = 0 ;
        /**出于性能考虑,将上传图片进行压缩*/
        for (NSData * imageData in imageArray) {
            //拼接data
            [formData appendPartWithFileData:imageData name:@"file" fileName:@"something.jpg" mimeType:@"image/jpeg"];
            i++;
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"%lld/%lld",uploadProgress.completedUnitCount ,uploadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
        successBlock(task, responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(task, error);
    }];
    
}

/***
 * 文件上传
 **/
+ (void)upLoadToUrlString:(NSString *)url
               parameters:(NSDictionary *)parameters
                 fileData:(NSData *)fileData
                     name:(NSString *)name
                 fileName:(NSString *)fileName
                 mimeType:(NSString *)mimeType
                 progress:(void (^)(NSProgress *))progress
                  success:(void (^)(NSURLSessionDataTask *, id))success
                  failure:(void (^)(NSURLSessionDataTask *, NSError *))failure {
    NSString *hostString = [NSString stringWithFormat:@"%@",url];
    if ([url hasPrefix:@"http"]) {
    }else {
        hostString = [NSString stringWithFormat:@"%@%@", N_HostSiteMain, url];
    }
    //1.创建管理者对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"text/html", @"text/plain", @"text/json", @"text/javascript", @"application/json", @"application/xml"]];
    [manager POST:hostString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:fileData name:name fileName:fileName mimeType:mimeType];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(task, responseObject);
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(task, error);
        }
        
    }];
}

#pragma mark - 取消所有的网络请求

+ (void)cancelAllRequest
{
    [[self shareSessionManager].operationQueue cancelAllOperations];
}

#pragma mark - 取消指定的url请求/

+ (void)cancelHttpRequestWithRequestType:(NSString *)requestType
                        requestUrlString:(NSString *)string
{
    NSError * error;
    /**根据请求的类型 以及 请求的url创建一个NSMutableURLRequest---通过该url去匹配请求队列中是否有该url,如果有的话 那么就取消该请求*/
    NSString * urlToPeCanced = [[[[AFHTTPSessionManager manager].requestSerializer requestWithMethod:requestType URLString:string parameters:nil error:&error] URL] path];
    for (NSOperation * operation in [AFHTTPSessionManager manager].operationQueue.operations) {
        //如果是请求队列
        if ([operation isKindOfClass:[NSURLSessionTask class]]) {
            //请求的类型匹配
            BOOL hasMatchRequestType = [requestType isEqualToString:[[(NSURLSessionTask *)operation currentRequest] HTTPMethod]];
            //请求的url匹配
            BOOL hasMatchRequestUrlString = [urlToPeCanced isEqualToString:[[[(NSURLSessionTask *)operation currentRequest] URL] path]];
            //两项都匹配的话  取消该请求
            if (hasMatchRequestType&&hasMatchRequestUrlString) {
                [operation cancel];
            }
        }
    }
}
/*********
 * 图片上传的接口
 * uploadImages        上传图片的data文件，可以是多个也可以单个
 * urlString           上传图片的url
 * params              传参。file：data  fileType：类型
 * targetWidth         传进入图片的比例
 ****/
+ (RACSignal *)rac_uploadImages:(NSArray *)uploadImages
                      urlString:(NSString *)urlString
                         params:(NSDictionary *)params
                    targetWidth:(float)targetWidth
{
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        //这个上传接口格式不统一
        [self uploadImages:uploadImages urlString:urlString params:params targetWidth:targetWidth successBlock:^(NSURLSessionDataTask *task, id responseObject) {
            
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                
                NSError *jsonError = nil;
                NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&jsonError];
                if ([responseDic isKindOfClass:[NSDictionary class]]) {
                    NSString *errorCode = responseDic[@"e"][@"code"];
                    if (errorCode.integerValue == 0) {
                        [subscriber sendNext:responseDic];
                        [subscriber sendCompleted];
                    } else {
                        [subscriber sendError:[NSError errorWithDomain:responseDic[@"e"][@"desc"] code:0 userInfo:@{NSLocalizedDescriptionKey: responseDic[@"e"][@"desc"]?: @"未知网络错误"}]];
                    }
                }else{
                    [subscriber sendError:jsonError];
                }
            }else if ([responseObject isKindOfClass:[NSArray class]]) {
                [subscriber sendNext:responseObject];
                [subscriber sendCompleted];
            }
            
        } failurBlock:^(NSURLSessionDataTask *task, NSError *error) {
            NSError *newError = [NSError errorWithDomain:error.localizedDescription code:error.code userInfo:@{NSLocalizedDescriptionKey: @"网络错误,请稍后重试"}];
            [subscriber sendError:newError];
        } progress:^(float progress) {
            
        }];
        
        return [RACDisposable disposableWithBlock:^{
        }];
    }];
    return signal;
}

/********
 *
 *  图片上传的接口
 *  imgData      上传图片的二进制文件
 *  urlString    上传图片的url(接口的url)
 *
 ****/

+ (RACSignal *)upLoadImageData:(NSData *)imgData urlString:(NSString *)urlString {
    NSDictionary * dic = @{@"file":imgData,@"fileType":@"1"};
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [[RTNetworkManager rac_uploadImages:@[imgData] urlString:urlString params:dic targetWidth:1.0] subscribeNext:^(id  _Nullable x) {
            [subscriber sendNext:x];
            [subscriber sendCompleted];
        } error:^(NSError * _Nullable error) {
            NSError *newError = [NSError errorWithDomain:error.localizedDescription code:error.code userInfo:@{NSLocalizedDescriptionKey: @"网络错误,请稍后重试"}];
            [subscriber sendError:newError];
        }];
        return [RACDisposable disposableWithBlock:^{
        }];
    }];
    return signal;
}


#pragma mark ---------------RAC-------------------------
/*******
 *
 * RAC 控制的get请求方式
 *
 ***/
+ (RACSignal *)rac_GET:(NSString *)hostString params:(NSDictionary *)params{
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [self GET:hostString params:params success:^(NSURLSessionDataTask *task, id responseObject) {
            NSError *jsonError = nil;
            NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&jsonError];
            if ([responseDic isKindOfClass:[NSDictionary class]]) {
                NSString *errorCode = responseDic[@"e"][@"code"];
                if (errorCode.integerValue == 0) {
                    [subscriber sendNext:responseDic];
                    [subscriber sendCompleted];
                } else {
                    [subscriber sendError:[NSError errorWithDomain:responseDic[@"e"][@"desc"] code:0 userInfo:@{NSLocalizedDescriptionKey: responseDic[@"e"][@"desc"]?: @"未知网络错误"}]];
                }
            }else{
                [subscriber sendError:jsonError];
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [subscriber sendError:error];
        }];
        return [RACDisposable disposableWithBlock:^{
            
        }];
    }];
    return signal;
}

+ (RACSignal *)rac_GET:(NSString *)urlString dict:(NSDictionary *)params {
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [self GET:urlString params:params success:^(NSURLSessionDataTask *task, id responseObject) {
            NSError *jsonError = nil;
            NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&jsonError];
            if ([responseDic isKindOfClass:[NSDictionary class]]) {
                NSString *errorCode = responseDic[@"code"];
                if (errorCode.integerValue == 200) {
                    [subscriber sendNext:responseDic];
                    [subscriber sendCompleted];
                } else {
                    [subscriber sendError:[NSError errorWithDomain:responseDic[@"message"] code:0 userInfo:@{NSLocalizedDescriptionKey:responseDic[@"message"]?:@"未知网络错误"}]];
                }
            } else {
                [subscriber sendError:jsonError];
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
        
        return [RACDisposable disposableWithBlock:^{
            
        }];
    }];
    return signal;
}
/*******
 *
 * RAC 控制的post请求方式
 *
 ***/
+ (RACSignal *)rac_POST:(NSString *)hostString params:(NSDictionary *)params
{
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [self POST:hostString params:params success:^(NSURLSessionDataTask *task, id responseObject) {
            NSError *jsonError = nil;
            NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&jsonError];
            if ([responseDic isKindOfClass:[NSDictionary class]]) {
                NSString *errorCode = responseDic[@"e"][@"code"];
                if (errorCode.integerValue == 0) {
                    [subscriber sendNext:responseDic];
                    [subscriber sendCompleted];
                } else {
                    NSLog(@"%@",hostString);
                    [subscriber sendError:[NSError errorWithDomain:responseDic[@"e"][@"desc"] ?: @"" code:errorCode.integerValue userInfo:@{NSLocalizedDescriptionKey: responseDic[@"e"][@"desc"]?: @"未知网络错误"}]];
                }
            }else{
                [subscriber sendError:jsonError];
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSError *newError = [NSError errorWithDomain:error.localizedDescription code:error.code userInfo:@{NSLocalizedDescriptionKey: @"网络错误,请稍后重试"}];
            
            [subscriber sendError:newError];
        }];
        return [RACDisposable disposableWithBlock:^{
            
        }];
    }];
    return signal;
}

+ (RACSignal *)rac_POST:(NSString *)urlString dict:(NSDictionary *)params {
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [self POST:urlString params:params success:^(NSURLSessionDataTask *task, id responseObject) {
            NSError *jsonError = nil;
            NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&jsonError];
            if ([responseDic isKindOfClass:[NSDictionary class]]) {
                NSString *errorCode = responseDic[@"e"][@"code"];
                if (errorCode.integerValue == 0) {
                    [subscriber sendNext:responseDic];
                    [subscriber sendCompleted];
                } else {
                    NSLog(@"%@",urlString);
                    [subscriber sendError:[NSError errorWithDomain:responseDic[@"e"][@"desc"] ?: @"" code:errorCode.integerValue userInfo:@{NSLocalizedDescriptionKey: responseDic[@"e"][@"desc"]?: @"未知网络错误"}]];
                }
            } else{
                [subscriber sendError:jsonError];
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSError *newError = [NSError errorWithDomain:error.localizedDescription code:error.code userInfo:@{NSLocalizedDescriptionKey: @"网络错误,请稍后重试"}];
            
            [subscriber sendError:newError];
        }];
        return [RACDisposable disposableWithBlock:^{
            
        }];
    }];
    return signal;
}


+ (RACSignal *)discoverHotRangeDict:(NSDictionary *)dict {
    return [RTNetworkManager rac_GET:@"/movision/app/discover2/hot_range" dict:dict];
}



@end
