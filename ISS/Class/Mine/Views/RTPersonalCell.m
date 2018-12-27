//
//  RTPersonalCell.m
//  ISS
//
//  Created by isoft on 2018/12/6.
//  Copyright © 2018 isoft. All rights reserved.
//

#import "RTPersonalCell.h"

@implementation RTPersonalCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self titleLB];
        [self iconImg];
        [self subTitleLB];
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

- (UIImageView *)iconImg {
    if (!_iconImg) {
        _iconImg = [[UIImageView alloc] init];
        _iconImg.backgroundColor = [UIColor cyanColor];
        [self.contentView addSubview:_iconImg];
        [_iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(0);
            make.right.equalTo(-16);
            make.width.height.equalTo(40);
        }];
    }
    return _iconImg;
}

- (UILabel *)subTitleLB {
    if (!_subTitleLB) {
        _subTitleLB = [[UILabel alloc] init];
        _subTitleLB.textAlignment = NSTextAlignmentRight;
        _subTitleLB.font = [UIFont systemFontOfSize:16];
        _subTitleLB.textColor = [UIColor grayColor];
        [self.contentView addSubview:_subTitleLB];
        [_subTitleLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(0);
            make.right.equalTo(-16);
            make.left.equalTo(self.titleLB.mas_right);
            make.height.equalTo(20);
        }];
    }
    return _subTitleLB;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = mHexColor(0xF3F5F8);
        [self.contentView addSubview:_lineView];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(59);
            make.height.equalTo(1);
            make.left.equalTo(16);
            make.right.equalTo(-16);
        }];
        
    }
    return _lineView;
}


@end
