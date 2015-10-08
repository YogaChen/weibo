//
//  NBDiscoverController.m
//  weibo
//
//  Created by yoga on 15/8/24.
//  Copyright (c) 2015年 ioslearning. All rights reserved.
//

#import "NBDiscoverController.h"
#import "NBSearchBar.h"

@interface NBDiscoverController ()

@end

@implementation NBDiscoverController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 添加搜索框
    NBSearchBar *searchBar = [NBSearchBar searchBar];
    searchBar.width = 300;
    searchBar.height = 30;

        
    self.navigationItem.titleView = searchBar;
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 20;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"发现测试数据----%d", (int)indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = NBRandomColor;
    vc.title = @"新控制器";
    [self.navigationController pushViewController:vc animated:YES];
}

@end
