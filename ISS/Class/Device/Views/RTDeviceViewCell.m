//
//  RTDeviceViewCell.m
//  ISS
//
//  Created by isoft on 2018/12/12.
//  Copyright © 2018 isoft. All rights reserved.
//

#import "RTDeviceViewCell.h"

@implementation RTDeviceViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self titleLB];
        [self messageBtn];
        [self lookBtn];
        
    }
    return self;
}

- (UILabel *)titleLB {
    if (!_titleLB) {
        _titleLB = [[UILabel alloc] init];
        _titleLB.text = @"名称:V001         类型:摄像头        状态:运行中";
        [self.contentView addSubview:_titleLB];
        [_titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(15);
            make.left.equalTo(16);
            make.right.equalTo(-16);
            make.height.equalTo(24);
        }];
    }
    return _titleLB;
}

- (UIButton *)messageBtn {
    if (!_messageBtn) {
        _messageBtn = [[UIButton alloc] init];
        _messageBtn.backgroundColor = [UIColor whiteColor];
        [_messageBtn setTitle:@"设备所属区域信息" forState:UIControlStateNormal];
        [_messageBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self.contentView addSubview:_messageBtn];
        [_messageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(-8);
            make.left.equalTo(16);
            make.width.equalTo(ScreenWidth*0.6);
            make.height.equalTo(35);
        }];
    }
    return _messageBtn;
}

- (UIButton *)lookBtn {
    if (!_lookBtn) {
        _lookBtn = [[UIButton alloc] init];
        _lookBtn.backgroundColor = [UIColor whiteColor];
        [_lookBtn setTitle:@"查看" forState:UIControlStateNormal];
        [_lookBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self.contentView addSubview:_lookBtn];
        [_lookBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.messageBtn.mas_centerY);
            make.right.equalTo(-16);
            make.width.equalTo(ScreenWidth*0.2);
            make.height.equalTo(35);
        }];
    }
    return _lookBtn;
}

@end
