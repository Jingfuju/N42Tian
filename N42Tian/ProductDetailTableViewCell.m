//
//  ProductDetailTableViewCell.m
//  N42Tian
//
//  Created by apple on 21/1/2017.
//  Copyright © 2017 N42Tian. All rights reserved.
//

#import "ProductDetailTableViewCell.h"
#import "productInfo.h"
#import "common_macro.h"



@interface ProductDetailTableViewCell ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (assign, nonatomic) NSInteger imageCount;

@end

@implementation ProductDetailTableViewCell{
    UIImageView *_imgVLeft;
    UIImageView *_imgVCenter;
    UIImageView *_imgVRight;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.scrollView.frame = CGRectMake(0, 0 , kScreenWidth, 250);
    self.scrollView.contentSize = CGSizeMake(self.scrollView.bounds.size.width * 3, self.scrollView.bounds.size.height);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;

    [self addImageViewsToScrollView];
    [self setDefaultInfo];
    self.scrollView.delegate = self; //Fix Page controll is not scrolled with scroll view issue;
    
    self.pageControl.numberOfPages = kImageViewCount;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - static method

+ (instancetype)productDetailTableViewCellWith:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    NSString *identifier;
    NSInteger index = 0;
    switch (indexPath.row) {
        case 0:
            identifier = @"productDetailTableViewCellFirst";
            index = 0;
            break;
        case 1:
            identifier = @"productDetailTableViewCellSecond";
            index = 1;
            break;
        case 2:
            identifier = @"productDetailTableViewCellThird";
            index = 2;
            break;
        default:
            break;
    }
    NSLog(@"prodecuct cell indexpath is %ld",indexPath.row);
    ProductDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ProductDetailTableViewCell" owner:self options:nil] objectAtIndex:index];
    }
    return cell;
}

+ (CGFloat)productDetailTableViewCellWith:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            return 250.f;
            break;
        case 1:
            return 80.f;
            break;
        case 2:
            return 300.f;
            break;
        default:
            break;
    }
    return 44.f;
}

+ (NSInteger)productDetailTableViewCellCount
{
    return kTableViewCellCount;
}

#pragma mark - scrollView related method

- (void)addImageViewsToScrollView
{
    CGFloat w = self.scrollView.frame.size.width;
    CGFloat h = self.scrollView.frame.size.height;
    
    _imgVLeft = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, w, h)];
//    imgVLeft.contentMode = UIViewContentModeScaleAspectFit;
    [self.scrollView addSubview:_imgVLeft];
    
    _imgVCenter = [[UIImageView alloc] initWithFrame:CGRectMake(w, 0, w, h)];
//    imgVCenter.contentMode = UIViewContentModeScaleAspectFit;
    [self.scrollView addSubview:_imgVCenter];
    
    _imgVRight = [[UIImageView alloc] initWithFrame:CGRectMake(w * 2, 0, w, h)];
//    imgVRight.contentMode = UIViewContentModeScaleAspectFit;
    [self.scrollView addSubview:_imgVRight];
}

- (void)setInfoByCurrentImageIndex:(NSInteger)currentImageIndex
{
    NSString *currentImageNamed = [NSString stringWithFormat:@"%ld.png", (long)currentImageIndex];
    _imgVCenter.image = [UIImage imageNamed:currentImageNamed];
    if (currentImageIndex == 1) {
        _imgVLeft.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.png", kImageViewCount]];
    } else {
        _imgVLeft.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld.png", (long)(currentImageIndex - 1)]];
    }
    if (currentImageIndex == kImageViewCount) {
        _imgVRight.image = [UIImage imageNamed:[NSString stringWithFormat:@"1.png"]];
    } else {
        _imgVRight.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld,png", (long)(currentImageIndex + 1)]];
    }
}

- (void)setDefaultInfo
{
    _imageCount = 1;
    self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width, 0);
    [self setInfoByCurrentImageIndex:_imageCount];
    self.pageControl.currentPage = _imageCount - 1;
}

- (void)reloadImage
{
    CGPoint contentOffset = [self.scrollView contentOffset];
    CGFloat w = self.scrollView.frame.size.width;
    if (contentOffset.x > w && _imageCount < kImageViewCount) {
        _imageCount = _imageCount + 1;
    } else if (contentOffset.x > w && _imageCount == kImageViewCount) {
        _imageCount = 1;
    } else if (contentOffset.x < w && _imageCount > 1) {
        _imageCount = _imageCount - 1;
    } else if (contentOffset.x < w && _imageCount == 1) {
        _imageCount = kImageViewCount;
    }
    [self setInfoByCurrentImageIndex:_imageCount];
}

#pragma mark - UIScrollView Delegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self reloadImage];
    
    self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width, 0);
    self.pageControl.currentPage = _imageCount - 1;
}

#pragma mark - pageControl

- (IBAction)pageChanged:(UIPageControl *)sender
{
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _imageCount = sender.currentPage + 1;
        [self setInfoByCurrentImageIndex:_imageCount];
        self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width, 0);
    }completion:nil];
}

@end
