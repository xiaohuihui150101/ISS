//
//  RTAboutVC.m
//  ISS
//
//  Created by isoft on 2018/12/13.
//  Copyright © 2018 isoft. All rights reserved.
//

#import "RTAboutVC.h"
#import "RTSettingCell.h"
#import "RTVersionUpdateVC.h"


@interface RTAboutVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *reTableView;

@property (nonatomic, strong) NSArray *textArray;

@end

@implementation RTAboutVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"关于我们";
    
    self.textArray = @[@"版本更新", @"使用帮助", @"应用分享", @"软件协议", @"服从协议"];
    
    [self setInsetNoneWithScrollView:self.reTableView];
    
}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.textArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RTSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RTSettingCell"];
    cell.signoutLB.hidden = YES;
    cell.titleLB.text = self.textArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        RTVersionUpdateVC *vc = [[RTVersionUpdateVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
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
        [_reTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(0);
        }];
        //注册cell
        [_reTableView registerClass:[RTSettingCell class] forCellReuseIdentifier:@"RTSettingCell"];
        
    }
    return _reTableView;
}

@end
