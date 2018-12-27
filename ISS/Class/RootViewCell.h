//
//  RootViewCell.h
//  ISS
//
//  Created by isoft on 2018/12/25.
//  Copyright © 2018 isoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface RootViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *iconImg;
@property (nonatomic, strong) UILabel *nameLB;
@property (nonatomic, strong) UILabel *titleLB;
@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) ListRows *model;

@end

NS_ASSUME_NONNULL_END
