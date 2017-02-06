//
//  FirstTimeLaunchScreen.h
//  N42Tian
//
//  Created by Jingfu Ju on 2/4/17.
//  Copyright © 2017 N42Tian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstTimeLaunchScreen : UIViewController 

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) IBOutlet UIPageControl *pageControl;

- (IBAction)enter:(id)sender;
- (IBAction)pageChanged:(id)sender;
@end
