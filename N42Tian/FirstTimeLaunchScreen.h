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
-(IBAction)enter:(id)sender;

@end
