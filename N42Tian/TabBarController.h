//
//  TabBarController.h
//  N42Tian
//
//  Created by Jingfu Ju on 2/2/17.
//  Copyright © 2017 N42Tian. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface TabBarController : UITabBarController


@property (nonatomic, retain) NSArray *viewControllers;

@property (strong, nonatomic) IBOutlet UITabBar *tabBar;
@property (strong, nonatomic) IBOutlet UITabBarItem *home;
@property (strong, nonatomic) IBOutlet UITabBarItem *cart;
@property (strong, nonatomic) IBOutlet UITabBarItem *myInfo;

@end
