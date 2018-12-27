//
//  RTMessageViewCell.m
//  ISS
//
//  Created by isoft on 2018/12/13.
//  Copyright © 2018 isoft. All rights reserved.
//

#import "RTMessageViewCell.h"

@implementation RTMessageViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self titleLB];
        [self unreadLB];
        [self contentLB];
        [self lineView];
        
    }
    return self;
}

- (UILabel *)titleLB {
    if (!_titleLB) {
        _titleLB = [[UILabel alloc] init];
        _titleLB.text = @"通知类型";
        [self.contentView addSubview:_titleLB];
        [_titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(15);
            make.left.equalTo(16);
            make.right.equalTo(-50);
            make.height.equalTo(20);
            
        }];
    }
    return _titleLB;
}

- (UILabel *)unreadLB {
    if (!_unreadLB) {
        _unreadLB = [[UILabel alloc] init];
        _unreadLB.text = @"未读";
        _unreadLB.font = [UIFont systemFontOfSize:14];
        _unreadLB.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_unreadLB];
        [_unreadLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.titleLB.mas_centerY);
            make.right.equalTo(-10);
            make.width.equalTo(34);
            make.height.equalTo(20);
        }];
    }
    return _unreadLB;
}

- (UILabel *)contentLB {
    if (!_contentLB) {
        _contentLB = [[UILabel alloc] init];
        _contentLB.text = @"通知的标题和同志的类型自定义显示";
        [self.contentView addSubview:_contentLB];
        [_contentLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLB.mas_bottom).offset(10);
            make.right.equalTo(-50);
            make.left.equalTo(16);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        }];
    }
    return _contentLB;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = mHexColor(0xF3F5F8);
        [self.contentView addSubview:_lineView];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(@(0));
            make.top.equalTo(@(79));
            make.height.equalTo(@(1));
        }];
    }
    return _lineView;
}

@end
