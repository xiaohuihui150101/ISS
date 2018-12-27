//
//  RTPersonalCell.h
//  ISS
//
//  Created by isoft on 2018/12/6.
//  Copyright © 2018 isoft. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RTPersonalCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLB;
@property (nonatomic, strong) UIImageView *iconImg;
@property (nonatomic, strong) UILabel *subTitleLB;

@property (nonatomic, strong) UIView *lineView;

@end

NS_ASSUME_NONNULL_END
