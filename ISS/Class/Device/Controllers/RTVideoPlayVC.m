//
//  RTVideoPlayVC.m
//  ISS
//
//  Created by isoft on 2018/12/14.
//  Copyright © 2018 isoft. All rights reserved.
//

#import "RTVideoPlayVC.h"
#import "RTVideoLandscapeVC.h"


@interface RTVideoPlayVC ()

@property (nonatomic, strong) UIView *playView;
@property (nonatomic, strong) UIButton *fullScreenBtn;

@property (nonatomic, strong) UILabel *titleLB;

@end

@implementation RTVideoPlayVC


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"视频播放";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUI];
}

#pragma mark - UIViewControllerRotation
//是否可以旋转
- (BOOL)shouldAutorotate {
    return YES;
}
//支持的方向
-(UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark -- UI布局
- (void)setUI {
    
    self.playView = [[UIView alloc] init];
    _playView.layer.borderColor = [UIColor grayColor].CGColor;
    _playView.layer.borderWidth = 1;
    [self.view addSubview:_playView];
    [_playView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(ScreenWidth-20);
        make.top.equalTo(statusBar+64+20);
        make.height.equalTo(230);
    }];
    
    self.fullScreenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_fullScreenBtn setTitle:@"全屏" forState:UIControlStateNormal];
    [_fullScreenBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _fullScreenBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:_fullScreenBtn];
    [_fullScreenBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.playView.mas_bottom).offset(-5);
        make.right.equalTo(self.playView.mas_right).offset(-5);
        make.height.equalTo(28);
        make.width.equalTo(40);
    }];
    
    
    //
    mWeakSelf
    [self.fullScreenBtn tapHandle:^NSString *{
        RTVideoLandscapeVC *vc = [[RTVideoLandscapeVC alloc] init];
        [weakSelf.navigationController pushViewController:vc animated:NO];
        
        return @"";
    }];
    
    
    self.titleLB = [[UILabel alloc] init];
    _titleLB.font = [UIFont systemFontOfSize:14];
    _titleLB.numberOfLines = 0;
    NSString *string = @"名称：V0100        类型：摄像头       状态：运行中       区域：航站楼--A区";
    _titleLB.textColor = [UIColor blackColor];
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:20];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [string length])];
    [_titleLB setAttributedText:attributedString];
    [_titleLB sizeToFit];
    
    
    [self.view addSubview:_titleLB];
    [_titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.playView.mas_bottom).offset(30);
        make.centerX.equalTo(self.playView.mas_centerX);
        make.width.equalTo(ScreenWidth-20);
        make.height.equalTo(60);
    }];
    
}

@end
