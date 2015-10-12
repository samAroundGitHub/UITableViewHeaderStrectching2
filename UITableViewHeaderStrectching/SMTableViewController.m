//
//  SMTableViewController.m
//  UITableViewHeaderStrectching
//
//  Created by zZZ on 15/10/12.
//  Copyright (c) 2015年 zZZ. All rights reserved.
//

#import "SMTableViewController.h"

@interface SMTableViewController ()

@property (nonatomic, strong) UIImageView *header;

@property (nonatomic, strong) UINavigationBar *navBar;

@property (nonatomic, assign) CGFloat inOffSet;

@end

@implementation SMTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.automaticallyAdjustsScrollViewInsets = NO;

    // 设置可伸缩图片一系列属性
    UIImage *img = [UIImage imageNamed:@"header"];
    UIImageView *header = [[UIImageView alloc] initWithImage:img];
    CGFloat width = self.tableView.frame.size.width;
    CGFloat height = width * 2 / 3;
    self.inOffSet = height;
    self.header = header;
    header.frame = CGRectMake(0, -height, width, height);
    [self.tableView addSubview:header];
//    self.tableView.tableHeaderView = header;
    self.tableView.contentInset = UIEdgeInsetsMake(self.inOffSet, 0, 0, 0);
    
    // 设置导航条
    UINavigationBar *bar = self.navigationController.navigationBar;
//    bar.barStyle = UIBarStyleBlack;
    [bar setBackgroundImage:[self createPureColorImageWithColor:[UIColor whiteColor] alpha:0 size:self.navigationController.view.frame.size] forBarMetrics:UIBarMetricsDefault];
    [bar setShadowImage:[[UIImage alloc] init]];
    self.navBar = bar;
        
}

// 滚动状态
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat yoffset = scrollView.contentOffset.y;
    CGFloat xoffset = (yoffset + self.inOffSet)/ 2;
    
    if (yoffset < -self.inOffSet) {
        CGFloat width = scrollView.frame.size.width;
        self.header.frame = CGRectMake(xoffset, yoffset, width - xoffset * 2, -yoffset);
    }
    
    CGFloat alpha = (self.inOffSet + yoffset) / self.inOffSet;
    UIImage *navImage = [self createPureColorImageWithColor:[UIColor whiteColor] alpha:alpha size:self.navigationController.view.frame.size];
    [self.navBar setBackgroundImage:navImage forBarMetrics:UIBarMetricsDefault];
}

// 生成纯色背景图
- (UIImage *)createPureColorImageWithColor:(UIColor *)color alpha:(CGFloat)alpha size:(CGSize)size
{
    // 纯色的UIView
    UIView *pureColorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    pureColorView.backgroundColor = color;
    pureColorView.alpha = alpha;
    
    // 由上下文获取UIImage
    UIGraphicsBeginImageContext(size);
    [pureColorView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *pureColorImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 结束上下文
    UIGraphicsEndImageContext();
    
    return pureColorImage;
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Return the number of rows in the section.
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 测试数据
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"测试数据 %ld", indexPath.row];
    
    return cell;
}

@end
