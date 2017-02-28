//
//  FirstTimeLaunchScreen.m
//  N42Tian
//
//  Created by Jingfu Ju on 2/4/17.
//  Copyright © 2017 N42Tian. All rights reserved.
//

#import "FirstTimeLaunchScreen.h"
#import "TabBarController.h"
#import "HomeViewController.h"
#import "CartViewController.h"
#import "common_macro.h"

@interface FirstTimeLaunchScreen () <UIScrollViewDelegate>

@end

@implementation FirstTimeLaunchScreen 
- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollView.delegate = self;
    self.scrollView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    self.scrollView.contentSize = CGSizeMake(kScreenWidth * 3, 0);
    self.scrollView.backgroundColor = [UIColor blackColor];
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;

    self.scrollView.pagingEnabled = YES;
    
    self.pageControl.numberOfPages = 3;
    self.pageControl.currentPage = 0;
    
    UIImageView *firstPageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"grassland"]];
    firstPageView.frame = CGRectMake(0, -20, kScreenWidth, kScreenHeight + 20);
    [self.scrollView addSubview:firstPageView];
    
    UIImageView *secondPageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"green_corn"]];
    secondPageView.frame = CGRectMake(kScreenWidth, -20, kScreenWidth, kScreenHeight + 20);
    [self.scrollView addSubview:secondPageView];
    
    UIImageView *thirdPageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"yellow_corn"]];
    thirdPageView.frame = CGRectMake(kScreenWidth * 2, -20, kScreenWidth, kScreenHeight + 20);
    [self.scrollView addSubview:thirdPageView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"Enter" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont fontWithName:@"AvenirNext-Heavy" size:26.0];
    button.titleLabel.textAlignment = 1;
    
    [button addTarget:self action:@selector(enter:) forControlEvents:UIControlEventTouchUpInside];
    
    button.frame = CGRectMake(kScreenWidth * 2 + kScreenWidth / 2 - 50,  kScreenHeight - 120, 100, 100);
    
    [self.scrollView addSubview:button];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    int currentPage = (self.scrollView.contentOffset.x + kScreenWidth / 2.0f) /kScreenWidth;
    self.pageControl.currentPage = currentPage;
}

- (IBAction)pageChanged:(UIPageControl *)sender {
    self.scrollView.contentOffset = CGPointMake(kScreenWidth * sender.currentPage, 0);
}


- (IBAction)enter:(id)sender{
    TabBarController *tabBarController = [[TabBarController alloc] init];
    
    [self presentViewController:tabBarController animated:YES completion:nil];
    
    HomeViewController *homeViewController = (HomeViewController *)tabBarController.viewControllers[0];
    homeViewController.managedObjectContext = self.managedObjectContext;
    
    CartViewController *cartViewController = (CartViewController *)tabBarController.viewControllers[1];
    cartViewController.managedObjectContext = self.managedObjectContext;
}

@end
