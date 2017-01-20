//
//  TPGMasonryViewController.m
//  Test
//
//  Created by dvt04 on 17/1/13.
//  Copyright © 2017年 suma. All rights reserved.
//

#import "TPGMasonryViewController.h"
#import "Masonry.h"

@interface TPGMasonryViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

@end

@implementation TPGMasonryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupComponent];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrameNotification:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHiddenNotification:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)setupComponent
{
    [_userNameLabel sizeToFit];
    
    [_userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.bottom.mas_equalTo(-20);
    }];
    [_userNameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_userNameLabel.mas_right).offset(10);
        make.bottom.mas_equalTo(-20);
        make.width.mas_equalTo(120);
    }];
}

- (void)keyboardWillChangeFrameNotification:(NSNotification *)noti
{
    NSDictionary *userInfo = [noti userInfo];
    // 获取键盘信息
    CGRect keyboardRect = [userInfo[@"UIKeyboardFrameBeginUserInfoKey"] CGRectValue];
    CGFloat keyboardHeight = CGRectGetHeight(keyboardRect);
    CGFloat keyboardDuration = [userInfo[@"UIKeyboardAnimationDurationUserInfoKey"] floatValue];
    // 修改控件下边约束
    [_userNameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-keyboardHeight);
    }];
    [_userNameTextField mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-keyboardHeight);
    }];
    // 更新约束
    [UIView animateWithDuration:keyboardDuration animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)keyboardWillHiddenNotification:(NSNotification *)noti
{
    NSDictionary *userInfo = [noti userInfo];
    // 获取键盘信息
    CGRect keyboardRect = [userInfo[@"UIKeyboardFrameBeginUserInfoKey"] CGRectValue];
    CGFloat keyboardHeight = CGRectGetHeight(keyboardRect);
    CGFloat keyboardDuration = [userInfo[@"UIKeyboardAnimationDurationUserInfoKey"] floatValue];
    // 修改控件下边约束
    [_userNameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-20);
    }];
    [_userNameTextField mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-20);
    }];
    // 更新约束
    [UIView animateWithDuration:keyboardDuration animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
