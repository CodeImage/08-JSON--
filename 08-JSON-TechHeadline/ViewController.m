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

    [LJNewsModel getNewsListFromURLWithSuccessBlock:^(NSArray *arr) {
        self.newsList = arr;
        
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
    LJNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"newsCell"];
    
    cell.newsModel = self.newsList[indexPath.row];
    
    return cell;
}
@end
