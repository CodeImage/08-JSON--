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
@property (nonatomic,strong) NSMutableArray<LJNewsModel *> *newsList;
@end

@implementation ViewController
- (NSMutableArray *)newsList{
    if (!_newsList) {
        _newsList = [NSMutableArray array];
    }
    return _newsList;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [LJNewsModel getNewsListFromURLWithSuccessBlock:^(LJNewsModel *model) {
        [self.newsList addObject:model];
        [self.tableView reloadData];
        
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
