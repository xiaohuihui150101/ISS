//
//  RTSettingCell.m
//  ISS
//
//  Created by isoft on 2018/12/7.
//  Copyright © 2018 isoft. All rights reserved.
//

#import "RTSettingCell.h"

@implementation RTSettingCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self titleLB];
        [self signoutLB];
        [self lineView];
        
    }
    return self;
}

- (UILabel *)titleLB {
    if (!_titleLB) {
        _titleLB = [[UILabel alloc] init];
        _titleLB.textColor = [UIColor blackColor];
        _titleLB.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:_titleLB];
        [_titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(0);
            make.left.equalTo(16);
            make.width.equalTo(70);
            make.height.equalTo(20);
        }];
    }
    return _titleLB;
}

- (UILabel *)signoutLB {
    if (!_signoutLB) {
        _signoutLB = [[UILabel alloc] init];
        _signoutLB.textColor = [UIColor blackColor];
        _signoutLB.font = [UIFont systemFontOfSize:16];
        _signoutLB.layer.borderColor = [UIColor grayColor].CGColor;
        _signoutLB.layer.borderWidth = 1.0;
        _signoutLB.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_signoutLB];
        [_signoutLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(0);
            make.left.equalTo(16);
            make.right.equalTo(-16);
            make.height.equalTo(40);
        }];
    }
    return _signoutLB;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = mHexColor(0xF3F5F8);
        [self.contentView addSubview:_lineView];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(16);
            make.right.equalTo(-16);
            make.top.equalTo(@(59));
            make.height.equalTo(@(1));
        }];
    }
    return _lineView;
}

@end
