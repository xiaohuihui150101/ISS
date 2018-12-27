//
//  RTMessageViewCell.h
//  ISS
//
//  Created by isoft on 2018/12/13.
//  Copyright © 2018 isoft. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RTMessageViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLB;
@property (nonatomic, strong) UILabel *unreadLB;
@property (nonatomic, strong) UILabel *contentLB;
@property (nonatomic, strong) UIView *lineView;

@end

NS_ASSUME_NONNULL_END
