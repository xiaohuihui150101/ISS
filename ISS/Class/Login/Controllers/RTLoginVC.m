//
//  RTLoginVC.m
//  ISS
//
//  Created by isoft on 2018/12/12.
//  Copyright © 2018 isoft. All rights reserved.
//

#import "RTLoginVC.h"

@interface RTLoginVC ()<UITextFieldDelegate>

@property (nonatomic, strong) UILabel *userLB;
@property (nonatomic, strong) UITextField *userTF;

@property (nonatomic, strong) UILabel *passwordLB;
@property (nonatomic, strong) UITextField *passwordTF;

@property (nonatomic, strong) UILabel *noAccountLB;

@property (nonatomic, strong) UIButton *loginBtn;

@end

@implementation RTLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
     self.navigationController.navigationBar.barTintColor = [UIColor grayColor];
    self.navigationItem.title = @"登录";
    [self initUI];
}
/***
 * 设置UI
 **/
- (void)initUI {
    
    _userLB = [[UILabel alloc] init];
    _userLB.text = @"用户名:";
    _userLB.font = [UIFont systemFontOfSize:14];
    _userLB.textColor = [UIColor grayColor];
    [self.view addSubview:_userLB];
    [_userLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(16);
        make.height.equalTo(18);
        make.top.equalTo(150);
        make.width.equalTo(55);
    }];
    
    _userTF = [[UITextField alloc] init];
    _userTF.placeholder = @"请输入用户名";
    _userTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    _userTF.delegate = self;
    _userTF.font = [UIFont systemFontOfSize:15];
    _userTF.textColor = [UIColor blackColor];
    _userTF.layer.borderWidth = 1;
    _userTF.layer.borderColor = [UIColor grayColor].CGColor;
    [self.view addSubview:_userTF];
    [_userTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.userLB.mas_centerY);
        make.height.equalTo(30);
        make.left.equalTo(self.userLB.mas_right).offset(5);
        make.right.equalTo(-16);
    }];
    
    //
    _passwordLB = [[UILabel alloc] init];
    _passwordLB.text = @"密   码:";
    _passwordLB.font = [UIFont systemFontOfSize:14];
    _passwordLB.textColor = [UIColor grayColor];
    [self.view addSubview:_passwordLB];
    [_passwordLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(16);
        make.height.equalTo(18);
        make.top.equalTo(self.userLB.mas_bottom).offset(30);
        make.width.equalTo(55);
    }];
    
    _passwordTF = [[UITextField alloc] init];
    _passwordTF.placeholder = @"请输入账号密码";
    _passwordTF.delegate = self;
    _passwordTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    _passwordTF.font = [UIFont systemFontOfSize:15];
    _passwordTF.textColor = [UIColor blackColor];
    _passwordTF.layer.borderWidth = 1;
    _passwordTF.layer.borderColor = [UIColor grayColor].CGColor;
    [self.view addSubview:_passwordTF];
    [_passwordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.passwordLB.mas_centerY);
        make.height.equalTo(30);
        make.left.equalTo(self.passwordLB.mas_right).offset(5);
        make.right.equalTo(-16);
    }];
    
    //没有账号密码？请联系平台管理员
    _noAccountLB = [[UILabel alloc] init];
    _noAccountLB.text = @"没有账号密码？请联系平台管理员";
    _noAccountLB.font = [UIFont systemFontOfSize:14];
    _noAccountLB.textColor = [UIColor grayColor];
    [self.view addSubview:_noAccountLB];
    [_noAccountLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(16);
        make.height.equalTo(18);
        make.top.equalTo(self.passwordLB.mas_bottom).offset(30);
        make.right.equalTo(-16);
    }];
    
    //
    _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _loginBtn.backgroundColor = [UIColor grayColor];
    _loginBtn.enabled = NO;
    [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_loginBtn addTarget:self action:@selector(loginButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginBtn];
    [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.noAccountLB.mas_bottom).offset(5);
        make.height.equalTo(40);
        make.left.equalTo(16);
        make.right.equalTo(-16);
    }];
    
    //输入框的响应事件
    [self.userTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.passwordTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
}

#pragma mark -- 响应事件更新布局
//点击空白回收键盘
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if ([self.userTF isFirstResponder]) {
        [self.userTF resignFirstResponder];
    }
    if ([self.passwordTF isFirstResponder]) {
        [self.passwordTF resignFirstResponder];
    }
}

- (void)textFieldDidChange:(UITextField *)textField {
    if (textField == self.userTF || textField == self.passwordTF) {
        if (self.userTF.text.length >= 1 && self.passwordTF.text.length >= 1) {
            _loginBtn.enabled = YES;
            _loginBtn.backgroundColor = [UIColor blueColor];
        } else {
            _loginBtn.enabled = NO;
            _loginBtn.backgroundColor = [UIColor grayColor];
        }
    }
}
#pragma mark -- UITextFieldDelegate
/***
 * 点击return 回收键盘
 **/
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.userTF || textField == self.passwordTF) {
        [self.userTF resignFirstResponder];
        [self.passwordTF resignFirstResponder];
    }
    return YES;
}

- (void)loginButtonAction:(UIButton *)sender {
    [self.userTF resignFirstResponder];
    [self.passwordTF resignFirstResponder];
    NSLog(@"点击登录按钮");
}


@end
