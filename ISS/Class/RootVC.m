//
//  RootVC.m
//  ISS-ISPS-USER
//
//  Created by isoft on 2018/12/5.
//  Copyright © 2018 isoft. All rights reserved.
//

#import "RootVC.h"
#import "RootModel.h"
#import "RootViewCell.h"



@interface RootVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray<ListRows *> *dataSource;
@property (nonatomic, strong) UITableView *reTableView;

@end

@implementation RootVC
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self initData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"态势区域";
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    //http://51mofo.com/movision/app/discover2/hot_range?pageNo=1&pageSize=10&type=0&title=0
    [self setInsetNoneWithScrollView:self.reTableView];
    
}

- (void)initData {
    NSDictionary *params = @{@"pageNo":@1,
                             @"pageSize":@30,
                             @"type":@"0",
                             @"title":@"0"
                             };
    mWeakSelf
    [[[RTNetworkManager discoverHotRangeDict:params] map:^id(id value) {
        return [RootModel mj_objectWithKeyValues:value];
    }] subscribeNext:^(RootModel *  _Nullable x) {
        NSLog(@"======%@",x.data.rows);
        [weakSelf.dataSource removeAllObjects];
        [weakSelf.dataSource addObjectsFromArray:x.data.rows];
        NSLog(@"打印此时数组的数量===%ld", weakSelf.dataSource.count);
        [weakSelf.reTableView reloadData];
    } error:^(NSError * _Nullable error) {
        NSLog(@"错误信息===%@", error.localizedDescription);
    }];
}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RootViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RootViewCell"];
    ListRows *model = self.dataSource[indexPath.row];
    cell.model = model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}


- (NSMutableArray<ListRows *> *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
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
        [_reTableView registerClass:[RootViewCell class] forCellReuseIdentifier:@"RootViewCell"];
        
    }
    return _reTableView;
}


@end
