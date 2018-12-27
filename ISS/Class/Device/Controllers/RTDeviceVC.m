//
//  RTDeviceVC.m
//  ISS
//
//  Created by isoft on 2018/12/11.
//  Copyright © 2018 isoft. All rights reserved.
//

#import "RTDeviceVC.h"
#import "RTSearchResultVC.h"
#import "RTDeviceViewCell.h"
#import "RTNoDataView.h"
#import "RTMessageVC.h"
#import "RTAreaSelectVC.h"
#import "RTVideoPlayVC.h"
#import "RTSplitScreenVideoPlayVC.h"


@interface RTDeviceVC ()<PYSearchViewControllerDelegate, PYSearchViewControllerDataSource, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *reTableView;

@property (nonatomic, strong) RTNoDataView *noDataView;

@end

@implementation RTDeviceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    [self addNaviLeftBtn];
    [self addNaviRightBtn];
    [self centerNaviBtn];
    self.noDataView.hidden = YES;
    [self setInsetNoneWithScrollView:self.reTableView];
    
    
    
    
    
}
- (void)addNaviLeftBtn {
    UIButton *leftBtn = [[UIButton alloc] init];
    leftBtn.frame = CGRectMake(0, 0, 45, 44);
    leftBtn.backgroundColor = [UIColor redColor];
    leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [leftBtn addTarget:self action:@selector(leftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
}
- (void)addNaviRightBtn {
    UIButton *rightBtn = [[UIButton alloc] init];
    rightBtn.frame = CGRectMake(0, 0, 45, 44);
    rightBtn.backgroundColor = [UIColor redColor];
    [rightBtn setTitle:@"消息管理" forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [rightBtn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
}
- (void)centerNaviBtn {
    UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(20, 20, 100, 44);
    button.backgroundColor = [UIColor purpleColor];
    [button setTitle:@"航站区/飞行区航战区/飞行区" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(centerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = button;
    
}
#pragma mark -- UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 20;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RTDeviceViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RTDeviceViewCell"];
    cell.backgroundColor = [UIColor grayColor];
    
    mWeakSelf
    [cell.lookBtn tapHandle:^NSString *{
        [[ESAlert API] OkAlertWithTitle:@"提示" message:@"是否确定选择该区域刷新设备列表信息" :@"确定" :@"取消" vc:weakSelf sure:^{
            NSLog(@"点击确定的按钮");
        }];
        return @"点击查看按钮";
    }];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        RTSplitScreenVideoPlayVC *vc = [[RTSplitScreenVideoPlayVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        RTVideoPlayVC *vc = [[RTVideoPlayVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *vi = [[UIView alloc] init];
    return vi;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 10;
    } else {
        return 20;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *vi = [[UIView alloc] init];
    return vi;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}



- (RTNoDataView *)noDataView {
    if (!_noDataView) {
        _noDataView = [[RTNoDataView alloc] initWithFrame:self.view.bounds];
        _noDataView.viewType = RTNoDataViewTypeNone;
        _noDataView.title = @"内容获取失败,请确认连接是否正确";
        [self.view addSubview:_noDataView];
    }
    return _noDataView;
}


- (UITableView *)reTableView {
    if (!_reTableView) {
        _reTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _reTableView.backgroundColor = [UIColor whiteColor];
        _reTableView.delegate = self;
        _reTableView.dataSource = self;
        _reTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_reTableView];
        [_reTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(0);
        }];
        //注册cell
        [_reTableView registerClass:[RTDeviceViewCell class] forCellReuseIdentifier:@"RTDeviceViewCell"];

    }
    return _reTableView;
}


- (void)leftBtnClick:(UIButton *)sender {
    // 1. Create an Array of popular search
    NSArray *hotSeaches = @[@"软通", @"华为", @"工号", @"hello", @"123456"];
    // 2. Create a search view controller
    PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:hotSeaches searchBarPlaceholder:@"请输入设备名称，编号"];
    // 3. Set style for popular search and search history

    searchViewController.hotSearchStyle = 0;
    searchViewController.searchHistoryStyle = PYHotSearchStyleDefault;
//    searchViewController.searchBarBackgroundColor = [UIColor redColor];
//    searchViewController.searchBarCornerRadius = 0;

    // 4. Set delegate
    searchViewController.delegate = self;
    searchViewController.dataSource = self;
    searchViewController.searchViewControllerShowMode = PYSearchViewControllerShowModeModal;
    [self.navigationController pushViewController:searchViewController animated:YES];
}
- (void)rightBtnClick:(UIButton *)sender {
    NSLog(@"消息管理");
    RTMessageVC *vc = [[RTMessageVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)centerBtnClick:(UIButton *)sender {
    NSLog(@"点击中间的按钮");
    RTAreaSelectVC *vc = [[RTAreaSelectVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - PYSearchViewControllerDelegate
- (void)didClickCancel:(PYSearchViewController *)searchViewController {
    NSLog(@"点击取消");
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)searchViewController:(PYSearchViewController *)searchViewController searchTextDidChange:(UISearchBar *)seachBar searchText:(NSString *)searchText
{
    if (searchText.length) {
        // Simulate a send request to get a search suggestions
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSMutableArray *searchSuggestionsM = [NSMutableArray array];
            for (int i = 0; i < arc4random_uniform(5) + 10; i++) {
                NSString *searchSuggestion = [NSString stringWithFormat:@"搜索 %d", i];
                [searchSuggestionsM addObject:searchSuggestion];
            }
            // Refresh and display the search suggustions
            searchViewController.searchSuggestions = searchSuggestionsM;
        });
    }
}

//点击栏搜索
-(void)searchViewController:(PYSearchViewController *)searchViewController didSelectSearchSuggestionAtIndexPath:(NSIndexPath *)indexPath searchBar:(UISearchBar *)searchBar {
    
    RTSearchResultVC *vc = [[RTSearchResultVC alloc] init];
    vc.searchStr = searchBar.text;
    [self.navigationController pushViewController:vc animated:NO];
    
}

- (void)searchViewController:(PYSearchViewController *)searchViewController didSearchWithSearchBar:(UISearchBar *)searchBar searchText:(NSString *)searchText {
    RTSearchResultVC *vc = [[RTSearchResultVC alloc] init];
    vc.searchStr = searchBar.text;
    [self.navigationController pushViewController:vc animated:NO];
}


@end
