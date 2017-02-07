//
//  SignupViewController.m
//  N42Tian
//
//  Created by apple on 5/2/2017.
//  Copyright © 2017 N42Tian. All rights reserved.
//

#import "SignupViewController.h"
#import "LoginViewController.h"
#import "common_macro.h"

@interface SignupViewController ()

@end

@implementation SignupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:230.0/255 green:230.0/255 blue:230.0/255 alpha:1.0f];
    
    // Created Navigation Bar
    UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
    UINavigationItem *navItem = [[UINavigationItem alloc] initWithTitle:@"Signup"];
    [navBar pushNavigationItem:navItem animated:YES];
    
    UIBarButtonItem * navLeftButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"arrow_20"] style:UIBarButtonItemStylePlain target:self action:@selector(popSelfController)];
    navItem.leftBarButtonItem = navLeftButton;
    UIBarButtonItem * navRightButton = [[UIBarButtonItem alloc] initWithTitle:@"Login" style:UIBarButtonItemStylePlain target:self action:@selector(popSelfController)];
    navItem.rightBarButtonItem = navRightButton;
    
    [self.view addSubview:navBar];

    // Created phone number textField
    NSInteger textFieldWidth = kScreenWidth - 100;
    NSInteger idButtonWidth = (textFieldWidth - 1) / 3 + 10;
    NSInteger textFieldHeight = 31;
    
    UITextField * phoneNumber = [[UITextField alloc] init];
    phoneNumber.placeholder = @"Phone number";
    phoneNumber.font = [UIFont systemFontOfSize:14.0];
    
    phoneNumber.frame = CGRectMake((kScreenWidth - textFieldWidth) / 2, (kScreenHeight - 100) / 2 - 120, textFieldWidth - idButtonWidth - 1, textFieldHeight);
    phoneNumber.backgroundColor = [UIColor whiteColor];
    phoneNumber.layer.cornerRadius = 2;
    phoneNumber.textAlignment = 1;
    [self.view addSubview:phoneNumber];
    
    UIButton * idButton = [[UIButton alloc] init];
    [idButton setTitle:@"Verification" forState:UIControlStateNormal];
    idButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
    idButton.titleLabel.textAlignment = 1;
    [idButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    idButton.frame = CGRectMake(phoneNumber.frame.origin.x + phoneNumber.frame.size.width + 1 , phoneNumber.frame.origin.y, idButtonWidth, textFieldHeight);
    idButton.backgroundColor = [UIColor colorWithRed:200/255. green:200/255. blue:200/255. alpha:1.0];
    idButton.layer.cornerRadius = 2;
    [self.view addSubview:idButton];
    
    UITextField * idCode = [[UITextField alloc] init];
    idCode.placeholder = @"Verification Code";
    idCode.font = [UIFont systemFontOfSize:14.0];
    
    idCode.frame = CGRectMake(phoneNumber.frame.origin.x, phoneNumber.frame.origin.y + textFieldHeight + 1, textFieldWidth, textFieldHeight);
    idCode.backgroundColor = [UIColor whiteColor];
    idCode.layer.cornerRadius = 2;
    idCode.textAlignment = 1;
    [self.view addSubview:idCode];
    
    // Created name and password textField
    UITextField * userName = [[UITextField alloc] init];
    userName.placeholder = @"Create an username";
    userName.font = [UIFont systemFontOfSize:14.0];

    userName.frame = CGRectMake(phoneNumber.frame.origin.x, idCode.frame.origin.y + textFieldHeight + 10, textFieldWidth, textFieldHeight);
    userName.backgroundColor = [UIColor whiteColor];
    userName.layer.cornerRadius = 2;
    userName.textAlignment = 1;
    [self.view addSubview:userName];
    
    UITextField * userPassword = [[UITextField alloc] init];
    userPassword.placeholder = @"Create a password";
    userPassword.font = [UIFont systemFontOfSize:14.0];

    userPassword.frame = CGRectMake(userName.frame.origin.x, userName.frame.origin.y + userName.frame.size.height + 5, userName.frame.size.width, userName.frame.size.height);
    userPassword.backgroundColor = [UIColor whiteColor];
    userPassword.layer.cornerRadius = 2;
    userPassword.textAlignment = 1;
    [self.view addSubview:userPassword];
    
    UITextField * rePassword = [[UITextField alloc] init];
    rePassword.placeholder = @"Re-enter the password";
    rePassword.font = [UIFont systemFontOfSize:14.0];

    rePassword.frame = CGRectMake(userName.frame.origin.x, userPassword.frame.origin.y + userName.frame.size.height + 1, userName.frame.size.width, userName.frame.size.height);
    rePassword.backgroundColor = [UIColor whiteColor];
    rePassword.layer.cornerRadius = 2;
    rePassword.textAlignment = 1;
    [self.view addSubview:rePassword];
    
    // Created login Button
    NSInteger signupWidth = textFieldWidth - 20;
    NSInteger signupHight = textFieldHeight;
    
    UIButton * signupButton = [[UIButton alloc] init];
    [signupButton setTitle:@"Signup" forState:UIControlStateNormal];
    signupButton.titleLabel.textAlignment = 1;
    [signupButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    signupButton.frame = CGRectMake((kScreenWidth - signupWidth) / 2, rePassword.frame.origin.y + rePassword.frame.size.height + 10, signupWidth, signupHight);
    signupButton.backgroundColor = [UIColor colorWithRed:0/255. green:128/255. blue:255/255. alpha:1.0];
    signupButton.layer.cornerRadius = 2;
    [self.view addSubview:signupButton];

    // Created Wechat signup part
    UILabel * line = [[UILabel alloc] init];
    line.frame = CGRectMake(10, signupButton.frame.origin.y + signupButton.frame.size.height + 50, kScreenWidth - 20, 1);
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)popSelfController{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
