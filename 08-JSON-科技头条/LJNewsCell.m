//
//  LJNewsCell.m
//  08-JSON-科技头条
//
//  Created by JackLou on 6/18/16.
//  Copyright © 2016 JackLou. All rights reserved.
//

#import "LJNewsCell.h"
@interface LJNewsCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *summaryLabel;
@property (weak, nonatomic) IBOutlet UILabel *sitenameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *addTimeLabel;

@end
@implementation LJNewsCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setNewsModel:(LJNewsModel *)newsModel{
    _newsModel = newsModel;
    self.titleLabel.text = newsModel.title;
    self.summaryLabel.text = newsModel.summary;
    self.sitenameLabel.text = newsModel.sitename;
    self.iconImageView.image = [UIImage imageNamed:newsModel.img];
    self.addTimeLabel.text = [NSString stringWithFormat:@"%d",newsModel.addtime.intValue];
}

@end
