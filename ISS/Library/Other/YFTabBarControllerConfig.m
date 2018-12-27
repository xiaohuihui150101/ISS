//
//  YFTabBarControllerConfig.m
//  ISS-ISPS-USER
//
//  Created by isoft on 2018/12/5.
//  Copyright © 2018 isoft. All rights reserved.
//

#import "YFTabBarControllerConfig.h"

#import "RootVC.h"
#import "RTDeviceVC.h"
#import "RTMineVC.h"


static CGFloat const YFTabBarControllerHeight = 40.f;

@implementation YFBaseNavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    if (self = [super initWithRootViewController:rootViewController]) {
        [self.navigationBar setShadowImage:[UIImage imageWithColor:mHexColor(0xF3F5F8)]];//导航栏分割线的颜色
        NSDictionary *naviTitleDic = @{NSForegroundColorAttributeName : [UIColor blackColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:16]};//导航栏字体的颜色和大小
        UINavigationBar *navBar = [UINavigationBar appearance]; //全世界都知道
        [navBar setTitleTextAttributes:naviTitleDic];
//        if ([rootViewController isKindOfClass:[PYSearchViewController class]]) {
//
//        } else {
//
//        }
        
//        [navBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
    }
    return self;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
       
        if ([viewController isKindOfClass:[PYSearchViewController class]]) {
//            [self.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor purpleColor]] forBarMetrics:UIBarMetricsDefault];
        } else {
//             [self.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
            UIButton *backBtn = [[UIButton alloc] init];
            backBtn.frame = CGRectMake(0, 0, 40, 44);
            [backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            backBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
            [backBtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
            backBtn.backgroundColor = [UIColor purpleColor];
            backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 10);
            viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
            
        }
       [UITabBar appearance].translucent = NO;
        //        if ([viewController isKindOfClass:[LookHeadViewController class]]) {
        //            [backBtn setImage:[UIImage imageNamed:@"head_nav_back_white"] forState:UIControlStateNormal];
        //        } else {
        //            [backBtn setImage:[UIImage imageNamed:@"head_nav_back"] forState:UIControlStateNormal];
        //        }
        
    }
    
    [super pushViewController:viewController animated:animated];
}

- (UIViewController *)childViewControllerForStatusBarStyle {
    return self.topViewController;
}

- (void)back:(UIButton *)sender {
    [RTNetworkManager cancelAllRequest];
    [self popViewControllerAnimated:YES];
}

@end

//UITabbar
@interface YFTabBarControllerConfig ()<UITabBarControllerDelegate>

@property (nonatomic, readwrite, strong) YFTabBerViewController *tabBarController;

@end

@implementation YFTabBarControllerConfig

- (YFTabBerViewController *)tabBarController {
    if (_tabBarController == nil) {
        /**
         * 以下两行代码目的在于手动设置让TabBarItem只显示图标，不显示文字，并让图标垂直居中。
         * 等效于在 `-tabBarItemsAttributesForController` 方法中不传 `CYLTabBarItemTitle` 字段。
         * 更推荐后一种做法。
         */
        UIEdgeInsets imageInsets = UIEdgeInsetsZero;//UIEdgeInsetsMake(4.5, 0, -4.5, 0);
        UIOffset titlePositionAdjustment = UIOffsetMake(0, -3);//UIOffsetMake(0, MAXFLOAT); UIOffsetZero
        
        YFTabBerViewController *tabBarController = [YFTabBerViewController tabBarControllerWithViewControllers:self.viewControllers
                                                                                         tabBarItemsAttributes:self.tabBarItemsAttributesForController
                                                                                                   imageInsets:imageInsets
                                                                                       titlePositionAdjustment:titlePositionAdjustment];
        tabBarController.selectedIndex = 1;
        
        [self customizeTabBarAppearance:tabBarController];
        _tabBarController = tabBarController;
    }
    return _tabBarController;
}

- (NSArray *)viewControllers {
    RootVC *firstViewController = [[RootVC alloc] init];
    UIViewController *firstNavigationController = [[YFBaseNavigationController alloc]
                                                   initWithRootViewController:firstViewController];
    
    RTDeviceVC *secondViewController = [[RTDeviceVC alloc] init];
    UIViewController *secondNavigationController = [[YFBaseNavigationController alloc] initWithRootViewController:secondViewController];
    
    RTMineVC *thirdViewController = [[RTMineVC alloc] init];
    UIViewController *thirdNavigationController = [[YFBaseNavigationController alloc]
                                                   initWithRootViewController:thirdViewController];
    
    
    NSArray *viewControllers = @[
                                 firstNavigationController,
                                 secondNavigationController,
                                 thirdNavigationController
                                 ];
    return viewControllers;
}

- (NSArray *)tabBarItemsAttributesForController {
    NSDictionary *firstTabBarItemsAttributes = @{
                                                 YFTabBarItemTitle :@"区域态势",
                                                 YFTabBarItemImage : @"1主页",
                                                 YFTabBarItemSelectedImage : @"1主页选中",
                                                 };
    NSDictionary *secondTabBarItemsAttributes = @{
                                                  YFTabBarItemTitle :@"设备管理",
                                                  YFTabBarItemImage : @"2新机",
                                                  YFTabBarItemSelectedImage : @"2新机选中",
                                                  };
    NSDictionary *thirdTabBarItemsAttributes = @{
                                                 YFTabBarItemTitle :@"我的",
                                                 YFTabBarItemImage : @"3咨询",
                                                 YFTabBarItemSelectedImage : @"3咨询选中",
                                                 };
    
    NSArray *tabBarItemsAttributes = @[
                                       firstTabBarItemsAttributes,
                                       secondTabBarItemsAttributes,
                                       thirdTabBarItemsAttributes
                                       ];
    return tabBarItemsAttributes;
}

/**
 *  更多TabBar自定义设置：比如：tabBarItem 的选中和不选中文字和背景图片属性、tabbar 背景图片属性等等
 */
- (void)customizeTabBarAppearance:(YFTabBerViewController *)tabBarController {
    //自定义tabbar Aapperance
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = mHexColor(0x999999);
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] =  mHexColor(0xff7900);
    
    UITabBarItem *tabBarItem = [UITabBarItem appearance];
    [tabBarItem setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBarItem setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    UITabBar *tabBar = [UITabBar appearance];
    tabBar.translucent = YES;
    [tabBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]]];
    [tabBar setBackgroundColor:[UIColor whiteColor]];
    [tabBar setShadowImage:[UIImage imageWithColor:mHexColor(0xF3F5F8)]];//下面的分割线
    
}

- (void)updateTabBarCustomizationWhenTabBarItemWidthDidUpdate {
    void (^deviceOrientationDidChangeBlock)(NSNotification *) = ^(NSNotification *notification) {
        UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
        if ((orientation == UIDeviceOrientationLandscapeLeft) || (orientation == UIDeviceOrientationLandscapeRight)) {
            NSLog(@"Landscape Left or Right !");
        } else if (orientation == UIDeviceOrientationPortrait) {
            NSLog(@"Landscape portrait!");
        }
        [self customizeTabBarSelectionIndicatorImage];
    };
    [[NSNotificationCenter defaultCenter] addObserverForName:YFTabBarItemWidthDidChangeNotification
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:deviceOrientationDidChangeBlock];
}

- (void)customizeTabBarSelectionIndicatorImage {
    ///Get initialized TabBar Height if exists, otherwise get Default TabBar Height.
    CGFloat tabBarHeight = YFTabBarControllerHeight;
    CGSize selectionIndicatorImageSize = CGSizeMake(YFTabBarItemWidth, tabBarHeight);
    //Get initialized TabBar if exists.
    UITabBar *tabBar = [self yf_tabBarController].tabBar ?: [UITabBar appearance];
    [tabBar setSelectionIndicatorImage:
     [[self class] imageWithColor:[UIColor yellowColor]
                             size:selectionIndicatorImageSize]];
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    if (!color || size.width <= 0 || size.height <= 0) return nil;
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width + 1, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
