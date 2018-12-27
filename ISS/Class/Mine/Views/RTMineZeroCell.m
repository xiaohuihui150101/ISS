//
//  RTMineZeroCell.m
//  ISS
//
//  Created by isoft on 2018/12/6.
//  Copyright © 2018 isoft. All rights reserved.
//

#import "RTMineZeroCell.h"

@implementation RTMineZeroCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self headerImg];
        [self titleLB];
        [self lineView];
        
       
    }
    return self;
}


- (UIImageView *)headerImg {
    if (!_headerImg) {
        _headerImg = [[UIImageView alloc] init];
        _headerImg.backgroundColor = [UIColor cyanColor];
        [self.contentView addSubview:_headerImg];
        [_headerImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(0);
            make.left.equalTo(16);
            make.width.height.equalTo(80);
        }];
    }
    return _headerImg;
}

- (UILabel *)titleLB {
    if (!_titleLB) {
        _titleLB = [[UILabel alloc] init];
        _titleLB.text = @"杰森斯基.二世.詹姆斯";
        _titleLB.textColor = [UIColor blackColor];
        _titleLB.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:_titleLB];
        [_titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.headerImg.mas_centerY);
            make.left.equalTo(self.headerImg.mas_right).offset(12);
            make.right.equalTo(-16);
            make.height.equalTo(20);
        }];
    }
    return _titleLB;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = mHexColor(0xF3F5F8);
        [self.contentView addSubview:_lineView];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(16);
            make.right.equalTo(-16);
            make.top.equalTo(@(119));
            make.height.equalTo(@(1));
        }];
    }
    return _lineView;
}


@end
