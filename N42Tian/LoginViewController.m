//
//  LoginViewController.m
//  N42Tian
//
//  Created by apple on 2/2/2017.
//  Copyright © 2017 N42Tian. All rights reserved.
//

#import "LoginViewController.h"
#import "View+MASAdditions.h"
#import "common_macro.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

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
    //    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.equalTo(kScreenWidth)
    //    }]
    
    imageView.image = [UIImage imageNamed:@"portrait"];
    [self setHeadPortrait:imageView];
    [self.view addSubview:imageView];
    
    // Created name and password textField
    NSInteger nameWidth = kScreenWidth - 100;
    NSInteger nameHeight = 31;
    
    UITextField * userName = [[UITextField alloc] init];
    userName.placeholder = @"Name";
    
    userName.frame = CGRectMake((kScreenWidth - nameWidth) / 2, (kScreenHeight - nameHeight) / 2 - 40, nameWidth, nameHeight);
    userName.backgroundColor = [UIColor whiteColor];
    userName.layer.cornerRadius = 2;
    userName.textAlignment = 1; // NSTextAlignmentCenter
    [self.view addSubview:userName];
    
    UITextField * userPassword = [[UITextField alloc] init];
    userPassword.placeholder = @"Password";
    
    userPassword.frame = CGRectMake(userName.frame.origin.x, userName.frame.origin.y + userName.frame.size.height + 1, userName.frame.size.width, userName.frame.size.height);
    userPassword.backgroundColor = [UIColor whiteColor];
    userPassword.layer.cornerRadius = 2;
    userPassword.textAlignment = 1;
    [self.view addSubview:userPassword];
    
    // Created login Button
    NSInteger loginWidth = nameWidth - 20;
    NSInteger loginHight = nameHeight;
    
    UIButton * loginButton = [[UIButton alloc] init];
    [loginButton setTitle:@"Login" forState:UIControlStateNormal];
    loginButton.titleLabel.textAlignment = 1;
    loginButton.titleLabel.textColor = [UIColor whiteColor];
    
    loginButton.frame = CGRectMake((kScreenWidth - loginWidth) / 2, userPassword.frame.origin.y + userPassword.frame.size.height + 10, loginWidth, loginHight);
    loginButton.backgroundColor = [UIColor colorWithRed:0/255. green:128/255. blue:255/255. alpha:1.0];
    loginButton.layer.cornerRadius = 2;
    [self.view addSubview:loginButton];
    
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
    UIButton *gmail = [UIButton new];
    
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
    
    gmail.frame = CGRectMake(gridButtonInit + gridWidth * 2, gridY, buttonWidth, buttonWidth);
    [gmail setImage:[UIImage imageNamed:@"gmail"] forState:0];  // set the button image
    [gmail.layer setMasksToBounds:YES];
    [gmail.layer setCornerRadius:buttonWidth / 2];  // set radius if button corner
    [self.view addSubview:gmail];
    
    // Created forgot password button
    UIButton *forgotPw = [UIButton new];
    [forgotPw setTitle:@"Forgot Password/Username?" forState:UIControlStateNormal];  // set button title
    forgotPw.titleLabel.font = [UIFont systemFontOfSize:12.0];  // set font size
    [forgotPw setTitleColor:[UIColor colorWithRed:0/255. green:128/255. blue:255/255. alpha:1.0] forState:UIControlStateNormal];
    [forgotPw setTitleColor:[UIColor colorWithRed:255/255. green:0/255. blue:0/255. alpha:1.0] forState:UIControlStateHighlighted];
    forgotPw.frame = CGRectMake(kScreenWidth - 180, kScreenHeight - 35, 170, 25);
    [forgotPw.titleLabel setAdjustsFontSizeToFitWidth:YES];
    
    [self.view addSubview:forgotPw];
}

// set head portrait style
- (void)setHeadPortrait:(UIImageView *) imageView
{
    imageView.layer.cornerRadius = imageView.frame.size.width / 2;
    imageView.layer.masksToBounds = YES;
    imageView.layer.borderWidth = 1.5f;
    imageView.layer.borderColor = [UIColor whiteColor].CGColor;
}

- (void)backToParentView
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)goToNextPage
{
    // signup page
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
