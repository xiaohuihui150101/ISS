//
//  UIView+YFTabBarControllerCategory.h
//  ISS-ISPS-USER
//
//  Created by isoft on 2018/12/5.
//  Copyright © 2018 isoft. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (YFTabBarControllerCategory)

- (BOOL)yf_isPlusButton;
- (BOOL)yf_isTabButton;
- (BOOL)yf_isTabImageView;
- (BOOL)yf_isTabLabel;
- (BOOL)yf_isTabBadgeView;

+ (UIView *)yf_tabBadgePointViewWithClolor:(UIColor *)color radius:(CGFloat)radius;

@end

NS_ASSUME_NONNULL_END
