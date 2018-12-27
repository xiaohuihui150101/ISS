//
//  UIView+ESTap.m
//  ISS-ISPS-USER
//
//  Created by isoft on 2018/12/5.
//  Copyright © 2018 isoft. All rights reserved.
//

#import "UIView+ESTap.h"

@implementation UIView (ESTap)

- (void)tapHandle:(TapAction)block {
    self.userInteractionEnabled = YES;
    UIButton *btn = [UIButton new];
    [self addSubview:btn];
    btn.backgroundColor = [UIColor clearColor];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(0);
    }];
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        if (block) {
            block();
        }
    }];
}

@end
