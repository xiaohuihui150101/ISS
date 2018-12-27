//
//  UIView+HUD.m
//  3333
//
//  Created by isoft on 2018/11/26.
//  Copyright © 2018年 isoft. All rights reserved.
//

#import "UIView+HUD.h"

//超时
#define kTimeOut  15
//弹出提示时长
#define kDuration  1.5

@implementation UIView (HUD)

- (void)showBusyHUD {
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideAllHUDsForView:self animated:YES];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
        hud.graceTime = 0.5;
        hud.hudContentStyle(NHHUDContentBlackStyle);
        hud.userInteractionEnabled = YES;
        [hud hideAnimated:YES afterDelay:kTimeOut];
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.button.hidden = YES;
    });
}

- (void)showBusyHudWithText:(NSString *)text {
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideAllHUDsForView:self animated:YES];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
        hud.hudContentStyle(NHHUDContentBlackStyle);
        hud.userInteractionEnabled = YES;
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.label.text = text;
        [hud hideAnimated:YES afterDelay:kTimeOut];
    });
}

- (void)showWarning:(NSString *)warning{
    if (warning.length == 0) {
        return;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideAllHUDsForView:self animated:YES];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
        hud.hudContentStyle(NHHUDContentBlackStyle);
        hud.mode = MBProgressHUDModeText;
        hud.label.text = warning;
        hud.label.numberOfLines = 0;
        [hud hideAnimated:YES afterDelay:kDuration];
    });
}


- (void)showMsgWithTitle:(NSString *)title
{
    if (title.length == 0) {
        return;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideAllHUDsForView:self animated:YES];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
        hud.hudContentStyle(NHHUDContentBlackStyle);
        hud.mode = MBProgressHUDModeText;
        hud.label.text = title;
        hud.label.numberOfLines = 0;
    });
}

- (void)hideBusyHUD{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:self animated:YES];
    });
}

- (void)showBusyHUDWithYoffSet:(CGFloat)offSet {
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideAllHUDsForView:self animated:YES];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
        hud.userInteractionEnabled = YES;
        //        [hud hide:YES afterDelay:kTimeOut];
        //        hud.yOffset = offSet;
        [hud setOffset:CGPointMake(0, offSet)];
    });
    
}

- (void)showCustomView:(UIImage *)image title:(NSString *)title {
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideAllHUDsForView:self animated:YES];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
        //文字
        hud.label.text = title;
        hud.label.font = [UIFont systemFontOfSize:13.0f];
        //支持多行
        hud.label.numberOfLines = 0;
        // 隐藏时候从父控件中移除
        hud.removeFromSuperViewOnHide = YES;
        hud.hudContentStyle(NHHUDContentBlackStyle);
        hud.mode = MBProgressHUDModeCustomView;
        hud.customView = [[UIImageView alloc] initWithImage:image];
        hud.square = YES;
        [hud hideAnimated:YES afterDelay:kDuration];
    });
}

@end
