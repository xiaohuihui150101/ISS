//
//  RTAreaSelectViewCell.m
//  ISS
//
//  Created by isoft on 2018/12/13.
//  Copyright © 2018 isoft. All rights reserved.
//

#import "RTAreaSelectViewCell.h"

@implementation RTAreaSelectViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self titleLB];
        
    }
    return self;
}

- (UILabel *)titleLB {
    if (!_titleLB) {
        _titleLB = [[UILabel alloc] init];
        _titleLB.text = @"货运区";
        _titleLB.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_titleLB];
        [_titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(0);
            make.width.equalTo(100);
            make.height.equalTo(30);
        }];
    }
    return _titleLB;
}


@end
