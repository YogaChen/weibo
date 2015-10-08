//
//  NBLoadMoreFooter.m
//  weibo
//
//  Created by yoga on 15/8/28.
//  Copyright (c) 2015年 ioslearning. All rights reserved.
//

#import "NBLoadMoreFooter.h"

@interface NBLoadMoreFooter ()

@property (weak, nonatomic) IBOutlet UILabel *loadMoreLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicatorView;


@end

@implementation NBLoadMoreFooter

+ (instancetype)footer
{
    return [[[NSBundle mainBundle] loadNibNamed:@"NBLoadMoreFooter" owner:nil options:nil] lastObject];
}

- (void)awakeFromNib
{
//    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithNamed:@"timeline_new_status_background"]];
    self.loadMoreLabel.textColor = [UIColor grayColor];
}

- (void)beginRefreshing
{
    self.loadMoreLabel.text = @"正在拼命加载更多数据";
    [self.indicatorView startAnimating];
    self.refreshing = YES;
}

- (void)endRefreshing
{
    self.loadMoreLabel.text = @"上拉可以加载更多数据";
    [self.indicatorView stopAnimating];
    self.refreshing = NO;
}

@end
