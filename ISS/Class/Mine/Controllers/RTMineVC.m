//
//  RTMineVC.m
//  ISS
//
//  Created by isoft on 2018/12/6.
//  Copyright © 2018 isoft. All rights reserved.
//

#import "RTMineVC.h"
#import "RTMineZeroCell.h"
#import "RTMineBaseCell.h"
#import "RTPersonalDataVC.h"
#import "RTSettingVC.h"
#import "RTFeedBackVC.h"
#import "RTMessageVC.h"



@interface RTMineVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *reTableView;

@property (nonatomic, strong) NSArray *textArray;


@end

@implementation RTMineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [self setInsetNoneWithScrollView:self.reTableView];
    [self addNaviRightBtn];
    self.textArray = @[@"消息管理", @"意见反馈"];
    
}
#pragma mark -- 配置导航栏
- (void)addNaviRightBtn {
    UIButton *rightBtn = [[UIButton alloc] init];
    rightBtn.frame = CGRectMake(0, 0, 45, 44);
    rightBtn.backgroundColor = [UIColor redColor];
    rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [rightBtn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
}

#pragma mark -- UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return self.textArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        RTMineZeroCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RTMineZeroCell"];
        return cell;
    }
    RTMineBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RTMineBaseCell"];
    cell.titleLB.text = self.textArray[indexPath.row];
    if (indexPath.row == 0) {
        cell.redLB.hidden = NO;
    } else {
        cell.redLB.hidden = YES;
    }
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 120;
    }
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        RTPersonalDataVC *vc = [[RTPersonalDataVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        if (indexPath.row == 1) {
            RTFeedBackVC *vc = [[RTFeedBackVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            return;
        } else {
            RTMessageVC *vc = [[RTMessageVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            return;
        }
//        [[ESAlert API] OkAlertWithTitle:@"标题" message:@"修改用户名" :@"确定" :@"取消" vc:self sure:^{
//            NSLog(@"点击了确定按钮");
//        }];
    }
}

- (UITableView *)reTableView {
    if (!_reTableView) {
        _reTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _reTableView.backgroundColor = [UIColor whiteColor];
        _reTableView.delegate = self;
        _reTableView.dataSource = self;
        _reTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_reTableView];
        //注册cell
        [_reTableView registerClass:[RTMineZeroCell class] forCellReuseIdentifier:@"RTMineZeroCell"];
        [_reTableView registerClass:[RTMineBaseCell class] forCellReuseIdentifier:@"RTMineBaseCell"];
        [_reTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(0);
        }];
    }
    return _reTableView;
}

- (void)rightBtnClick:(UIButton *)sender {
    RTSettingVC *vc = [[RTSettingVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
