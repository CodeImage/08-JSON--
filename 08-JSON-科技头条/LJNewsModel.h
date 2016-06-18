//
//  LJNewsModel.h
//  08-JSON-科技头条
//
//  Created by JackLou on 6/18/16.
//  Copyright © 2016 JackLou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LJNewsModel : NSObject
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *summary;
@property (nonatomic,copy) NSString *img;
@property (nonatomic,copy) NSString *sitename;
@property (nonatomic,strong) NSNumber *addtime;
+ (instancetype)newsModelWithDict:(NSDictionary *)dict;

// 由于解析JSON可能耗时，是子线程，不能用返回值传数组，因为可能会卡很长时间，所以只能用block在解析完回调传数组
+ (void)getNewsListFromURLWithSuccessBlock:(void(^)(LJNewsModel *model))successBlock andErrorBlock:(void(^)())errorBlock;
@end
