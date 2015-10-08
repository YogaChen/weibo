//
//  NBStatusCell.m
//  weibo
//
//  Created by yoga on 15/9/3.
//  Copyright (c) 2015年 ioslearning. All rights reserved.
//

#import "NBStatusCell.h"
#import "NBStatusDetailView.h"
#import "NBStatusToolbar.h"
#import "NBStatusFrame.h"

@interface NBStatusCell()

@property (nonatomic, weak) NBStatusDetailView *detailView;
@property (nonatomic, weak) NBStatusToolbar *toolbar;

@end

@implementation NBStatusCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"status";
    NBStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[NBStatusCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) { // 初始化子控件
        // 1.添加微博具体内容
        NBStatusDetailView *detailView = [[NBStatusDetailView alloc] init];
        [self.contentView addSubview:detailView];
        self.detailView = detailView;
        
        // 2.添加工具条
        NBStatusToolbar *toolbar = [[NBStatusToolbar alloc] init];
        [self.contentView addSubview:toolbar];
        self.toolbar = toolbar;
        
        // 3.cell的设置
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setStatusFrame:(NBStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    // 1.微博具体内容的frame数据
    self.detailView.detailFrame = statusFrame.detailFrame;
    
    // 2.底部工具条的frame数据
    self.toolbar.frame = statusFrame.toolbarFrame;
    self.toolbar.status = statusFrame.status;
}
@end