//
//  AppDelegate.h
//  N42Tian
//
//  Created by Jingfu Ju on 1/11/17.
//  Copyright © 2017 N42Tian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "HomeViewController.h"
#import "InfoViewController.h"
#import "CartViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


@property (strong, nonatomic) HomeViewController *homeViewController;
@property (strong, nonatomic) InfoViewController *infoViewController;
@property (strong, nonatomic) CartViewController *cartViewController;


@end

