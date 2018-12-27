//
//  PublicMacro.h
//  ISS-ISPS-USER
//
//  Created by isoft on 2018/12/5.
//  Copyright © 2018 isoft. All rights reserved.
//

#ifndef PublicMacro_h
#define PublicMacro_h

#define N_HostSiteMain @"http://51mofo.com"//http://51mofo.com //http://39.107.74.82:36080/jsyf-sys

#pragma mark - 判断当前设备
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define iPhone3                   ([UIScreen mainScreen].bounds.size.height < 480)
#define iPhone4                   ([UIScreen mainScreen].bounds.size.height == 480)
#define iPhone5                   ([UIScreen mainScreen].bounds.size.height == 568)
#define iPhone6                   ([UIScreen mainScreen].bounds.size.height == 667)
#define iPhone6p                  ([UIScreen mainScreen].bounds.size.height == 736)
#define IS_IPHONE_X (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 812.0f)
#define IS_IPHONE_XS (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 896.0f)

#define ScreenHeight                  [UIScreen mainScreen].bounds.size.height
#define  ScreenWidth                   [UIScreen mainScreen].bounds.size.width

#define m6PScale              (ScreenWidth/1242.0)
#define m6Scale               (ScreenWidth/750.0)
#define m5Scale               (ScreenWidth/640.0)
#define k6Scale               (ScreenWidth/375.0)

//定义屏幕框 高
#define  MAIN_HEIGHT                  [UIScreen mainScreen].bounds.size.height
#define  MAIN_WIDTH                   [UIScreen mainScreen].bounds.size.width


#define statusBarH (CGRectGetHeight([UIApplication sharedApplication].statusBarFrame))
#define statusBar  ((IS_IPHONE_X ||IS_IPHONE_XS) ? 24 : 0)
#define NaviHeight (statusBarH + 44)
#define TABBARHEIGHT ((IS_IPHONE_X ||IS_IPHONE_XS) ? 83 : 49)
#define BottomHeight ((IS_IPHONE_X ||IS_IPHONE_XS) ? 34 : 0)

//----------方法简写-------
#define mWindow             [[[UIApplication sharedApplication] windows] lastObject]
#define mKeyWindow          [[UIApplication sharedApplication] keyWindow]
#define mDelegateWindow     [[[UIApplication sharedApplication] delegate] window]
#define mUserDefaults       [NSUserDefaults standardUserDefaults]
#define mNotificationCenter [NSNotificationCenter defaultCenter]
#define mFont(size)         [UIFont systemFontOfSize:size]
#define mB_Font(size)       [UIFont boldSystemFontOfSize:size]
#define mWeakSelf  __weak typeof (self)weakSelf = self;


//调试模式下输入NSLog，发布后不再输入。
#ifdef DEBUG
#define NSLog(...) NSLog(@"%s 第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define NSLog(...)
#endif

/* 封装归档keyedArchiver操作 */
#define mWZLSERIALIZE_ARCHIVE(__objToBeArchived__, __key__, __filePath__)    \
\
NSMutableData *data = [NSMutableData data]; \
NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];   \
[archiver encodeObject:__objToBeArchived__ forKey:__key__];    \
[archiver finishEncoding];  \
[data writeToFile:__filePath__ atomically:YES]


/* 封装反归档keyedUnarchiver操作 */
#define mWZLSERIALIZE_UNARCHIVE(__objToStoreData__, __key__, __filePath__)   \
NSMutableData *dedata = [NSMutableData dataWithContentsOfFile:__filePath__]; \
NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:dedata];  \
__objToStoreData__ = [unarchiver decodeObjectForKey:__key__];  \
[unarchiver finishDecoding]

//颜色创建
#undef  RGBCOLOR
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

#undef  RGBACOLOR
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#undef    HEX_RGB
#define HEX_RGB(V)        [UIColor colorWithRGBHex:V]


#endif /* PublicMacro_h */
