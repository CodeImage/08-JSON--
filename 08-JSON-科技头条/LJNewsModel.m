//
//  LJNewsModel.m
//  08-JSON-科技头条
//
//  Created by JackLou on 6/18/16.
//  Copyright © 2016 JackLou. All rights reserved.
//

#import "LJNewsModel.h"

@implementation LJNewsModel
+ (instancetype)newsModelWithDict:(NSDictionary *)dict{
    LJNewsModel *model = [LJNewsModel new];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}

+ (void)getNewsListFromURLWithSuccessBlock:(void (^)(LJNewsModel *))successBlock andErrorBlock:(void (^)())errorBlock{
    NSURL *url = [NSURL URLWithString:@"http://news.coolban.com/Api/Index/news_list/app/2/cat/0/limit/20/time/1466246716/type/0?channel=appstore&uuid=F4B71DC2-FF65-4333-B6F9-68C3F1328DB7&net=5&model=iPhone&ver=1.0.5"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if (connectionError) {
            NSLog(@"connect error");
            return;
        }
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if (httpResponse.statusCode == 200 || httpResponse.statusCode == 304) {
            id objResult = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:NULL];
            
            [objResult enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
              
                LJNewsModel *model = [LJNewsModel newsModelWithDict:obj];
                
                if (model) {
                    successBlock(model);
                }else{
                    errorBlock();
                }
                
            }];
            
            
        }else{
            NSLog(@"server error");
        }
    }];
}

// 重写不作任何操作，未定义的key就不会报错
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{

}
@end
