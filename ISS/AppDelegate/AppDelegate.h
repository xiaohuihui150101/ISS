//
//  AppDelegate.h
//  ISS-ISPS-USER
//
//  Created by isoft on 2018/12/5.
//  Copyright © 2018 isoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

/**
 * 控制横竖屏 YES 是横屏   NO是竖屏
 **/
@property (nonatomic, assign) BOOL allowRotation;


@end

