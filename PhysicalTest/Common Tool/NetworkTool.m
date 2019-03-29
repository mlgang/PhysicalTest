//
//  NetworkTool.m
//  PhysicalTest
//
//  Created by jay on 2019/3/28.
//  Copyright © 2019 jay. All rights reserved.
//

#import "NetworkTool.h"
#import <AFNetworking.h>

@implementation NetworkTool

+ (void)loginWithName:(NSString *)name andPassword:(NSString *)pwd completionBlock:(void(^)(NSDictionary *dic))block{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *URL = [NSString stringWithFormat:@"http://39.96.58.35:8000/login//%@//%@",name,pwd];
    [manager GET:URL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (block) {
            block((NSDictionary *)responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"fail");
    }];
}
+ (void)updateMyinfoWithArray:(NSMutableArray *)array completionBlock:(void(^)(NSDictionary *dic))block{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableString *URL = [NSMutableString stringWithFormat:@"http://39.96.58.35:8000/update/"];
    NSEnumerator *enumer = [array objectEnumerator];
    NSString *str;
    while (str = [enumer nextObject]) {
        [URL appendString:[NSString stringWithFormat:@"//%@",str]];
    }
    [manager GET:URL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (block) {
            block((NSDictionary *)responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"fail");
    }];
}
+ (void)getNotificationCompletionBlock:(void(^)(NSDictionary *dic))block{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *URL = @"http://39.96.58.35:8000/notification";
    [manager GET:URL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (block) {
            block((NSDictionary *)responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"fail");
    }];
}
//补考
+ (void)getRetestWithArray:(NSMutableArray *)array completionBlock:(void(^)(NSDictionary *dic))block{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *URL = @"http://39.96.58.35:8000/retest";
    [manager GET:URL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (block) {
            block((NSDictionary *)responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"fail");
    }];
}
//重考
+ (void)getNewTestWithArray:(NSMutableArray *)array completionBlock:(void(^)(NSDictionary *dic))block{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *URL = @"http://39.96.58.35:8000/newtest";
    [manager GET:URL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (block) {
            block((NSDictionary *)responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"fail");
    }];
}
//体质评估
+ (void)getHealthTestResultWithArray:(NSMutableArray *)array completionBlock:(void(^)(NSDictionary *dic))block{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *URL = @"http://39.96.58.35:8000/healthtest";
    [manager GET:URL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (block) {
            block((NSDictionary *)responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"fail");
    }];
}
//排名
+ (void)getRankcompletionBlock:(void(^)(NSDictionary *dic))block{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *URL = @"http://39.96.58.35:8000/rank";
    [manager GET:URL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (block) {
            block((NSDictionary *)responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"fail");
    }];
}
@end
