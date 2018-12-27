//
//  RTMineBaseCell.m
//  ISS
//
//  Created by isoft on 2018/12/6.
//  Copyright © 2018 isoft. All rights reserved.
//

#import "RTMineBaseCell.h"

@implementation RTMineBaseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self titleLB];
        [self redLB];
        [self lineView];
        
    }
    return self;
}

- (UILabel *)titleLB {
    if (!_titleLB) {
        _titleLB = [[UILabel alloc] init];
        _titleLB.text = @"杰森斯基.二世.詹姆斯";
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

- (UILabel *)redLB {
    if (!_redLB) {
        _redLB = [[UILabel alloc] init];
        _redLB.backgroundColor = [UIColor redColor];
        _redLB.textColor = [UIColor whiteColor];
        _redLB.text = @"2";
        _redLB.textAlignment = NSTextAlignmentCenter;
        _redLB.layer.cornerRadius = 14/2;
        _redLB.layer.masksToBounds = YES;
        _redLB.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_redLB];
        [_redLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLB.mas_top).offset(-7);
            make.left.equalTo(self.titleLB.mas_right).offset(2);
            make.width.height.equalTo(14);
        }];
    }
    return _redLB;
}


- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = mHexColor(0xF3F5F8);
        [self.contentView addSubview:_lineView];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(16);
            make.right.equalTo(-16);
            make.top.equalTo(@(79));
            make.height.equalTo(@(1));
        }];
    }
    return _lineView;
}


@end
