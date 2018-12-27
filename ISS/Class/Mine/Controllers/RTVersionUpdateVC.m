//
//  RTVersionUpdateVC.m
//  ISS
//
//  Created by isoft on 2018/12/13.
//  Copyright © 2018 isoft. All rights reserved.
//

#import "RTVersionUpdateVC.h"

@interface RTVersionUpdateVC ()

@end

@implementation RTVersionUpdateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor redColor];
    btn.frame = CGRectMake(100, 200, 100, 30);
    [btn setTitle:@"版本更新" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnWithAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
   
}

- (void)btnWithAction:(UIButton *)sender {
    // 本地版本
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *locVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    //取出线上的版本号
    NSString *onlineVersion = @"4.1.5";
    switch ([self compareOnlineVersion:onlineVersion toVersion:locVersion]) {
        case -1:
        {
            NSLog(@"本地版本小于线上的版本，所以不弹出更新框");
        }
            break;
            
        case 0:
        {
            NSLog(@"本地版本和线上的版本是相等的，所以不弹出更新框");
        }
            break;
            
        case 1:
        {
            [self initAlertView];
        }
            break;
            
        default:
            break;
    }
}

- (void)initAlertView {
    [[ESAlert API] OkAlertWithTitle:@"新版本更新" message:@"优化相关问题，修改相关bug" :@"去更新" :@"暂不更新" vc:self sure:^{
        NSLog(@"点击去更新");
    }];
    
//    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"新版本更新" message:@"优化相关信息" preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"去更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//        //跳转到appStore 须真机测试看效果 适配8系统用这个老的跳转
//        //        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/app/id%@?mt=8", APPID]]];
//        //点击后还要重新弹出 始终在app视图上显示
//        NSLog(@"去更新====");
//    }];
//
//    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"暂不更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//        //异步操作吧 文件写入有点费时
//        NSLog(@"暂不更新");
//    }];
//    [alertVc addAction:ok];
//    [alertVc addAction:cancel];
//    [self presentViewController:alertVc animated:YES completion:nil];
}

/**
 版本比较方法
 
 @param versionOne  线上版本
 @param versionTwo 本地项目版本
 @return 比较结果
 */
- (NSComparisonResult)compareOnlineVersion:(NSString*)versionOne toVersion:(NSString*)versionTwo {
    NSArray* versionOneArr = [versionOne componentsSeparatedByString:@"."];
    NSArray* versionTwoArr = [versionTwo componentsSeparatedByString:@"."];
    NSInteger pos = 0;
    while ([versionOneArr count] > pos || [versionTwoArr count] > pos) {
        NSInteger v1 = [versionOneArr count] > pos ? [[versionOneArr objectAtIndex:pos] integerValue] : 0;
        NSInteger v2 = [versionTwoArr count] > pos ? [[versionTwoArr objectAtIndex:pos] integerValue] : 0;
        if (v1 < v2) {
            //版本2大
            return NSOrderedAscending;
        } else if (v1 > v2) {
            //版本1大
            return NSOrderedDescending;
        }
        pos++;
    }
    //版本相同
    return NSOrderedSame;
}


@end
