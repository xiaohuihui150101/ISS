//
//  UIViewController+YFCommon.m
//  ISS
//
//  Created by isoft on 2018/12/6.
//  Copyright © 2018 isoft. All rights reserved.
//

#import "UIViewController+YFCommon.h"

@implementation UIViewController (YFCommon)

- (void)setInsetNoneWithScrollView:(UIScrollView *)scrollView {
    if (@available(iOS 11.0, *)) {
        scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;  //UIScrollView也适用
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

@end
