//
//  TabBarController.m
//  N42Tian
//
//  Created by Jingfu Ju on 2/2/17.
//  Copyright © 2017 N42Tian. All rights reserved.
//

#import "TabBarController.h"
#import "HomeViewController.h"
#import "CartViewController.h"
#import "InfoViewController.h"
#import "LoginViewController.h"
#import "common_macro.h"


#import "common_macro.h"

@interface TabBarController ()

@end

@implementation TabBarController {
    HomeViewController *homeController;
    CartViewController *cartController;
    InfoViewController *infoController;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        homeController = [[HomeViewController alloc] init];
        homeController.tabBarItem = [self createTabBarItem:@"Home" imageNamed:@"rsz_home" selectedImageNamed:@"rsz_home"];

        cartController = [[CartViewController alloc] init];
        cartController.tabBarItem = [self createTabBarItem:@"cart" imageNamed:@"rsz_cart" selectedImageNamed:@"rsz_cart"];

        infoController = [[InfoViewController alloc] init];
        infoController.tabBarItem = [self createTabBarItem:@"Me" imageNamed:@"rsz_account" selectedImageNamed:@"rsz_account"];

        self.delegate = self;
        self.viewControllers = @[homeController, cartController, infoController];
    }
    return self;
}

- (void)viewDidLoad {
    NSLog(@"TabBarController");
    [super viewDidLoad];
    //create a custom view for the tab bar
    CGRect frame = CGRectMake(0, 0, self.view.bounds.size.width, 48);
    UIView *tabBarView = [[UIView alloc] initWithFrame:frame];
    [tabBarView setBackgroundColor:[UIColor whiteColor]];
    [tabBarView setAlpha:0.5];
    [[self tabBar] addSubview:tabBarView];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UITabBarItem *)createTabBarItem:(NSString *)title imageNamed:(NSString *)imageNamed selectedImageNamed:selectedImageNamed {
    UIImage *image = [[UIImage imageNamed:imageNamed] imageWithRenderingMode:UIImageRenderingModeAutomatic];
    UIImage *selectedImage = [[UIImage imageNamed:selectedImageNamed] imageWithRenderingMode:UIImageRenderingModeAutomatic];
    UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:title
                                                             image:image
                                                     selectedImage:selectedImage];

    return tabBarItem;
}

- (BOOL)isLogin
{
    return NO;
}

#pragma mark = UITabBarDelegate
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(nonnull UIViewController *)viewController {
    if (viewController == homeController) {
        [tabBarController setSelectedIndex:0];
    } else if (viewController == cartController) {
        [tabBarController setSelectedIndex:1];
    } else {
        if (![self isLogin]) {
            LoginViewController * controller = [[LoginViewController alloc] init];
            controller.hidesBottomBarWhenPushed = YES;
            self.navigationController.navigationBar.hidden = YES;
            self.navigationController.interactivePopGestureRecognizer.enabled = YES;
            [self.navigationController pushViewController:controller animated:YES];
//            [self presentViewController:controller animated:YES completion:nil];
        } else {
            [tabBarController setSelectedIndex:2];
        }
    }
}

@end
