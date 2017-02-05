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

@interface FirstTimeLaunchScreen ()

@end

@implementation FirstTimeLaunchScreen

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(IBAction)enter:(id)sender {
    TabBarController *tabBarController = [[TabBarController alloc] init];
    [self presentViewController:tabBarController animated:YES completion:nil];
    
    HomeViewController *homeViewController = (HomeViewController *)tabBarController.viewControllers[0];
    homeViewController.managedObjectContext = self.managedObjectContext;
    
    CartViewController *cartViewController = (CartViewController *)tabBarController.viewControllers[1];
    cartViewController.managedObjectContext = self.managedObjectContext;
}
@end
