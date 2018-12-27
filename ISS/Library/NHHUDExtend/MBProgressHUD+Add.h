//
//  MBProgressHUD+Add.h
//  ISS-ISPS-USER
//
//  Created by isoft on 2018/12/5.
//  Copyright © 2018 isoft. All rights reserved.
//

#import "MBProgressHUD.h"

//默认持续显示时间(x秒后消失)
UIKIT_EXTERN CGFloat const delayTime;

/** 设置默认的显示风格(修改这个值可以减少频繁的调用setHudStyle)：
 *  NHHUDContentDefaultStyle = 0,//默认是白底黑字 Default
 *  NHHUDContentBlackStyle = 1,//黑底白字
 *  NHHUDContentCustomStyle = 2,
 *
 * eg：设置为1时，调用任何这个扩展内的方法，显示出hud的UI效果都会为黑底白字风格
 */
#define NHDefaultHudStyle  1


/**
 * 风格为自定义时，在这里设置颜色
 */
#define NHCustomHudStyleBackgrandColor  [UIColor colorWithWhite:0.f alpha:0.7f]
#define NHCustomHudStyleContentColor    [UIColor colorWithWhite:1.f alpha:0.7f]


@interface MBProgressHUD (Add)

@end


