//
//  ViewController.m
//  08-JSON-科技头条
//
//  Created by JackLou on 6/18/16.
//  Copyright © 2016 JackLou. All rights reserved.
//

#import "ViewController.h"
#import "LJNewsCell.h"
#import "LJNewsModel.h"

@interface ViewController ()
@property (nonatomic,strong) NSArray<LJNewsModel *> *newsList;
@end


@implementation ViewController

// 重写setter、getter，不生成带下划线的变量（老师没有懒加载，所以不存在这个问题）
@synthesize newsList = _newsList;

- (NSArray *)newsList{
    if (!_newsList) {
        _newsList = [NSArray array];
    }
    return _newsList;
}

- (void)setNewsList:(NSArray<LJNewsModel *> *)newsList{
    _newsList = newsList;
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];


    self.refreshControl.tintColor = [UIColor blueColor];
    
    self.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"正在努力加载中..." attributes:@{NSForegroundColorAttributeName:[UIColor greenColor]}];
    
    [self getnewsList];
    
}

// 下拉刷新监听方法（先在sb的控制器开启refreshing）
- (IBAction)didRefresh:(UIRefreshControl *)sender {
    
    [self getnewsList];
}

- (void)getnewsList{
    [LJNewsModel getNewsListFromURLWithSuccessBlock:^(NSArray *arr) {
        self.newsList = arr;
        
        // 第一次viewDidLoad并没开启refreshControl，停止没关系。
        [self.refreshControl endRefreshing];
    } andErrorBlock:^{
        NSLog(@"can't get news list");
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.newsList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    // 用这个，在第一次加载界面的时候，自定义cell的layoutSubviews里面计算的textWidth错误(用下面的就没问题)
//    LJNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"newsCell"];
    
//    LJNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"newsCell" forIndexPath:indexPath];
    
    LJNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:[LJNewsCell reuseIdentifierWithNewsModel:self.newsList[indexPath.row]] forIndexPath:indexPath];
    
    cell.newsModel = self.newsList[indexPath.row];
    
    return cell;
}
@end
