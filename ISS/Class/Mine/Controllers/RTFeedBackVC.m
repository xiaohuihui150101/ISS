//
//  RTFeedBackVC.m
//  ISS
//
//  Created by isoft on 2018/12/7.
//  Copyright © 2018 isoft. All rights reserved.
//

#import "RTFeedBackVC.h"

#define  MaxTextLenght 500

@interface RTFeedBackVC ()<UITextViewDelegate>


@end

@implementation RTFeedBackVC


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -- UI
- (void)creatUI {
    self.navigationItem.title = @"意见反馈";
    
    UIButton * rightBtn = [[UIButton alloc] init];
    rightBtn.frame = CGRectMake(0, 0, 40, 44);
    [rightBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    [rightBtn setTitle:@"发送" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(onSend:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    
    self.feedbackTextView = [[UITextView alloc] initWithFrame:CGRectMake(10, 100, ScreenWidth-20, 200)];
    _feedbackTextView.font = [UIFont systemFontOfSize:14];
    _feedbackTextView.layer.borderWidth = 1;
    _feedbackTextView.layer.borderColor = [UIColor grayColor].CGColor;
    _feedbackTextView.textColor = [UIColor blackColor];
    _feedbackTextView.placeholder = @"请输入您的建议";
    _feedbackTextView.delegate = self;
    _feedbackTextView.placeholderColor = mHexColor(0xC5C5C5);
    _feedbackTextView.placeholderLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:_feedbackTextView];
    
    
}
//提交
- (void)onSend:(UIButton *)sender {
    if (self.feedbackTextView.text.length == 0) {
        [self.view showWarning:@"反馈的信息不能为空"];
        return;
    }
    [self.feedbackTextView resignFirstResponder];
    
}


#pragma mark textviewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if (textView.text.length+text.length>MaxTextLenght) {
        [self.view showWarning:[NSString stringWithFormat:@"最大可输入%i个字符",MaxTextLenght]];
        return NO;
    } else {
        return YES;
    }
}




- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.feedbackTextView resignFirstResponder];
}
- (void)backBtnToClicked {
    if (self.presentingViewController || !self.navigationController)
        [self dismissViewControllerAnimated:YES completion:nil];
    else
        [self.navigationController popViewControllerAnimated:YES];
    
}

@end
