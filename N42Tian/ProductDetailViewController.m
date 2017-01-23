//
//  ProductDetailViewController.m
//  N42Tian
//
//  Created by apple on 18/1/2017.
//  Copyright © 2017 N42Tian. All rights reserved.
//

#import "ProductDetailViewController.h"
#import "ProductInfoViewController.h"
#import "CategoryLabel.h"
#import "ProductDetailCheckoutViewController.h"
#import "CartViewController.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width

@interface ProductDetailViewController ()

@property (nonatomic, strong) NSArray *categories;
@property (nonatomic, strong) ProductInfoViewController *PIVC;

@end

@implementation ProductDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self simulateData];
    [self loadSubViews];
    _bigScrollView.pagingEnabled = YES;
    _bigScrollView.showsHorizontalScrollIndicator = NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)close:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)addToCart:(id)sender
{
    ProductDetailCheckoutViewController *controller = [[ProductDetailCheckoutViewController alloc] initWithNibName:@"ProductDetailCheckoutViewController" bundle:nil];
    
    [self.view addSubview:controller.view];
    [self addChildViewController:controller];
    [controller didMoveToParentViewController:self];
}

- (IBAction)goToCart:(id)sender
{
//    [self dismissViewControllerAnimated:YES completion:^{
//        UIStoryboard *tableViewStoryboard = [UIStoryboard storyboardWithName:@"main" bundle:nil];
//        CartViewController * controller = [tableViewStoryboard instantiateViewControllerWithIdentifier:@"CartViewIdentifier"];
//        [self presentViewController:controller animated:YES completion:nil];
//    }];
//    
}

#pragma mark - private method

- (void)simulateData
{
    self.categories = [[NSArray alloc] initWithObjects:@"Details", @"Related", @"Reviews", nil];
}

- (void)addChildViewController
{
    for (int i = 0; i < self.categories.count; i++) {
        NSString *title = [self.categories objectAtIndex:i];
        ProductInfoViewController *prodInfoViewController = [[ProductInfoViewController alloc] initWithNibName:@"ProductInfoViewController" bundle:nil];
        prodInfoViewController.title = title;
        prodInfoViewController.index = i;
        [self addChildViewController:prodInfoViewController];
    }
}

- (void)addNavigateLabel
{
    for (int i = 0; i < self.categories.count; i++) {
        CGFloat lblW = 90;
        CGFloat lblX = (self.smallScrollView.frame.size.width - lblW * self.categories.count) / 2 + i * lblW;
        CategoryLabel *lbl1 = [[CategoryLabel alloc] init];
        UIViewController *vc = self.childViewControllers[i];
        lbl1.content = vc.title;
        lbl1.frame = CGRectMake(lblX, 0, lblW, self.smallScrollView.frame.size.height);
        lbl1.tag = i;
        [self.smallScrollView addSubview:lbl1];
        [lbl1 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lblClick:)]];
        self.smallScrollView.contentSize = CGSizeMake(90 * (i + 1), 0);
    }
}

- (void) lblClick:(UITapGestureRecognizer *)recognizer
{
    CategoryLabel *titlelabel = (CategoryLabel *)recognizer.view;
    CGFloat offsetX = titlelabel.tag * self.bigScrollView.frame.size.width;
    CGFloat offsetY = self.bigScrollView.contentOffset.y;
    CGPoint offset = CGPointMake(offsetX, offsetY);
    [self.bigScrollView setContentOffset:offset animated:YES];
}

- (void)loadSubViews
{
    [self addChildViewController];
    [self addNavigateLabel];
    CGFloat contentX = self.childViewControllers.count * ScreenWidth;
    self.bigScrollView.contentSize = CGSizeMake(contentX, 0);
    ProductInfoViewController *prodInfoViewController = [self.childViewControllers firstObject];
    prodInfoViewController.view.frame = self.bigScrollView.bounds;
    [self.bigScrollView addSubview:prodInfoViewController.view];
    CategoryLabel *label = [self.smallScrollView.subviews firstObject];
    label.scale = 1.0;
}

#pragma mark - UIScrollView Delegat Methods

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    NSUInteger index = scrollView.contentOffset.x / self.bigScrollView.frame.size.width;
    
    self.PIVC = self.childViewControllers[index];
    for (UIImageView *view in self.smallScrollView.subviews) { // remove two UIImageView from smallScrollView
        if ([view isKindOfClass:[UIImageView class]]) {        // however I don't know where it comes from
            [view removeFromSuperview];
        }
    }
    [self.smallScrollView.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (idx != index) {
            CategoryLabel *temlabel = self.smallScrollView.subviews[idx];
            temlabel.scale = 0.0;
        }
    }];
    if (self.PIVC.view.superview) return;
    self.PIVC.view.frame = scrollView.bounds;
    [self.bigScrollView addSubview:self.PIVC.view];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat value = ABS(scrollView.contentOffset.x / scrollView.frame.size.width);
    NSUInteger leftIndex = (int)value;
    NSUInteger rightIndex = leftIndex + 1;
    CGFloat scaleRight = value - leftIndex;
    CGFloat scaleLeft = 1 - scaleRight;
    for (UIImageView *view in self.smallScrollView.subviews) { // remove two UIImageView from smallScrollView
        if ([view isKindOfClass:[UIImageView class]]) {        // however I don't know where it comes from
            [view removeFromSuperview];
        }
    }
    CategoryLabel *labelLeft = self.smallScrollView.subviews[leftIndex];
    labelLeft.scale = scaleLeft;
    if (rightIndex < self.smallScrollView.subviews.count) {
        CategoryLabel *labelRight = self.smallScrollView.subviews[rightIndex];
        labelRight.scale = scaleRight;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

@end
