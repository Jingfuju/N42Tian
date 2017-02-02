//
//  EmptyCartTableViewCell.h
//  N42Tian
//
//  Created by Jingfu Ju on 1/21/17.
//  Copyright © 2017 N42Tian. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EmptyCartTableViewCell;

@protocol EmptyCartTableViewCellDelegate <NSObject>

-(void)popHomeViewPage;

@end



@interface EmptyCartTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIImageView *image;
@property (nonatomic, weak) IBOutlet UIButton *button;
@property (nonatomic, weak) id <EmptyCartTableViewCellDelegate> delegate;



-(IBAction)shopNow:(id)sender;



@end
