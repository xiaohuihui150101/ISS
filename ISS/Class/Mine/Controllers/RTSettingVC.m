//
//  RTSettingVC.m
//  ISS
//
//  Created by isoft on 2018/12/7.
//  Copyright © 2018 isoft. All rights reserved.
//

#import "RTSettingVC.h"
#import "RTSettingCell.h"
#import "RTAboutVC.h"

@interface RTSettingVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *reTableView;

@property (nonatomic, strong) NSArray *textArray;

@end

@implementation RTSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setInsetNoneWithScrollView:self.reTableView];
    self.textArray = @[@"推送提醒", @"使用帮助", @"关于我们"];
    
}

#pragma mark -- UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.textArray.count;
    } else {
         return 1;
    }
   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RTSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RTSettingCell"];
    if (indexPath.section == 0) {
        cell.titleLB.hidden = NO;
        cell.signoutLB.hidden = YES;
        cell.lineView.hidden = NO;
        cell.titleLB.text = self.textArray[indexPath.row];
    } else {
        cell.titleLB.hidden = YES;
        cell.signoutLB.hidden = NO;
        cell.lineView.hidden = YES;
        cell.signoutLB.text = @"退出登录";
        
    }
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *vi = [[UIView alloc] init];
    return vi;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *vi = [[UIView alloc] init];
    vi.backgroundColor = [UIColor whiteColor];
    return vi;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return 50;
    }
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        NSLog(@"点击第一个分区的y第一行第二行第三行");
        if (indexPath.row == 2) {
            RTAboutVC *vc = [[RTAboutVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    } else {
        NSLog(@"点击退出登录");
    }
}

- (UITableView *)reTableView {
    if (!_reTableView) {
        _reTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _reTableView.backgroundColor = [UIColor whiteColor];
        _reTableView.delegate = self;
        _reTableView.dataSource = self;
        _reTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_reTableView];
        //注册cell
        [_reTableView registerClass:[RTSettingCell class] forCellReuseIdentifier:@"RTSettingCell"];
        [_reTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(0);
        }];
    }
    return _reTableView;
}


@end
