//
//  NBHomeController.m
//  weibo
//
//  Created by yoga on 15/8/24.
//  Copyright (c) 2015年 ioslearning. All rights reserved.
//

#import "NBHomeController.h"
#import "HMOneViewController.h"
#import "NBTitleButton.h"
#import "NBPopMenu.h"
#import "NBAccountTool.h"
#import "NBAccount.h"
#import "NBStatus.h"
#import "MJExtension.h"
#import "NBUser.h"
#import "UIImageView+WebCache.h"
#import "NBLoadMoreFooter.h"
#import "NBStatusTool.h"
#import "NBHomeStatusesParam.h"
#import "NBUserInfoParam.h"
#import "NBUserInfoResult.h"
#import "NBUserTool.h"
#import "NBStatusCell.h"
#import "NBStatusFrame.h"

@interface NBHomeController () <NBPopMenuDelegate>

/** 微博数组(存放着所有的微博frame数据) */
@property (nonatomic, strong) NSMutableArray *statusFrames;

@property (nonatomic , weak) NBTitleButton *titleBtn;
@property (nonatomic , weak) NBLoadMoreFooter *footer;
@property (nonatomic , weak) UIRefreshControl *refreshcontrol;

@end

@implementation NBHomeController

#pragma mark - 初始化
- (NSMutableArray *)statusFrames
{
    if (!_statusFrames) {
        _statusFrames = [NSMutableArray array];
    }
    return _statusFrames;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    NBLog(@"NBHomeController");
    self.tableView.backgroundColor = NBColor(211, 211, 211);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 设置导航栏的内容
    [self setupNavBar];
    
    // 集成下拉刷新数据控件
    [self refreshStatus];
    
    // 获得用户信息
    [self setupUserInfo];

}

/**
 *  获得用户信息
 */
- (void)setupUserInfo
{
    // 1. 封装请求参数
    NBUserInfoParam *param = [NBUserInfoParam param];
    param.uid = [NBAccountTool account].uid;
    
    // 2. 发送GET请求
    [NBUserTool userInfoWithParam:param success:^(NBUserInfoResult *user) {
        // 设置用户的呢称为标题
        [self.titleBtn setTitle:user.name forState:UIControlStateNormal];

        // 存储帐号信息
        NBAccount *account = [NBAccountTool account];
        account.name = user.name;
        [NBAccountTool save:account];
    } failure:^(NSError *error) {
        NBLog(@"setupUserInfo请求失败-------%@", error);
    }];
}

/**
 *  集成下拉刷新数据控件
 */
- (void)refreshStatus
{
    // 1.添加下拉刷新控件
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [self.view addSubview:refreshControl];
    self.refreshcontrol = refreshControl;
    
    // 2.监听状态
    [refreshControl addTarget:self action:@selector(refreshControlStateChange:) forControlEvents:UIControlEventValueChanged];
    
    // 3.让刷新控件自动进入刷新状态
    [refreshControl beginRefreshing];
    
    // 4.加载数据
    [self refreshControlStateChange:refreshControl];
    
    // 5.添加上拉加载更多控件
    NBLoadMoreFooter *footer = [NBLoadMoreFooter footer];
    self.tableView.tableFooterView = footer;
    
    self.footer = footer;
}
/**
 *  当下拉刷新控件进入刷新状态（转圈圈）的时候会自动调用
 */
- (void)refreshControlStateChange:(UIRefreshControl *)refreshControl
{
//    NBLog(@"refreshStatusChanged");
    [self loadNewStatuses:refreshControl];
}

/**
 *  设置导航栏的内容
 */
- (void)setupNavBar
{
    //    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [leftBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_friendsearch"] forState:UIControlStateNormal];
    //    [leftBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_friendsearch_highlighted"] forState:UIControlStateHighlighted];
    //    // 设置按钮的尺寸为背景图片的尺寸
    //    leftBtn.size = leftBtn.currentBackgroundImage.size;
    //    // 监听按钮点击
    //    [leftBtn addTarget:self action:@selector(friendsearch) forControlEvents:UIControlEventTouchUpInside];
    //    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    
    // 设置导航栏按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"navigationbar_friendsearch" highlightedImageName:@"navigationbar_friendsearch_highlighted" target:self action:@selector(friendsearch)];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"navigationbar_pop" highlightedImageName:@"navigationbar_pop_highlighted" target:self action:@selector(pop)];
    
    // 设置title按钮
    NBTitleButton *titleBtn = [[NBTitleButton alloc] init];
    //    titleBtn.backgroundColor = [UIColor redColor];
//    titleBtn.width = 100;
    titleBtn.height = 35;
    
    NSString *name = [NBAccountTool account].name;
    [titleBtn setTitle:name ? name : @"首页" forState:UIControlStateNormal];
    [titleBtn setImage:[UIImage imageWithNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    [titleBtn setBackgroundImage:[UIImage resizeImageWithNamed:@"navigationbar_filter_background_highlighted"] forState:UIControlStateHighlighted];
    
    // 监听按钮点击
    [titleBtn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleBtn;
    self.titleBtn = titleBtn;
}

/**
 *  标题按钮以及弹出菜单
 */
- (void)titleClick:(UIButton *)titleBtn
{
    // 箭头改成向上
    [titleBtn setImage:[UIImage imageWithNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    
    // 弹出菜单
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    btn.backgroundColor = [UIColor greenColor];
    NBPopMenu *popMenu = [NBPopMenu popMenuWithContentView:nil];
    [popMenu showInRect:CGRectMake(75 , 55, 200, 300)];
    //    popMenu.dimBackground = YES;
    //    popMenu.arrowPosition = NBPopMenuArrowPositionLeft;
    popMenu.delegate = self;
    
}

/**
 *  点击左按钮事件
 */
- (void)friendsearch
{
    NBLog(@"friendsearch");
    
    HMOneViewController *one = [[HMOneViewController alloc] init];
    one.title = @"OneVc";
    [self.navigationController pushViewController:one animated:YES];
    
}

/**
 *  点击右按钮事件
 */
- (void)pop
{
    NBLog(@"pop");
}

#pragma mark - 加载微博数据
/**
 *  根据微博模型数组 转成 微博frame模型数据
 *
 *  @param statuses 微博模型数组
 *
 */
- (NSArray *)statusFramesWithStatuses:(NSArray *)statuses
{
    NSMutableArray *frames = [NSMutableArray array];
    for (NBStatus *status in statuses) {
        NBStatusFrame *frame = [[NBStatusFrame alloc] init];
        // 传递微博模型数据，计算所有子控件的frame
        frame.status = status;
        [frames addObject:frame];
    }
    return frames;
}


/**
 *  加载最新的微博数据
 */
- (void)loadNewStatuses:(UIRefreshControl *)refreshControl
{
    // 1. 封装请求参数
    NBHomeStatusesParam *param = [NBHomeStatusesParam param];
    NBStatusFrame *firstStatusFrames = [self.statusFrames firstObject];
    NBStatus *firstStatus = firstStatusFrames.status;
    if (firstStatus) {
        param.since_id = @([firstStatus.idstr longLongValue]);
    }
    
    // 2. 发送GET请求
    [NBStatusTool homeStatusesWithParam:param success:^(NBHomeStatusesResult *result) {
        // 获得最新的微博数组
        NSArray *newStatuses = [self statusFramesWithStatuses:result.statuses];
        // 将新数据插入到旧数据的最前面
        NSRange range = NSMakeRange(0, newStatuses.count);
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.statusFrames insertObjects:newStatuses atIndexes:indexSet];
        
        // 重新刷新表格
        [self.tableView reloadData];
        
        // 让刷新控件停止刷新（恢复默认的状态）
        [refreshControl endRefreshing];
        
        // 提示加载微博数
        [self showNewStatusesCount:(int)newStatuses.count];

    } failure:^(NSError *error) {
        // 让刷新控件停止刷新（恢复默认的状态）
        [refreshControl endRefreshing];
        NBLog(@"loadNewStatuses请求失败-----%@", error);

    }];
    
//    [NBHttpTool get:@"https://api.weibo.com/2/statuses/home_timeline.json" params:params success:^(NSDictionary *resultDict) {
//        // 微博字典数组
//        NSArray *statusDictArray = resultDict[@"statuses"];
//        // 微博字典数组 ---> 微博模型数组
//        NSArray *newStatuses = [NBStatus objectArrayWithKeyValuesArray:statusDictArray];
//        
//        // 将新数据插入到旧数据的最前面
//        NSRange range = NSMakeRange(0, newStatuses.count);
//        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
//        [self.statuses insertObjects:newStatuses atIndexes:indexSet];
//        
//        // 重新刷新表格
//        [self.tableView reloadData];
//        
//        // 让刷新控件停止刷新（恢复默认的状态）
//        [refreshControl endRefreshing];
//        
//        // 提示加载微博数
//        [self showNewStatusesCount:newStatuses.count];
//    } failure:^(NSError *error) {
//        // 让刷新控件停止刷新（恢复默认的状态）
//        [refreshControl endRefreshing];
//        
//    }];
}

/**
 *  提示用户最新的微博数量
 *
 *  @param count 最新的微博数量
 */
- (void)showNewStatusesCount:(int)count
{
    // 1.添加一个UILabel
    UILabel *label = [[UILabel alloc] init];
    
    // 2.显示文字
    if (count) {
        label.text = [NSString stringWithFormat:@"%d条新微博", count];
    }else{
        label.text = @"没有新微博";
    }
    
    // 3.设置背景
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithNamed:@"timeline_new_status_background"]];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    
    // 4.设置frame
    label.width = self.view.width;
    label.height = 35;
    label.x = 0;
    label.y = 64 - label.height;
    
    // 5.添加到导航控制器的view
    //    [self.navigationController.view addSubview:label];
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    
    // 6.动画
    CGFloat duration = 0.75;
    label.alpha = 0.0;
    [UIView animateWithDuration:duration animations:^{
        // 往下移动一个label的高度
        label.transform = CGAffineTransformMakeTranslation(0, label.height);
        label.alpha = 1.0;
    } completion:^(BOOL finished) { // 向下移动完毕
        
        // 延迟delay秒后，再执行动画
        CGFloat delay = 1.0;
        
        [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            // 恢复到原来的位置
            label.transform = CGAffineTransformIdentity;
            label.alpha = 0.0;
            
        } completion:^(BOOL finished) {
            
            // 删除控件
            [label removeFromSuperview];
        }];
    }];
    /**
     UIViewAnimationOptionCurveEaseInOut            = 0 << 16, // 开始：由慢到快，结束：由快到慢
     UIViewAnimationOptionCurveEaseIn               = 1 << 16, // 由慢到块
     UIViewAnimationOptionCurveEaseOut              = 2 << 16, // 由快到慢
     UIViewAnimationOptionCurveLinear               = 3 << 16, // 线性，匀速
     */
}

/**
 *  加载旧的微博数据
 */
- (void)loadMoreStatus
{
    // 1. 封装请求参数
    NBHomeStatusesParam *param = [NBHomeStatusesParam param];
    NBStatusFrame *lastStatusFrame = [self.statusFrames lastObject];
    NBStatus *lastStatus = lastStatusFrame.status;
    if (lastStatus) {
        param.max_id = @([lastStatus.idstr longLongValue] - 1);
    }
    // 2. 发送GET请求
    [NBStatusTool homeStatusesWithParam:param success:^(NBHomeStatusesResult *result) {
        // 获得时间比较久的微博数组
        NSArray *oldStatuses = [self statusFramesWithStatuses:result.statuses];
        // 将旧数据插入到新数据中
        [self.statusFrames addObjectsFromArray:oldStatuses];

        // 重新刷新表格
        [self.tableView reloadData];

        // 让刷新控件停止刷新（恢复默认的状态）
        [self.footer endRefreshing];
        
    } failure:^(NSError *error) {
        // 让刷新控件停止刷新（恢复默认的状态）
        [self.footer endRefreshing];
        NBLog(@"loadMoreStatus请求失败------%@", error);
    }];
}

- (void)refresh:(BOOL)fromSelf
{
    if (self.tabBarItem.badgeValue) { // 有数字
        // 让表格回到最顶部
//        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
        
        // 转圈圈
        [self.refreshcontrol beginRefreshing];
        
        // 加载最新微博
        [self loadNewStatuses:self.refreshcontrol];
        
    }else if (fromSelf) {  // 没有数字
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }

}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.statusFrames.count <= 0 || self.footer.isRefreshing) return;
//    NBLog(@"%.1f", scrollView.contentOffset.y);
    // 1.差距
    CGFloat delta = scrollView.contentSize.height - scrollView.contentOffset.y;
    // 刚好能完整看到footer的高度 self.tabBarController.tabBar.height == 49
    CGFloat sawFooterH = self.view.height - self.tabBarController.tabBar.height;
    
    // 2.如果能看见整个footer
    if (delta <= (sawFooterH - 0)) {
//        NBLog(@"看全了footer");
        // 进入上拉刷新状态
        [self.footer beginRefreshing];
    
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 加载更多的微博数据
            [self loadMoreStatus];
    });
    }
}

#pragma mark - NBPopMenuDelegate
- (void)popMenuDidDismissed:(NBPopMenu *)popMenu
{
    // 箭头改成向上
    NBTitleButton *titleButton = (NBTitleButton *)self.navigationItem.titleView;
    [titleButton setImage:[UIImage imageWithNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // 为什么这样设置？因为一开始加载的时候还没有数据，所以导致看到footer
    self.footer.hidden = (self.statusFrames.count == 0);
    return self.statusFrames.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NBStatusCell *cell = [NBStatusCell cellWithTableView:tableView];
    
    // 取出这行对应的微博
    NBStatusFrame *statusFrame = self.statusFrames[indexPath.row];
    cell.statusFrame = statusFrame;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = NBRandomColor;
    vc.title = @"新控制器";
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NBStatusFrame *statusFrame = self.statusFrames[indexPath.row];
    return statusFrame.cellHeight;
}
@end
