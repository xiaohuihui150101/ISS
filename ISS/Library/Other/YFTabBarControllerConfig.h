//
//  YFTabBarControllerConfig.h
//  ISS-ISPS-USER
//
//  Created by isoft on 2018/12/5.
//  Copyright © 2018 isoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YFTabBerViewController.h"

@interface YFBaseNavigationController : UINavigationController

@end


@interface YFTabBarControllerConfig : NSObject
@property (nonatomic, readonly, strong) YFTabBerViewController *tabBarController;
@end
