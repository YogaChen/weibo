//
//  NBStatusCell.h
//  weibo
//
//  Created by yoga on 15/9/3.
//  Copyright (c) 2015年 ioslearning. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NBStatusFrame;

@interface NBStatusCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) NBStatusFrame *statusFrame;

@end
