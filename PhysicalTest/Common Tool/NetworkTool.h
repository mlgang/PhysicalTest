//
//  NetworkTool.h
//  PhysicalTest
//
//  Created by jay on 2019/3/28.
//  Copyright © 2019 jay. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NetworkTool : NSObject

+ (void)loginWithName:(NSString *)name andPassword:(NSString *)pwd completionBlock:(void(^)(NSDictionary *dic))block;
+ (void)updateMyinfoWithArray:(NSMutableArray *)array completionBlock:(void(^)(NSDictionary *dic))block;
//通知
+ (void)getNotificationCompletionBlock:(void(^)(NSDictionary *dic))block;
//补考
+ (void)getRetestWithArray:(NSMutableArray *)array completionBlock:(void(^)(NSDictionary *dic))block;
//重考
+ (void)getNewTestWithArray:(NSMutableArray *)array completionBlock:(void(^)(NSDictionary *dic))block;
//体质评估
+ (void)getHealthTestResultWithArray:(NSMutableArray *)array completionBlock:(void(^)(NSDictionary *dic))block;
//排名
+ (void)getRankcompletionBlock:(void(^)(NSDictionary *dic))block;

@end

NS_ASSUME_NONNULL_END
