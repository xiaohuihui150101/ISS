//
//  RTMessageVC.m
//  ISS
//
//  Created by isoft on 2018/12/13.
//  Copyright © 2018 isoft. All rights reserved.
//

#import "RTMessageVC.h"
#import "RTMessageViewCell.h"
#import "RTMessageDetailVC.h"


@interface RTMessageVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *reTableView;

@end

@implementation RTMessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setInsetNoneWithScrollView:self.reTableView];
    self.navigationItem.title = @"消息管理";
    
}
#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RTMessageViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RTMessageViewCell"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    RTMessageDetailVC *vc = [[RTMessageDetailVC alloc] init];
    [self.navigationController pushViewController:vc animated:NO];
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
        [_reTableView registerClass:[RTMessageViewCell class] forCellReuseIdentifier:@"RTMessageViewCell"];
        
    }
    return _reTableView;
}

@end
