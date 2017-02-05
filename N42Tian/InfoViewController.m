//
//  InfoViewController.m
//  N42Tian
//
//  Created by apple on 11/1/2017.
//  Copyright © 2017 N42Tian. All rights reserved.
//

#import "InfoViewController.h"
#import "common_macro.h"
#import "TabMyHeadCell.h"
#import "TabMyOrderItemCell.h"
#import "TabMyCell.h"


typedef enum {
    sectionHead = 0,
    sectionOrder,
    sectionCoupon,
    sectionSupport
} section;


@interface InfoViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation InfoViewController {
    UITableView *_tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Created Navigation Bar
    UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
    UINavigationItem *item = [[UINavigationItem alloc]initWithTitle:@"My Info"];
    [navBar pushNavigationItem:item animated:YES];
    [self.view addSubview:navBar];
    
    //Created Table View
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight)];
    _tableView.delegate = self;
    _tableView.tableFooterView = [[UIView alloc]init]; //Make empty after last line
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [_tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDataSource
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    } else {
        return 10;
    }
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return sectionSupport + 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == sectionHead) {
        return 1;
    } else if (section == sectionOrder){
        return 2;
    } else if (section == sectionCoupon) {
        return 3;
    } else if (section == sectionSupport) {
        return 3;
    } else {
        return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier;
    long section = indexPath.section;
    long row = indexPath.row;
    
    //sectionHead
    if (section == sectionHead) {
        identifier = @"TabMyHeadCell";
        TabMyHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[TabMyHeadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        return cell;
    }
    
    else if (section == sectionOrder) {
        if (row == 0) {
            identifier = @"TabMyCell";
            TabMyCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil) {
                cell = [[TabMyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier imageNamed:@"icon_my_order" title:@"My Order"];
            }
            return cell;
        } else {
            identifier = @"TabMyOrderItemCell";
            TabMyOrderItemCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil) {
                cell = [[TabMyOrderItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            }
            return cell;
        }
    }
    
    else if (section == sectionCoupon) {
        identifier = @"TabMyCell";
        TabMyCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            if (row == 0) {
                cell = [[TabMyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier imageNamed:@"icon_my_coupon" title:@"My Coupon"];
            } else if (row == 1) {
                cell = [[TabMyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier imageNamed:@"icon_my_collect" title:@"My Collection"];
            } else {
                cell = [[TabMyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier imageNamed:@"icon_my_history" title:@"My History"];
            }
        }
        return cell;
    }
    
    else if (section == sectionSupport) {
        identifier = @"TabMyCell";
        TabMyCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil ) {
            if (row == 0) {
                cell = [[TabMyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier imageNamed:@"icon_location_light" title:@"Store Locations"];
            } else if (row == 1) {
                cell = [[TabMyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier imageNamed:@"icon_my_star" title:@"About Us"];
            } else {
                cell = [[TabMyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier imageNamed:@"icon_my_setting" title:@"Setting"];
            }
            
        }
        return cell;
        
    }
    
    else {
        identifier = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        return cell;
    }
}

#pragma mark - TableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == sectionHead) {
        return [TabMyHeadCell height];
    } else {
        return 44;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
