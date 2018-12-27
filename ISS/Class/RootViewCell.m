//
//  RootViewCell.m
//  ISS
//
//  Created by isoft on 2018/12/25.
//  Copyright © 2018 isoft. All rights reserved.
//

#import "RootViewCell.h"

@implementation RootViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self iconImg];
        [self nameLB];
        [self titleLB];
        [self lineView];
        
    }
    return self;
}

- (UIImageView *)iconImg {
    if (!_iconImg) {
        _iconImg = [[UIImageView alloc] init];
        _iconImg.backgroundColor = [UIColor cyanColor];
        _iconImg.contentMode = UIViewContentModeScaleAspectFill;
        [_iconImg setClipsToBounds:YES];
        [self.contentView addSubview:_iconImg];
        [_iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(15);
            make.centerY.equalTo(0);
            make.width.height.equalTo(80);
        }];
    }
    return _iconImg;
}

- (UILabel *)nameLB {
    if (!_nameLB) {
        _nameLB = [[UILabel alloc] init];
        _nameLB.font = [UIFont systemFontOfSize:15];
        _nameLB.textColor = [UIColor blackColor];
        [self.contentView addSubview:_nameLB];
        [_nameLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.iconImg.mas_right).offset(10);
            make.top.equalTo(self.iconImg.mas_top).offset(10);
            make.right.equalTo(-15);
            make.height.equalTo(24);
        }];
    }
    return _nameLB;
}

- (UILabel *)titleLB {
    if (!_titleLB) {
        _titleLB = [[UILabel alloc] init];
        _titleLB.font = [UIFont systemFontOfSize:15];
        _titleLB.textColor = mHexColor(0x999999);
        [self.contentView addSubview:_titleLB];
        [_titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.iconImg.mas_right).offset(10);
            make.top.equalTo(self.nameLB.mas_bottom).offset(10);
            make.right.equalTo(-15);
            make.height.equalTo(24);
        }];
    }
    return _titleLB;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = mHexColor(0xEAEAEA);
        [self.contentView addSubview:_lineView];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(@(0));
            make.top.equalTo(@(99));
            make.height.equalTo(@(1));
        }];
    }
    return _lineView;
}

- (void)setModel:(ListRows *)model {
    if (_model != model) {
        _model = model;
    }
    NSLog(@"打印====%@====%@===%@", model.coverimg, model.circlename, model.nickname);
    [self.iconImg sd_setImageWithURL:[NSURL URLWithString:model.coverimg] placeholderImage:[UIImage imageNamed:@"ji"]];
    self.nameLB.text = model.circlename;
    self.titleLB.text = model.nickname;
    
}

@end
