//
//  LoginViewController.m
//  N42Tian
//
//  Created by apple on 2/2/2017.
//  Copyright © 2017 N42Tian. All rights reserved.
//

#import "LoginViewController.h"
#import "SignupViewController.h"
#import "View+MASAdditions.h"
#import "common_macro.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
{
    UITextField * _userName;
    UITextField * _userPassword;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:230.0/255 green:230.0/255 blue:230.0/255 alpha:1.0f];
    
    // Created Navigation Bar
    UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
    UINavigationItem *navItem = [[UINavigationItem alloc] initWithTitle:@"Login"];
    [navBar pushNavigationItem:navItem animated:YES];
    
    UIBarButtonItem * navLeftButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"arrow_20"] style:UIBarButtonItemStylePlain target:self action:@selector(backToParentView)];
    navItem.leftBarButtonItem = navLeftButton;
    UIBarButtonItem * navRightButton = [[UIBarButtonItem alloc] initWithTitle:@"Signup" style:UIBarButtonItemStylePlain target:self action:@selector(goToNextPage)];
    navItem.rightBarButtonItem = navRightButton;
    
    [self.view addSubview:navBar];
    
    // Created login logo
    NSInteger imageViewWidth = 100;
    
    UIImageView * imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake((kScreenWidth - imageViewWidth) / 2, (kScreenHeight - imageViewWidth) / 2 - 120, imageViewWidth, imageViewWidth);
    
    imageView.image = [UIImage imageNamed:@"portrait"];
    [self setHeadPortrait:imageView];
    [self.view addSubview:imageView];
    
    // Created name and password textField
    NSInteger nameWidth = kScreenWidth - 100;
    NSInteger nameHeight = 31;
    
    _userName = [[UITextField alloc] init];
    _userName.placeholder = @"Name";
    
    _userName.frame = CGRectMake((kScreenWidth - nameWidth) / 2, (kScreenHeight - nameHeight) / 2 - 40, nameWidth, nameHeight);
    _userName.backgroundColor = [UIColor whiteColor];
    _userName.layer.cornerRadius = 2;
    _userName.textAlignment = 1; // NSTextAlignmentCenter
    [self.view addSubview:_userName];
    _userName.delegate = self;
    
    _userPassword = [[UITextField alloc] init];
    _userPassword.placeholder = @"Password";
    
    _userPassword.frame = CGRectMake(_userName.frame.origin.x, _userName.frame.origin.y + _userName.frame.size.height + 1, _userName.frame.size.width, _userName.frame.size.height);
    _userPassword.backgroundColor = [UIColor whiteColor];
    _userPassword.layer.cornerRadius = 2;
    _userPassword.textAlignment = 1;
    [self.view addSubview:_userPassword];
    _userPassword.delegate = self;
    
    // Created login Button
    NSInteger loginWidth = nameWidth - 20;
    NSInteger loginHight = nameHeight;
    
    UIButton * loginButton = [[UIButton alloc] init];
    [loginButton setTitle:@"Login" forState:UIControlStateNormal];
    loginButton.titleLabel.textAlignment = 1;
    loginButton.titleLabel.textColor = [UIColor whiteColor];
    
    loginButton.frame = CGRectMake((kScreenWidth - loginWidth) / 2, _userPassword.frame.origin.y + _userPassword.frame.size.height + 10, loginWidth, loginHight);
    loginButton.backgroundColor = [UIColor colorWithRed:0/255. green:128/255. blue:255/255. alpha:1.0];
    loginButton.layer.cornerRadius = 2;
    [self.view addSubview:loginButton];
    [loginButton addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    
    // Created Wechat login part
    UILabel * line = [[UILabel alloc] init];
    line.frame = CGRectMake(10, loginButton.frame.origin.y + loginButton.frame.size.height + 50, kScreenWidth - 20, 1);
    line.backgroundColor = [UIColor colorWithRed:200/255. green:200/255. blue:200/255. alpha:1.0];
    [self.view addSubview:line];
    
    CGFloat gridWidth = (kScreenWidth - 40) / 3;
    CGFloat buttonWidth = 60;

    CGFloat gridXInit = 20;
    CGFloat gridButtonInit = gridXInit + (gridWidth - buttonWidth) / 2;
    CGFloat gridY = line.frame.origin.y + 21;
    
    UIButton *qq = [UIButton new];
    UIButton *weChat = [UIButton new];
    UIButton *linkedin = [UIButton new];
    
    qq.frame = CGRectMake(gridButtonInit, gridY, buttonWidth, buttonWidth);
    [qq setImage:[UIImage imageNamed:@"qq"] forState:0];  // set the button image
    [qq.layer setMasksToBounds:YES];
    [qq.layer setCornerRadius:buttonWidth / 2];  // set radius if button corner
    [self.view addSubview:qq];
    
    weChat.frame = CGRectMake(gridButtonInit + gridWidth, gridY, buttonWidth, buttonWidth);
    [weChat setImage:[UIImage imageNamed:@"weChat"] forState:0];  // set the button image
    [weChat.layer setMasksToBounds:YES];
    [weChat.layer setCornerRadius:buttonWidth / 2];  // set radius if button corner
    [self.view addSubview:weChat];
    
    linkedin.frame = CGRectMake(gridButtonInit + gridWidth * 2, gridY, buttonWidth, buttonWidth);
    [linkedin setImage:[UIImage imageNamed:@"linkedIn"] forState:0];  // set the button image
    [linkedin.layer setMasksToBounds:YES];
    [linkedin.layer setCornerRadius:buttonWidth / 2];  // set radius if button corner
    [self.view addSubview:linkedin];
    
    // Created forgot password button
    UIButton *forgotPw = [UIButton new];
    [forgotPw setTitle:@"Forgot Password/Username?" forState:UIControlStateNormal];  // set button title
    forgotPw.titleLabel.font = [UIFont systemFontOfSize:12.0];  // set font size
    [forgotPw setTitleColor:[UIColor colorWithRed:0/255. green:128/255. blue:255/255. alpha:1.0] forState:UIControlStateNormal];
    [forgotPw setTitleColor:[UIColor colorWithRed:255/255. green:0/255. blue:0/255. alpha:1.0] forState:UIControlStateHighlighted];
    forgotPw.frame = CGRectMake(kScreenWidth - 180, kScreenHeight - 35, 170, 25);
    [forgotPw.titleLabel setAdjustsFontSizeToFitWidth:YES];
    
    [self.view addSubview:forgotPw];
    
    // touch no keyboard area to resign the keyboard
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyboard:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

// set head portrait style
- (void)setHeadPortrait:(UIImageView *) imageView
{
    imageView.layer.cornerRadius = imageView.frame.size.width / 2;
    imageView.layer.masksToBounds = YES;
    imageView.layer.borderWidth = 1.5f;
    imageView.layer.borderColor = [UIColor whiteColor].CGColor;
}

- (void)backToParentView{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)goToNextPage
{
    SignupViewController * controller = [[SignupViewController alloc] init];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)login:(UIButton *)sender
{
    if ([_userName.text length] == 0 || _userName.text == nil ||
        [_userPassword.text length] == 0 || _userPassword.text == nil) {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Login Error"
                                  message:@"User name or password cannot be empty!"
                                  delegate:nil
                                  cancelButtonTitle: @"OK"
                                  otherButtonTitles: nil, nil];
        alertView.delegate = self;
        [alertView show];
    }
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)closeKeyboard:(id)sender
{
    [self.view endEditing:YES];
}

@end
