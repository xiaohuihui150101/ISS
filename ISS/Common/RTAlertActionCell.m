//
//  RTAlertActionCell.m
//  ISS
//
//  Created by isoft on 2018/12/17.
//  Copyright © 2018 isoft. All rights reserved.
//

#import "RTAlertActionCell.h"

@implementation RTAlertActionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self textLB];
        
    }
    return self;
}

- (UILabel *)textLB {
    if (!_textLB) {
        _textLB = [[UILabel alloc] init];
        _textLB.textAlignment = NSTextAlignmentCenter;
        _textLB.font = [UIFont systemFontOfSize:16];
        _textLB.textColor = [UIColor blackColor];
        [self.contentView addSubview:_textLB];
        [_textLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.left.equalTo(self.contentView.mas_left).offset(16);
            make.right.equalTo(self.contentView.mas_right).offset(-16);
            make.height.equalTo(@(36));
        }];
    }
    return _textLB;
}


@end
